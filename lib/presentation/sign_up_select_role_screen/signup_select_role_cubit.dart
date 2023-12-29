import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taverns/presentation/sign_up_select_role_screen/signup_select_role_navigator.dart';
import 'package:taverns/presentation/signup_completion/signup_completion_initial_params.dart';
import 'signup_select_role_initial_params.dart';
import 'signup_select_role_state.dart';

class SignupSelectRoleCubit extends Cubit<SignupSelectRoleState> {
  final SignupSelectRoleInitialParams initialParams;
  final SignupSelectRoleNavigator navigator;

  SignupSelectRoleCubit(this.initialParams, this.navigator) : super(SignupSelectRoleState.initial(initialParams: initialParams));

  changeRole(int i){
    emit(state.copyWith(selectedRoleIndex: i));
  }
  navigateToSignupCompletionScreen(){
    navigator.openSignupCompletion(SignupCompletionInitialParams());
  }
}