import 'email_verification_initial_params.dart';

class EmailVerificationState {
  final EmailVerificationInitialParams initialParams;
  final int secondsRemaining;
  final bool isCountdownComplete;
  final bool isVerificationEmailSend;
  
  const EmailVerificationState({
    required this.initialParams,
    required this.secondsRemaining,
    required this.isCountdownComplete,
    required this.isVerificationEmailSend
  });

  factory EmailVerificationState.initial({required EmailVerificationInitialParams initialParams}) {
    return EmailVerificationState(
      initialParams: initialParams,
      secondsRemaining: 60,
      isCountdownComplete: false,
      isVerificationEmailSend: false
    );
  }

  EmailVerificationState copyWith({
    EmailVerificationInitialParams? initialParams,
    int? secondsRemaining,
    bool? isCountdownComplete,
    bool? isVerificationEmailSend
  }) {
    return EmailVerificationState(
      initialParams: initialParams ?? this.initialParams,
      secondsRemaining: secondsRemaining ?? this.secondsRemaining,
      isCountdownComplete: isCountdownComplete ?? this.isCountdownComplete,
      isVerificationEmailSend: isVerificationEmailSend ?? this.isVerificationEmailSend
    );
  }
}
