import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taverns/domain/repository/auth_repository.dart';
import 'notifications_initial_params.dart';
import 'notifications_state.dart';

class NotificationsCubit extends Cubit<NotificationsState> {
  final NotificationsInitialParams initialParams;
  final AuthRepository auth;
  NotificationsCubit(this.initialParams, this.auth)
      : super(NotificationsState.initial(initialParams: initialParams));
}
