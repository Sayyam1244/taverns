import 'package:flutter_bloc/flutter_bloc.dart';
import 'login_and_signup_initial_params.dart';
import 'login_and_signup_state.dart';

class LoginAndSignupCubit extends Cubit<LoginAndSignupState> {
  final LoginAndSignupInitialParams initialParams;

  LoginAndSignupCubit(this.initialParams)
      : super(LoginAndSignupState.initial(initialParams: initialParams));
}
