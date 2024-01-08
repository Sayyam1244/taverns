import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taverns/core/utils/flushbar.dart';
import 'package:taverns/presentation/notifications_email_screen/notification_settings_navigator.dart';
import 'package:taverns/presentation/sign_up_successful/signup_success_full_initial_params.dart';
import '../../domain/model/user_model.dart';
import '../../domain/repository/auth_repository.dart';
import '../../domain/repository/user_repository.dart';
import 'notification_settings_initial_params.dart';
import 'notification_settings_state.dart';

class NotificationSettingsCubit extends Cubit<NotificationSettingsState> {
  final NotificationSettingsInitialParams initialParams;
  final NotificationSettingsNavigator navigator;
  final UserRepository _user;
  final AuthRepository _auth;
  NotificationSettingsCubit(this.initialParams, this.navigator, this._user, this._auth) : super(NotificationSettingsState.initial(initialParams: initialParams));

  toggleLikeReview() {
    emit(state.copyWith(likeReviews: !state.likeReviews));
  }

  toggleEventsNearMe() {
    emit(state.copyWith(eventsNearMe: !state.eventsNearMe));
  }

  toggleTimeSLot() {
    emit(state.copyWith(timeSlots: !state.timeSlots));
  }

  saveNotificationSettings(context) async {
    UserModel userModel = UserModel(
      likeReview: state.likeReviews,
      eventsNearMe: state.eventsNearMe,
      timeSlotsRequests: state.timeSlots,
    );
    _user.updateFirestoreUser(_auth.currentUser().uid, userModel).then((value) {
      return value.fold(
          (l) => FlushbarDialogue().showErrorFlushbar(context: context, title: l.title, body: l.message), (r) => navigator.openSignupSuccessFull(SignupSuccessFullInitialParams()));
    });
  }
}
