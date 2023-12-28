import 'package:flutter/material.dart';
import 'package:taverns/presentation/signup_completion/signup_completion_page.dart';
import '../../main.dart';
import '../../navigation/app_navigation.dart';
import 'signup_completion_initial_params.dart';

class SignupCompletionNavigator  {
  @override
  late BuildContext context;

  @override
  final AppNavigator navigator;

  SignupCompletionNavigator(this.navigator);
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