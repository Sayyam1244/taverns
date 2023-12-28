import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taverns/presentation/forgot_password_screen/forgot_password_initial_params.dart';
import 'package:taverns/presentation/login_and_signup/login_and_signup_navigator.dart';
import 'package:taverns/presentation/sign_up_select_role_screen/signup_select_role_initial_params.dart';
import 'login_and_signup_initial_params.dart';
import 'login_and_signup_state.dart';

class LoginAndSignupCubit extends Cubit<LoginAndSignupState> {
  final LoginAndSignupInitialParams initialParams;
  final LoginAndSignupNavigator navigator;
  LoginAndSignupCubit(this.initialParams, this.navigator)
      : super(LoginAndSignupState.initial(initialParams: initialParams));

  void changeRememberMe(bool v) {
    emit(state.copyWith(rememberMe: v));
  }
  navigateToForgotScreen(){
    navigator.openForgotPassword(ForgotPasswordInitialParams());
  }
  navigateToSelectRoleScreen(){
    navigator.openSignupSelectRole(SignupSelectRoleInitialParams());
  }
}
