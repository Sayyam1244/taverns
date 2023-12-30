import 'login_and_signup_initial_params.dart';

class LoginAndSignupState {
  final String email;
  final String password;
  final bool termsAccepted;
  

  const LoginAndSignupState(
      {required this.email, required this.password, required this.termsAccepted});
  factory LoginAndSignupState.initial(
          {required LoginAndSignupInitialParams initialParams}) =>
      LoginAndSignupState(email: '', password: '', termsAccepted: false);

  LoginAndSignupState copyWith({
    String? email,
    String? password,
    bool? termsAccepted,
  }) {
    return LoginAndSignupState(
        email: email ?? this.email,
        password: password ?? this.password,
        termsAccepted: termsAccepted ?? this.termsAccepted,
      );
  }
}
