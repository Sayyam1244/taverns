import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taverns/core/utils/flushbar.dart';
import 'package:taverns/domain/repository/auth_repository.dart';
import 'package:taverns/presentation/email_verification/email_verification_navigator.dart';
import 'package:taverns/presentation/sign_up_select_role_screen/signup_select_role_initial_params.dart';
import 'email_verification_initial_params.dart';
import 'email_verification_state.dart';

class EmailVerificationCubit extends Cubit<EmailVerificationState> {
  final EmailVerificationInitialParams initialParams;
  final EmailVerificationNavigator navigator;
  final AuthRepository _auth;
  EmailVerificationCubit(this.initialParams, this.navigator, this._auth) : super(EmailVerificationState.initial(initialParams: initialParams));

  Timer? time;
  Timer? t;

  void startCountdownTimer() {
    const duration = Duration(seconds: 1);
    Timer.periodic(duration, (Timer timer) {
      emit(state.copyWith(secondsRemaining: state.secondsRemaining - 1));

      if (state.secondsRemaining <= 0) {
        emit(state.copyWith(isCountdownComplete: true));
        timer.cancel();
      }
    });
  }

  listenTostateChanges() {
    t = Timer.periodic(const Duration(seconds: 1), (timer) {
      _auth.emailverificationStatusStream();
      if (_auth.currentUser().emailVerified) {
        navigator.openSignupSelectRole(SignupSelectRoleInitialParams());
        disposeTimers();
      }
    });
  }

  disposeTimers() {
    t?.cancel();
    time?.cancel();
  }

  resendVerificationEmail(context) {
    emit(state.copyWith(isVerificationEmailSend: true));
    if (!state.isVerificationEmailSend) {
      FlushbarDialogue().showFlushbar(context: context, title: 'Email Sent!', body: 'Verification email has been sent to your email address');
    } else {
      FlushbarDialogue().showFlushbar(context: context, title: 'Email already sent!', body: 'Verification email has already been sent to the email address you provided.');
    }
  }
}