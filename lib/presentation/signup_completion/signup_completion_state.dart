import 'signup_completion_initial_params.dart';

class SignupCompletionState {
  final bool isloading;
  const SignupCompletionState({required this.isloading});

  factory SignupCompletionState.initial({required SignupCompletionInitialParams initialParams}) => SignupCompletionState(
        isloading: false,
      );

  SignupCompletionState copyWith({bool? isloading}) => SignupCompletionState(
        isloading: isloading ?? this.isloading,
      );
}
