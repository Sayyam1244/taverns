import 'package:flutter/material.dart';
import 'package:taverns/presentation/notification_board/notification_board_navigator.dart';
import 'package:taverns/presentation/pulls_nearby_businesses/pull_nearby_businesses_initial_params.dart';
import 'package:taverns/presentation/pulls_nearby_businesses/pull_nearby_businesses_page.dart';
import '../../main.dart';
import '../../navigation/app_navigation.dart';

class PullNearbyBusinessesNavigator with NotificationBoardRoute {
  @override
  late BuildContext context;

  @override
  final AppNavigator navigator;

  PullNearbyBusinessesNavigator(this.navigator);
}

mixin PullNearbyBusinessesRoute {
  openPullNearbyBusinesses(PullNearbyBusinessesInitialParams initialParams) {
    navigator.push(
      context,
      PullNearbyBusinessesPage(cubit: getIt(param1: initialParams)),
    );
  }

  openAndRemoveCurrentPullNearbyBusinesses(
      PullNearbyBusinessesInitialParams initialParams) {
    navigator.pushAndRemoveCurrentOnly(
      context,
      PullNearbyBusinessesPage(cubit: getIt(param1: initialParams)),
    );
  }

  AppNavigator get navigator;

  BuildContext get context;
}
