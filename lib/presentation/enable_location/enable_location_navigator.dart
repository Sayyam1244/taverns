import 'package:flutter/material.dart';
import 'package:taverns/presentation/notifications_email_screen/notification_settings_navigator.dart';
import '../../main.dart';
import '../../navigation/app_navigation.dart';
import 'enable_location_initial_params.dart';
import 'enable_location_page.dart';

class EnableLocationNavigator with NotificationSettingsRoute{
  @override
  late BuildContext context ;

  @override
  final AppNavigator navigator ;

  EnableLocationNavigator(this.navigator);
}

mixin EnableLocationRoute {
openEnableLocation(EnableLocationInitialParams initialParams) {
navigator.push(
context,
EnableLocationPage(cubit: getIt(param1: initialParams)),
);
}

AppNavigator get navigator;

BuildContext get context;
}