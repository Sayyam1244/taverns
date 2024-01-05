import 'package:flutter/material.dart';
import 'package:taverns/presentation/notification_board/notification_board_navigator.dart';
import '../../main.dart';
import '../../navigation/app_navigation.dart';
import 'tavern_dashboard_initial_params.dart';
import 'tavern_dashboard_page.dart';

class TavernDashboardNavigator with NotificationBoardRoute{
   @override
  late BuildContext  context ;

  @override
  final AppNavigator  navigator ;

  TavernDashboardNavigator(this.navigator);
}
mixin TavernDashboardRoute {
  openTavernDashboard(TavernDashboardInitialParams initialParams) {
    navigator.push(
      context,
      TavernDashboardPage(cubit: getIt(param1: initialParams)),
    );
  }

  AppNavigator get navigator;

  BuildContext get context;
}
