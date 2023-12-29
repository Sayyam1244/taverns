import 'package:flutter/material.dart';
import 'package:taverns/presentation/sign_up_successful/signup_success_full_initial_params.dart';
import 'package:taverns/presentation/sign_up_successful/signup_success_full_page.dart';
import 'package:taverns/presentation/tavern_dasboard/tavern_dashboard_navigator.dart';
import '../../main.dart';
import '../../navigation/app_navigation.dart';
class SignupSuccessFullNavigator with TavernDashboardRoute{
  @override
  late BuildContext  context ;

  @override
  final AppNavigator  navigator ;

  SignupSuccessFullNavigator(this.navigator);
}

mixin SignupSuccessFullRoute {
openSignupSuccessFull(SignupSuccessFullInitialParams initialParams) {
navigator.push(
context,
SignupSuccessFullPage(cubit: getIt(param1: initialParams)),
);
}

AppNavigator get navigator;

BuildContext get context;
}