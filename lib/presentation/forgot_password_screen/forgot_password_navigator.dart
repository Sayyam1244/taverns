import 'package:flutter/material.dart';
import 'package:taverns/presentation/forgot_password_screen/forgot_password_initial_params.dart';
import '../../main.dart';
import '../../navigation/app_navigation.dart';
import 'forgot_password_page.dart';

class ForgotPasswordNavigator {
  @override
  late  BuildContext context ;

  @override
  final AppNavigator navigator ;

  ForgotPasswordNavigator(this.navigator);

  navigatePop(){
    navigator.navigateBack(context);
  }
}

mixin ForgotPasswordRoute {
  openForgotPassword(ForgotPasswordInitialParams initialParams) {
    navigator.push(
      context,
      ForgotPasswordPage(cubit: getIt(param1: initialParams)),
    );
  }

  AppNavigator get navigator;

  BuildContext get context;
}
