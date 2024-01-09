import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taverns/domain/repository/auth_repository.dart';
import 'package:taverns/domain/repository/events_repository.dart';
import 'package:taverns/domain/repository/user_repository.dart';
import 'package:taverns/presentation/notification_board/notification_board_initial_params.dart';
import 'package:taverns/presentation/tavern_dasboard/tavern_dashboard_navigator.dart';
import '../../core/utils/flushbar.dart';
import 'tavern_dashboard_initial_params.dart';
import 'tavern_dashboard_state.dart';

class TavernDashboardCubit extends Cubit<TavernDashboardState> {
  final TavernDashboardInitialParams initialParams;
  final TavernDashboardNavigator navigator;
  final AuthRepository auth;
  final UserRepository _user;
  final EventRepository events;
  TavernDashboardCubit(this.initialParams, this.navigator, this.auth, this._user, this.events)
      : super(
          TavernDashboardState.initial(
            initialParams: initialParams,
          ),
        );

  void navigateToNotificaitonBoard() {
    log("name " + state.user.businessName.toString());

    navigator.openNotificationBoard(NotificationBoardInitialParams(userModel: state.user));
  }

  update(int i) {
    emit(state.copyWith(currentIndex: i));
  }

  getUserData(context) async {
    _user.getUser(auth.currentUser().uid).then((value) {
      return value.fold(
        (l) => FlushbarDialogue().showErrorFlushbar(context: context, title: l.title, body: l.message),
        (r) {
          log("name " + r.businessName.toString());
          emit(state.copyWith(user: r, isloading: false));
        },
      );
    });
  }

  void updateDates(DateTime selectedDay, DateTime focusedDay) {
    emit(state.copyWith(selectedDay: selectedDay, focusedDay: focusedDay));
  }
}
