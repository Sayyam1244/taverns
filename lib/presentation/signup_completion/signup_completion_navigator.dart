import 'package:flutter/material.dart';
import 'package:taverns/presentation/enable_location/enable_location_navigator.dart';
import 'package:taverns/presentation/signup_completion/signup_completion_page.dart';
import '../../main.dart';
import '../../navigation/app_navigation.dart';
import 'signup_completion_initial_params.dart';

class SignupCompletionNavigator with EnableLocationRoute {
  @override
  late BuildContext context;

  @override
  final AppNavigator navigator;

  SignupCompletionNavigator(this.navigator);

  openSignupCompletion(
      SignupCompletionInitialParams signupCompletionInitialParams) {}
}

mixin SignupCompletionRoute {
  openSignupCompletion(SignupCompletionInitialParams initialParams) {
    navigator.push(
      context,
      SignupCompletionPage(cubit: getIt(param1: initialParams)),
    );
  }

  AppNavigator get navigator;

  BuildContext get context;
}
