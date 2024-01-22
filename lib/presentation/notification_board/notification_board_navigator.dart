import 'package:flutter/material.dart';
import 'package:taverns/presentation/pulls_nearby_businesses/pull_nearby_businesses_navigator.dart';
import 'package:taverns/presentation/tavern_dasboard/tavern_dashboard_navigator.dart';
import '../../main.dart';
import '../../navigation/app_navigation.dart';
import 'notification_board_initial_params.dart';
import 'notification_board_page.dart';

class NotificationBoardNavigator with PullNearbyBusinessesRoute {
  @override
  late BuildContext context;

  @override
  final AppNavigator navigator;

  NotificationBoardNavigator(this.navigator);
}

mixin NotificationBoardRoute {
  openNotificationBoard(NotificationBoardInitialParams initialParams) {
    navigator.push(
      context,
      NotificationBoardPage(cubit: getIt(param1: initialParams)),
    );
  }

  openAndRemoveCurrentNotificationBoard(
      NotificationBoardInitialParams initialParams) {
    navigator.pushAndRemoveCurrentOnly(
      context,
      NotificationBoardPage(cubit: getIt(param1: initialParams)),
    );
  }

  AppNavigator get navigator;

  BuildContext get context;
}
