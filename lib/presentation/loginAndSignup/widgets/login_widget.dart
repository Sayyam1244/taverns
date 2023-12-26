import 'package:flutter/material.dart';
import 'package:taverns/core/app_export.dart';
import 'package:taverns/widgets/custom_text_form_field.dart';

class LoginWidget extends StatelessWidget {
  LoginWidget(
      {Key? key,
      required this.email,
      required this.password,
      required this.loginformKey})
      : super(key: key);
  final TextEditingController email;
  final TextEditingController password;
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
              controller: password,
              hintText: "Password",
              textInputType: TextInputType.visiblePassword,
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
              suffix: Container(
                  margin: EdgeInsets.fromLTRB(30.h, 16.v, 16.h, 16.v),
                  child: Icon(
                    Icons.visibility_off_outlined,
                    color: PrimaryColors().gray600,
                    size: 20.adaptSize,
                  )),
              suffixConstraints: BoxConstraints(
                maxHeight: 56.v,
              ),
              obscureText: true,
              contentPadding: EdgeInsets.symmetric(vertical: 14.v),
            ),
            SizedBox(height: 14.v),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Checkbox(
                    value: false,
                    checkColor:
                        theme.colorScheme.onErrorContainer.withOpacity(1),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4),
                    ),
                    onChanged: (v) {}),
                SizedBox(width: 4.h),
                Text("Remember me", style: theme.textTheme.bodyMedium),
                Spacer(),
                Text(
                  "Forgot Password?",
                  style: CustomTextStyles.titleSmallPrimary.copyWith(
                    decoration: TextDecoration.underline,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
