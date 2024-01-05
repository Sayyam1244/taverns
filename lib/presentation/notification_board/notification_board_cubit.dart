import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taverns/presentation/notification_board/notification_board_navigator.dart';
import 'notification_board_initial_params.dart';
import 'notification_board_state.dart';

class NotificationBoardCubit extends Cubit<NotificationBoardState> {
  final NotificationBoardInitialParams initialParams;
  final NotificationBoardNavigator navigator;
  NotificationBoardCubit(this.initialParams, this.navigator)
      : super(
          NotificationBoardState.initial(
            initialParams: initialParams,
          ),
        );
  changeIndex(int i) {
    emit(state.copyWith(index: i));
  }
}
