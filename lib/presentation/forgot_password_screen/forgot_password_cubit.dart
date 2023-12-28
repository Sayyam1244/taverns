import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taverns/presentation/forgot_password_screen/forgot_password_navigator.dart';
import 'forgot_password_initial_params.dart';
import 'forgot_password_state.dart';

class ForgotPasswordCubit extends Cubit<ForgotPasswordState> {
  final ForgotPasswordInitialParams initialParams;
  final ForgotPasswordNavigator navigator;
  ForgotPasswordCubit(this.initialParams, this.navigator) : super(ForgotPasswordState.initial(initialParams: initialParams));

  void navigateBack() {
    navigator.navigatePop();
  }
}