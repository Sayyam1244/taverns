import 'package:taverns/domain/model/notification_model.dart';

import 'notifications_initial_params.dart';

class NotificationsState {
  final bool isLoading;
  final List<NotificationModel> notifications;
  const NotificationsState({
    required this.isLoading,
    required this.notifications,
  });

  factory NotificationsState.initial(
          {required NotificationsInitialParams initialParams}) =>
      NotificationsState(isLoading: false, notifications: [
        NotificationModel(
          sender: 'Saifoo Tavern',
          notification:
              'Your request for Balo Tavern game has been confirmed by Saifoo1234',
          createdDate: DateTime.now(),
        )
      ]);

  NotificationsState copyWith(
          {bool? isLoading, List<NotificationModel>? notifications}) =>
      NotificationsState(
        isLoading: isLoading ?? this.isLoading,
        notifications: notifications ?? this.notifications,
      );
}
