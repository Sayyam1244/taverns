import 'login_and_signup_initial_params.dart';

class LoginAndSignupState {
  final String email;
  final String password;
  final bool termsAccepted;
  final bool loginPassvisible;

  const LoginAndSignupState({required this.email, required this.password, required this.termsAccepted, required this.loginPassvisible});
  factory LoginAndSignupState.initial({required LoginAndSignupInitialParams initialParams}) =>
      LoginAndSignupState(email: '', password: '', termsAccepted: false, loginPassvisible: false);

  LoginAndSignupState copyWith({
    String? email,
    String? password,
    bool? termsAccepted,
    bool? loginPassvisible,
  }) {
    return LoginAndSignupState(
      email: email ?? this.email,
      password: password ?? this.password,
      termsAccepted: termsAccepted ?? this.termsAccepted,
      loginPassvisible: loginPassvisible ?? this.loginPassvisible,
    );
  }
}
