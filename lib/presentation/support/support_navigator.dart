import 'package:flutter/material.dart';
import 'package:taverns/presentation/support/support_initial_params.dart';
import 'package:taverns/presentation/support/support_page.dart';
import '../../main.dart';
import '../../navigation/app_navigation.dart';

class SupportNavigator {}

mixin SupportRoute {
  openSupport(SupportInitialParams initialParams) {
    navigator.push(
      context,
      SupportPage(cubit: getIt(param1: initialParams)),
    );
  }

  AppNavigator get navigator;

  BuildContext get context;
}
