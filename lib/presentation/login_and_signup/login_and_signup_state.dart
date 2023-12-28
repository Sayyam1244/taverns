import 'login_and_signup_initial_params.dart';

class LoginAndSignupState {
  final String email;
  final String password;
  final bool rememberMe;
  

  const LoginAndSignupState(
      {required this.email, required this.password, required this.rememberMe});
  factory LoginAndSignupState.initial(
          {required LoginAndSignupInitialParams initialParams}) =>
      LoginAndSignupState(email: '', password: '', rememberMe: false);

  LoginAndSignupState copyWith({
    String? email,
    String? password,
    bool? rememberMe,
  }) {
    return LoginAndSignupState(
        email: email ?? this.email,
        password: password ?? this.password,
        rememberMe: rememberMe ?? this.rememberMe,
      );
  }
}
