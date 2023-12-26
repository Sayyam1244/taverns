import 'package:flutter/material.dart';
import '../../main.dart';
import '../../navigation/app_navigation.dart';
import 'login_and_signup_initial_params.dart';
import 'login_and_signup_page.dart';

class LoginAndSignupNavigator {}

mixin LoginAndSignupRoute {
  openLoginAndSignup(LoginAndSignupInitialParams initialParams) {
    navigator.push(
      context,
      LoginAndSignupPage(cubit: getIt(param1: initialParams)),
    );
  }

  AppNavigator get navigator;

  BuildContext get context;
}
