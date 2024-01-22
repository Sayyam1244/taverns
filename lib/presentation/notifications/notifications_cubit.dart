import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taverns/domain/repository/auth_repository.dart';
import 'package:taverns/domain/repository/notification_repository.dart';
import 'package:taverns/presentation/event_detail/event_detail_initial_params.dart';
import 'package:taverns/presentation/notifications/notifications_navigator.dart';
import 'notifications_initial_params.dart';
import 'notifications_state.dart';

class NotificationsCubit extends Cubit<NotificationsState> {
  final NotificationsInitialParams initialParams;
  final AuthRepository auth;
  final NotificationRepository notification;
  final NotificationsNavigator navigator;
  NotificationsCubit(
      this.initialParams, this.auth, this.notification, this.navigator)
      : super(NotificationsState.initial(initialParams: initialParams));

  void navigateToEventDetailScreen({String? eventId}) {
    navigator.openEventDetail(EventDetailInitialParams(eventId!));
  }
}
