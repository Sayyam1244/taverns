import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taverns/domain/repository/auth_repository.dart';
import 'package:taverns/presentation/forgot_password_screen/forgot_password_navigator.dart';
import '../../core/utils/flushbar.dart';
import 'forgot_password_initial_params.dart';
import 'forgot_password_state.dart';

class ForgotPasswordCubit extends Cubit<ForgotPasswordState> {
  final ForgotPasswordInitialParams initialParams;
  final ForgotPasswordNavigator navigator;
  final AuthRepository _auth;
  ForgotPasswordCubit(this.initialParams, this.navigator, this._auth) : super(ForgotPasswordState.initial(initialParams: initialParams));

  void navigateBack() {
    navigator.navigatePop();
  }

  sendPasswordResetEmail(context, String email) async {
    await _auth.emailtoResetPassword(email: email);
    await FlushbarDialogue().showFlushbar(context: context, title: "Password reset", body: 'Email has been set to reset your password');
  }
}
