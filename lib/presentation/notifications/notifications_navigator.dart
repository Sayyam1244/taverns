import 'package:flutter/material.dart';
import 'package:taverns/presentation/event_detail/event_detail_navigator.dart';
import '../../main.dart';
import '../../navigation/app_navigation.dart';
import 'notifications_initial_params.dart';
import 'notifications_page.dart';

class NotificationsNavigator with EventDetailRoute {
  @override
  late BuildContext context;

  @override
  final AppNavigator navigator;

  NotificationsNavigator(this.navigator);
}

mixin NotificationsRoute {
  openNotifications(NotificationsInitialParams initialParams) {
    navigator.push(
      context,
      NotificationsPage(cubit: getIt(param1: initialParams)),
    );
  }

  AppNavigator get navigator;

  BuildContext get context;
}
