import 'package:flutter/material.dart';
import 'package:taverns/presentation/search_event/search_event_initial_params.dart';
import 'package:taverns/presentation/search_event/search_event_page.dart';
import '../../main.dart';
import '../../navigation/app_navigation.dart';

class SearchEventNavigator {}

mixin SearchEventRoute {
  openSearchEvent(SearchEventInitialParams initialParams) {
    navigator.push(
      context,
      SearchEventPage(cubit: getIt(param1: initialParams)),
    );
  }

  AppNavigator get navigator;

  BuildContext get context;
}
