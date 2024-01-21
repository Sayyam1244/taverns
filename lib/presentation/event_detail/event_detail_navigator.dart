import 'package:flutter/material.dart';
import '../../main.dart';
import '../../navigation/app_navigation.dart';
import 'event_detail_initial_params.dart';
import 'event_detail_page.dart';

class EventDetailNavigator {}

mixin EventDetailRoute {
  openEventDetail(EventDetailInitialParams initialParams) {
    navigator.push(
      context,
      EventDetailPage(cubit: getIt(param1: initialParams)),
    );
  }

  AppNavigator get navigator;

  BuildContext get context;
}
