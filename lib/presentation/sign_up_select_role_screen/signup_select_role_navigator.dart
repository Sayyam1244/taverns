import 'package:flutter/material.dart';
import 'package:taverns/presentation/signup_completion/signup_completion_navigator.dart';
import '../../main.dart';
import '../../navigation/app_navigation.dart';
import 'signup_select_role_initial_params.dart';
import 'signup_select_role_page.dart';

class SignupSelectRoleNavigator with SignupCompletionRoute{
  @override
  late BuildContext  context ;

  @override
  final AppNavigator  navigator ;

  SignupSelectRoleNavigator(this.navigator);
}

mixin SignupSelectRoleRoute {
  openSignupSelectRole(SignupSelectRoleInitialParams initialParams) {
    navigator.push(
      context,
      SignupSelectRolePage(cubit: getIt(param1: initialParams)),
    );
  }

  AppNavigator get navigator;

  BuildContext get context;
}
