import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taverns/presentation/login_and_signup/login_and_signup_initial_params.dart';
import 'package:taverns/presentation/welcome/welcome_navigator.dart';
import 'welcome_initial_params.dart';
import 'welcome_state.dart';

class WelcomeCubit extends Cubit<WelcomeState> {
  final WelcomeInitialParams initialParams;
  final WelcomeNavigator navigator;
  WelcomeCubit(this.initialParams, this.navigator)
      : super(WelcomeState.initial(initialParams: initialParams));

  void openLoginAndSignup() {
    navigator.openLoginAndSignup(LoginAndSignupInitialParams());
  }
}
