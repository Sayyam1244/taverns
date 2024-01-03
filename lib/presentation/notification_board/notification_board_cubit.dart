import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taverns/domain/repository/auth_repository.dart';
import 'package:taverns/domain/repository/user_repository.dart';
import 'package:taverns/presentation/notification_board/notification_board_navigator.dart';
import 'notification_board_initial_params.dart';
import 'notification_board_state.dart';

class NotificationBoardCubit extends Cubit<NotificationBoardState> {
  final NotificationBoardInitialParams initialParams;
  final NotificationBoardNavigator navigator;
  final AuthRepository _auth;
  final UserRepository _user;
  NotificationBoardCubit(this.initialParams, this.navigator, this._auth, this._user) : super(NotificationBoardState.initial(initialParams: initialParams));
}