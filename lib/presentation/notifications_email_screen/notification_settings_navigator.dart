import 'package:flutter/material.dart';
import 'package:taverns/presentation/notifications_email_screen/notification_settings_initial_params.dart';
import 'package:taverns/presentation/sign_up_successful/signup_success_full_navigator.dart';
import '../../main.dart';
import '../../navigation/app_navigation.dart';
import 'notification_settings_page.dart';

class NotificationSettingsNavigator with SignupSuccessFullRoute{
  @override
  late BuildContext  context ;

  @override
  final AppNavigator  navigator ;

  NotificationSettingsNavigator(this.navigator);
}


mixin NotificationSettingsRoute {
  openNotificationSettings(NotificationSettingsInitialParams initialParams) {
    navigator.push(
      context,
      NotificationSettingsPage(cubit: getIt(param1: initialParams)),
    );
  }

  AppNavigator get navigator;

  BuildContext get context;
}
