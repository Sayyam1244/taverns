import 'signup_select_role_initial_params.dart';

class SignupSelectRoleState {
  final int selectedRoleIndex;
  const SignupSelectRoleState({required this.selectedRoleIndex});

  factory SignupSelectRoleState.initial({required SignupSelectRoleInitialParams initialParams}) => SignupSelectRoleState(
        selectedRoleIndex: 0,
      );

  SignupSelectRoleState copyWith({int? selectedRoleIndex}) => SignupSelectRoleState(selectedRoleIndex: selectedRoleIndex ?? this.selectedRoleIndex);
}
