import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taverns/domain/repository/auth_repository.dart';
import 'package:taverns/domain/repository/user_repository.dart';
import 'package:taverns/presentation/notification_board/notification_board_initial_params.dart';
import 'package:taverns/presentation/tavern_dasboard/tavern_dashboard_navigator.dart';
import '../../core/utils/flushbar.dart';
import 'tavern_dashboard_initial_params.dart';
import 'tavern_dashboard_state.dart';

class TavernDashboardCubit extends Cubit<TavernDashboardState> {
  final TavernDashboardInitialParams initialParams;
  final TavernDashboardNavigator navigator;
  final AuthRepository _auth;
  final UserRepository _user;
  TavernDashboardCubit(this.initialParams, this.navigator, this._auth, this._user)
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
    _user.getUser(_auth.currentUser().uid).then((value) {
      return value.fold(
        (l) => FlushbarDialogue().showErrorFlushbar(context: context, title: l.title, body: l.message),
        (r) {
          log("name " + r.businessName.toString());
          emit(state.copyWith(user: r, isloading: false));
        },
      );
    });
  }
}
