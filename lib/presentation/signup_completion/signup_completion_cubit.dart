import 'package:flutter_bloc/flutter_bloc.dart';
import 'signup_completion_initial_params.dart';
import 'signup_completion_state.dart';

class SignupCompletionCubit extends Cubit<SignupCompletionState> {
  final SignupCompletionInitialParams initialParams;

  SignupCompletionCubit(this.initialParams) : super(SignupCompletionState.initial(initialParams: initialParams));
}