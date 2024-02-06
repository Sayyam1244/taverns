import 'package:flutter/material.dart';
import 'package:taverns/presentation/safety_tips/safety_tips_initial_params.dart';
import 'package:taverns/presentation/safety_tips/safety_tips_page.dart';
import '../../main.dart';
import '../../navigation/app_navigation.dart';

class SafetyTipsNavigator {}

mixin SafetyTipsRoute {
  openSafetyTips(SafetyTipsInitialParams initialParams) {
    navigator.push(
      context,
      SafetyTipsPage(cubit: getIt(param1: initialParams)),
    );
  }

  AppNavigator get navigator;

  BuildContext get context;
}
