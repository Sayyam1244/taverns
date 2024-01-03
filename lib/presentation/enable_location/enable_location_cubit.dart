import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taverns/domain/repository/location_repository.dart';
import 'package:taverns/presentation/enable_location/enable_location_navigator.dart';
import 'package:taverns/presentation/notifications_email_screen/notification_settings_initial_params.dart';
import '../../core/utils/flushbar.dart';
import '../../domain/model/user_model.dart';
import '../../domain/repository/auth_repository.dart';
import '../../domain/repository/user_repository.dart';
import 'enable_location_initial_params.dart';
import 'enable_location_state.dart';

class EnableLocationCubit extends Cubit<EnableLocationState> {
  final EnableLocationInitialParams initialParams;
  final EnableLocationNavigator navigator;
  final UserRepository _user;
  final AuthRepository _auth;
  final LocationRepository _location;
  EnableLocationCubit(this.initialParams, this.navigator, this._user,
      this._auth, this._location)
      : super(EnableLocationState.initial(initialParams: initialParams));


  saveUserLocation(context) async {
    _location.getCurrentlocation().then((value) {
      return value.fold(
          (l) => FlushbarDialogue().showErrorFlushbar(
              context: context, title: l.title, body: l.message), (r) {
        UserModel userModel = UserModel(
          lat: r.latitude.toString(),
          long: r.longitude.toString(),
        );
        _user
            .createFirestoreUser(_auth.currentUser().uid, userModel)
            .then((value) {
          return value.fold(
              (l) => FlushbarDialogue().showErrorFlushbar(
                  context: context, title: l.title, body: l.message),
              (r) => navigator.openNotificationSettings(
                  NotificationSettingsInitialParams()));
        });
      });
    });
  }
}
