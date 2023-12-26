import 'package:flutter/material.dart';
import 'package:taverns/presentation/splash/splash_page.dart';
import 'package:taverns/presentation/welcome/welcome_navigator.dart';
import '../../main.dart';
import '../../navigation/app_navigation.dart';
import 'splash_initial_params.dart';

class SplashNavigator with WelcomeRoute {
  @override
  late BuildContext context;

  @override
  final AppNavigator navigator;

  SplashNavigator(this.navigator);
}

mixin SplashRoute {
  openSplash(SplashInitialParams initialParams) {
    navigator.push(
      context,
      SplashPage(cubit: getIt(param1: initialParams)),
    );
  }

  AppNavigator get navigator;

  BuildContext get context;
}
