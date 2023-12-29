import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taverns/core/utils/flushbar.dart';
import 'package:taverns/domain/repository/auth_repository.dart';
import 'package:taverns/presentation/email_verification/email_verification_initial_params.dart';
import 'package:taverns/presentation/forgot_password_screen/forgot_password_initial_params.dart';
import 'package:taverns/presentation/login_and_signup/login_and_signup_navigator.dart';
import 'package:taverns/presentation/sign_up_select_role_screen/signup_select_role_initial_params.dart';
import 'package:taverns/presentation/tavern_dasboard/tavern_dashboard_initial_params.dart';
import 'login_and_signup_initial_params.dart';
import 'login_and_signup_state.dart';

class LoginAndSignupCubit extends Cubit<LoginAndSignupState> {
  final LoginAndSignupInitialParams initialParams;
  final LoginAndSignupNavigator navigator;
  final AuthRepository _auth;
  LoginAndSignupCubit(this.initialParams, this.navigator, this._auth)
      : super(LoginAndSignupState.initial(initialParams: initialParams));

  void changeTermsAccepted(bool v) {
    emit(state.copyWith(termsAccepted: v));
  }
  navigateToForgotScreen(){
    navigator.openForgotPassword(ForgotPasswordInitialParams());
  }
  navigateToSelectRoleScreen(){
    navigator.openSignupSelectRole(SignupSelectRoleInitialParams());
  }

  
  void signInWithEmail(String email, String password, context) async {
    await _auth.signInWithEmail(email, password).then(
          (value) => value.fold(
            (l) => FlushbarDialogue().showErrorFlushbar(
                context: context, title: l.title, body: l.message),
            (r) async {
              if (r.emailVerified) {
                await _auth.checkIfUserProfileOnboardingCompleted(r).then(
                      (value) => value.fold(
                        (l) => FlushbarDialogue().showErrorFlushbar(
                            context: context, title: l.title, body: l.message),
                        (r) {
                          log(r.toString());
                          if (r) {
                            log(_auth.currentUser().toString());
                            navigator.openTavernDashboard(TavernDashboardInitialParams());
                          } else {
                            navigator.openSignupSelectRole (SignupSelectRoleInitialParams());
                          }
                        },
                      ),
                    );
              } else {
                _auth.currentUser().sendEmailVerification();
                navigator   .openEmailVerification(EmailVerificationInitialParams());
              }
            },
          ),
        );
  }

  void signUpwithEmail(String email, String password, context) {
    _auth.signUpWithEmail(email, password).then((value) {
      return value.fold(
        (l) => FlushbarDialogue().showErrorFlushbar(context: context, title: l.title, body: l.message),
        (r)async {
          navigator.openSignupSelectRole(SignupSelectRoleInitialParams());
        });
    });
  }
}
