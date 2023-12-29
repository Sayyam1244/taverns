import 'package:flutter/material.dart';
import 'package:taverns/presentation/email_verification/email_verification_navigator.dart';
import 'package:taverns/presentation/forgot_password_screen/forgot_password_navigator.dart';
import 'package:taverns/presentation/sign_up_select_role_screen/signup_select_role_navigator.dart';
import 'package:taverns/presentation/tavern_dasboard/tavern_dashboard_navigator.dart';
import '../../main.dart';
import '../../navigation/app_navigation.dart';
import 'login_and_signup_initial_params.dart';
import 'login_and_signup_page.dart';

class LoginAndSignupNavigator with ForgotPasswordRoute,SignupSelectRoleRoute,TavernDashboardRoute,EmailVerificationRoute{
  @override
  late BuildContext  context ;

  @override
  final AppNavigator  navigator ;

  LoginAndSignupNavigator(this.navigator);
}

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
