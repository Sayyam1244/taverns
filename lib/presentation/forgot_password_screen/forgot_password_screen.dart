import 'package:flutter/material.dart';
import 'package:taverns/core/app_export.dart';
import 'package:taverns/widgets/custom_elevated_button.dart';
import 'package:taverns/widgets/custom_text_form_field.dart';

class ForgotPasswordScreen extends StatelessWidget {
  ForgotPasswordScreen({Key? key})
      : super(
          key: key,
        );

  TextEditingController passwordController = TextEditingController();

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Form(
          key: _formKey,
          child: SizedBox(
            width: double.maxFinite,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 64.v,
                  width: double.maxFinite,
                  decoration: BoxDecoration(
                    color: theme.colorScheme.onErrorContainer.withOpacity(1),
                  ),
                ),
                SizedBox(height: 14.v),
                Padding(
                  padding: EdgeInsets.only(left: 24.h),
                  child: Text(
                    "Forgot password",
                    style: theme.textTheme.headlineSmall,
                  ),
                ),
                SizedBox(height: 7.v),
                Container(
                  width: 240.h,
                  margin: EdgeInsets.only(left: 24.h),
                  child: Text(
                    "Enter Email\rto reset your password.",
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: theme.textTheme.bodyLarge!.copyWith(
                      height: 1.50,
                    ),
                  ),
                ),
                SizedBox(height: 21.v),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24.h),
                  child: CustomTextFormField(
                    controller: passwordController,
                    hintText: "Email address",
                    textInputAction: TextInputAction.done,
                    textInputType: TextInputType.emailAddress,
                    alignment: Alignment.center,
                    prefix: Container(
                      margin: EdgeInsets.fromLTRB(16.h, 16.v, 12.h, 16.v),
                      child: CustomImageView(
                        imagePath: ImageConstant.email,
                        height: 24.adaptSize,
                        width: 24.adaptSize,
                      ),
                    ),
                    prefixConstraints: BoxConstraints(
                      maxHeight: 56.v,
                    ),
                  ),
                ),
                SizedBox(height: 27.v),
                CustomElevatedButton(
                  text: "Continue",
                  margin: EdgeInsets.symmetric(horizontal: 24.h),
                  alignment: Alignment.center,
                ),
                SizedBox(height: 5.v),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
