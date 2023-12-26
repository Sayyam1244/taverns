import 'package:flutter/material.dart';
import 'package:taverns/core/app_export.dart';

import '../../../widgets/custom_text_form_field.dart';

class SignupWidget extends StatelessWidget {
  SignupWidget({Key? key, required this.email, required this.setPassword, required this.confirmPassword, required this.loginformKey}) : super(key: key);
  final TextEditingController email;
  final TextEditingController setPassword;
  final TextEditingController confirmPassword;
  final GlobalKey<FormState> loginformKey;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Form(
        key: loginformKey,
        child: ListView(
          physics: ClampingScrollPhysics(),
          children: [
            CustomTextFormField(
              controller: email,
              hintText: "Email",
              textInputAction: TextInputAction.next,
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
              validator: (value) {
                if (value == '' || value == null) {
                  return 'Invalid Email';
                }
              },
            ),
            SizedBox(height: 16.v),
            CustomTextFormField(
              controller: setPassword,
              hintText: "Set Password",
              textInputType: TextInputType.text,
              prefix: Container(
                margin: EdgeInsets.fromLTRB(16.h, 16.v, 12.h, 16.v),
                child: CustomImageView(
                  imagePath: ImageConstant.password,
                  height: 24.adaptSize,
                  width: 24.adaptSize,
                ),
              ),
              prefixConstraints: BoxConstraints(
                maxHeight: 56.v,
              ),
              suffixConstraints: BoxConstraints(
                maxHeight: 56.v,
              ),
              contentPadding: EdgeInsets.symmetric(vertical: 14.v),
            ),
            SizedBox(height: 16.v),
            CustomTextFormField(
              controller: confirmPassword,
              hintText: "Confirm Password",
              textInputType: TextInputType.text,
              prefix: Container(
                margin: EdgeInsets.fromLTRB(16.h, 16.v, 12.h, 16.v),
                child: CustomImageView(
                  imagePath: ImageConstant.password,
                  height: 24.adaptSize,
                  width: 24.adaptSize,
                ),
              ),
              prefixConstraints: BoxConstraints(
                maxHeight: 56.v,
              ),
              suffixConstraints: BoxConstraints(
                maxHeight: 56.v,
              ),
              contentPadding: EdgeInsets.symmetric(vertical: 14.v),
            ),
            SizedBox(height: 14.v),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Checkbox(
                    value: false,
                    checkColor: theme.colorScheme.onErrorContainer.withOpacity(1),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4),
                    ),
                    onChanged: (v) {}),
                SizedBox(width: 4.h),
                RichText(
                    text: TextSpan(text: 'Accept ', style: theme.textTheme.bodyMedium, children: [
                  TextSpan(
                    text: 'Terms of Service',
                    style: theme.textTheme.bodyMedium!.copyWith(decoration: TextDecoration.underline),
                  ),
                  TextSpan(text: ' and ', style: theme.textTheme.bodyMedium!),
                  TextSpan(
                    text: 'Privacy Policy',
                    style: theme.textTheme.bodyMedium!.copyWith(decoration: TextDecoration.underline),
                  )
                ])),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
