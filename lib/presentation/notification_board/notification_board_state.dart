import 'notification_board_initial_params.dart';

class NotificationBoardState {
  final int index;
  const NotificationBoardState({required this.index});

  factory NotificationBoardState.initial(
          {required NotificationBoardInitialParams initialParams}) =>
      NotificationBoardState(index: 0);

  NotificationBoardState copyWith({int? index}) =>
      NotificationBoardState(index: index ?? this.index);
}
