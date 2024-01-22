import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:taverns/domain/model/user_model.dart';
import 'package:taverns/domain/repository/events_repository.dart';
import 'package:taverns/domain/repository/location_repository.dart';
import 'package:taverns/domain/repository/user_repository.dart';
import 'package:taverns/presentation/notification_board/notification_board_initial_params.dart';
import 'package:taverns/presentation/pulls_nearby_businesses/pull_nearby_businesses_navigator.dart';
import '../../core/utils/flushbar.dart';
import 'pull_nearby_businesses_initial_params.dart';
import 'pull_nearby_businesses_state.dart';

class PullNearbyBusinessesCubit extends Cubit<PullNearbyBusinessesState> {
  final PullNearbyBusinessesInitialParams initialParams;
  final UserRepository user;
  final PullNearbyBusinessesNavigator navigator;
  final LocationRepository location;
  PullNearbyBusinessesCubit(
      this.initialParams, this.user, this.navigator, this.location)
      : super(PullNearbyBusinessesState.initial(initialParams: initialParams));

  getTaverns(context) async {
    await getUserLocation();
    await user.getUsersbyType(type: 'Tavern').then(
          (value) => value.fold(
            (l) => FlushbarDialogue().showErrorFlushbar(
                context: context, title: l.title, body: l.message),
            (r) {
              List<double> ls = r
                  .map((e) => Geolocator.distanceBetween(
                      state.latLng.latitude,
                      state.latLng.longitude,
                      double.parse(e.lat!),
                      double.parse(e.long!)))
                  .toList();

              emit(state.copyWith(taverns: r, distances: ls, isloading: false));
            },
          ),
        );
  }

  changeSelectedIndex(int i) {
    emit(state.copyWith(selectedIndex: i));
  }

  void confirmLocation() {
    UserModel userModel = UserModel();

    userModel.businessAddress =
        state.taverns[state.selectedIndex].businessAddress;
    userModel.businessName = state.taverns[state.selectedIndex].userName;

    navigator.openAndRemoveCurrentNotificationBoard(
      NotificationBoardInitialParams(
        userModel: initialParams.userModel,
        userModelForOtherTavern: userModel,
      ),
    );
  }

  getUserLocation() async {
    await location.getCurrentlocation().then((value) =>
        value.fold((l) => null, (r) => emit(state.copyWith(latLng: r))));
  }
}
