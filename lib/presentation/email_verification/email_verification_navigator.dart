import 'package:flutter/material.dart';
import 'package:taverns/presentation/email_verification/email_verification_initial_params.dart';
import 'package:taverns/presentation/sign_up_select_role_screen/signup_select_role_navigator.dart';
import '../../main.dart';
import '../../navigation/app_navigation.dart';
import 'email_verification_page.dart';
class EmailVerificationNavigator with SignupSelectRoleRoute {
  @override
  late BuildContext context ;

  @override
  final AppNavigator  navigator ;

  EmailVerificationNavigator(this.navigator);
}

mixin EmailVerificationRoute {
openEmailVerification(EmailVerificationInitialParams initialParams) {
navigator.push(
context,
EmailVerificationPage(cubit: getIt(param1: initialParams)),
);
}

AppNavigator get navigator;

BuildContext get context;
}