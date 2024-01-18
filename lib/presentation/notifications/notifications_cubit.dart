import 'package:flutter_bloc/flutter_bloc.dart';
import 'notifications_initial_params.dart';
import 'notifications_state.dart';

class NotificationsCubit extends Cubit<NotificationsState> {
  final NotificationsInitialParams initialParams;

  NotificationsCubit(this.initialParams) : super(NotificationsState.initial(initialParams: initialParams));
}