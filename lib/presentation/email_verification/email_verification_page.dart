import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taverns/core/app_export.dart';
import 'package:taverns/widgets/custom_elevated_button.dart';
import 'email_verification_cubit.dart';
import 'email_verification_state.dart';

class EmailVerificationPage extends StatefulWidget {
  final EmailVerificationCubit cubit;

  const EmailVerificationPage({
    Key? key,
    required this.cubit,
  }) : super(key: key);

  @override
  State<EmailVerificationPage> createState() => _EmailVerificationState();
}

class _EmailVerificationState extends State<EmailVerificationPage> {
  EmailVerificationCubit get cubit => widget.cubit;

  @override
  void initState() {
    super.initState();
    cubit.navigator.context = context;
    cubit.startCountdownTimer();
    cubit.listenTostateChanges();
  }

  @override
  void dispose() {
    cubit.disposeTimers();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          width: double.maxFinite,
          padding: EdgeInsets.only(
            left: 18.h,
            top: 30.v,
            right: 18.h,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // CustomImageView(
              //   imagePath: ImageConstant.img132468245191079,
              //   height: 309.adaptSize,
              //   width: 309.adaptSize,
              //   alignment: Alignment.center,
              // ),
              SizedBox(height: 43.v),
              Text(
                "Email Sent!",
                style: theme.textTheme.headlineLarge,
              ),
              SizedBox(height: 7.v),
              Text(
                "An email has been to verify your email, kindly check your email.",
                style: theme.textTheme.bodyLarge!.copyWith(
                  height: 1.50,
                ),
              ),

              SizedBox(height: 5.v),
            ],
          ),
        ),
        bottomNavigationBar: BlocBuilder<EmailVerificationCubit, EmailVerificationState>(
          bloc: cubit,
          builder: (ctx, state) => CustomElevatedButton(
            onPressed: () {
              cubit.resendVerificationEmail(context);
            },
            text: state.isVerificationEmailSend
                ? 'Sent!'
                : state.isCountdownComplete
                    ? "Resend"
                    : "Resend in ${state.secondsRemaining}",
            margin: EdgeInsets.only(
              left: 18.h,
              right: 18.h,
              bottom: 15.v,
            ),
          ),
        ),
      ),
    );
  }
}
