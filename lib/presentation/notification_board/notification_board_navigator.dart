import 'package:flutter/material.dart';
import '../../main.dart';
import '../../navigation/app_navigation.dart';
import 'notification_board_initial_params.dart';
import 'notification_board_page.dart';

class NotificationBoardNavigator {}

mixin NotificationBoardRoute {
openNotificationBoard(NotificationBoardInitialParams initialParams) {
navigator.push(
context,
NotificationBoardPage(cubit: getIt(param1: initialParams)),
);
}

AppNavigator get navigator;

BuildContext get context;
}