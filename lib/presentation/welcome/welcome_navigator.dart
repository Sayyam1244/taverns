import 'package:flutter/material.dart';
import 'package:taverns/presentation/login_and_signup/login_and_signup_navigator.dart';
import 'package:taverns/presentation/welcome/welcome_page.dart';
import '../../main.dart';
import '../../navigation/app_navigation.dart';
import 'welcome_initial_params.dart';

class WelcomeNavigator with LoginAndSignupRoute {
  @override
  late BuildContext context;

  @override
  final AppNavigator navigator;

  WelcomeNavigator(this.navigator);
}

mixin WelcomeRoute {
  openWelcome(WelcomeInitialParams initialParams) {
    navigator.push(
      context,
      WelcomePage(cubit: getIt(param1: initialParams)),
    );
  }

  AppNavigator get navigator;

  BuildContext get context;
}
