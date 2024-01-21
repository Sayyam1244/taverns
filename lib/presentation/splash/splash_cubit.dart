import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taverns/presentation/splash/splash_navigator.dart';
import 'package:taverns/presentation/welcome/welcome_initial_params.dart';
import 'splash_initial_params.dart';
import 'splash_state.dart';

class SplashCubit extends Cubit<SplashState> {
  final SplashInitialParams initialParams;
  final SplashNavigator navigator;
  SplashCubit(this.initialParams, this.navigator)
      : super(
          SplashState.initial(initialParams: initialParams),
        );

  navigateToWelcome() async {
    log('>>>>>>>>>>navigate to welcome');
    await Future.delayed(Duration(seconds: 3));
    navigator.openWelcome(WelcomeInitialParams());
    log('>>>>>>>>>>navigated');
  }
}
