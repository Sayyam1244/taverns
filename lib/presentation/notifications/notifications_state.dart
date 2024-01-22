import 'package:taverns/domain/model/notification_model.dart';

import 'notifications_initial_params.dart';

class NotificationsState {
  final bool isLoading;
  const NotificationsState({
    required this.isLoading,
  });

  factory NotificationsState.initial(
          {required NotificationsInitialParams initialParams}) =>
      NotificationsState(
        isLoading: false,
      );

  NotificationsState copyWith(
          {bool? isLoading, List<NotificationModel>? notifications}) =>
      NotificationsState(
        isLoading: isLoading ?? this.isLoading,
      );
}
