import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taverns/presentation/enable_location/enable_location_navigator.dart';
import 'package:taverns/presentation/notifications_email_screen/notification_settings_initial_params.dart';
import 'enable_location_initial_params.dart';
import 'enable_location_state.dart';

class EnableLocationCubit extends Cubit<EnableLocationState> {
  final EnableLocationInitialParams initialParams;
  final EnableLocationNavigator navigator;
  EnableLocationCubit(this.initialParams, this.navigator) : super(EnableLocationState.initial(initialParams: initialParams));

  void navigateToNotificationSetting() {
    navigator.openNotificationSettings(NotificationSettingsInitialParams());
  }
}