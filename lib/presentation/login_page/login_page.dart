import 'package:flutter/material.dart';
import 'package:taverns/core/app_export.dart';
import 'package:taverns/widgets/custom_checkbox_button.dart';
import 'package:taverns/widgets/custom_elevated_button.dart';
import 'package:taverns/widgets/custom_text_form_field.dart';

// ignore_for_file: must_be_immutable
class LoginPage extends StatefulWidget {
  const LoginPage({Key? key})
      : super(
          key: key,
        );

  @override
  LoginPageState createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage>
    with AutomaticKeepAliveClientMixin<LoginPage> {
  TextEditingController userNameController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  bool rememberMe = false;

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  bool get wantKeepAlive => true;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Form(
          key: _formKey,
          child: Container(
            width: double.maxFinite,
            decoration: AppDecoration.fillOnErrorContainer,
            child: Column(
              children: [
                SizedBox(height: 24.v),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24.h),
                  child: Column(
                    children: [
                      _buildLoginForm(context),
                      SizedBox(height: 157.v),
                      CustomElevatedButton(
                        text: "Log in",
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// Section Widget
  Widget _buildLoginForm(BuildContext context) {
    return Column(
      children: [
        CustomTextFormField(
          controller: userNameController,
          hintText: "Username ",
          prefix: Container(
            margin: EdgeInsets.fromLTRB(16.h, 16.v, 12.h, 16.v),
            child: CustomImageView(
              imagePath: ImageConstant.user,
              height: 24.adaptSize,
              width: 24.adaptSize,
            ),
          ),
          prefixConstraints: BoxConstraints(
            maxHeight: 56.v,
          ),
        ),
        SizedBox(height: 16.v),
        CustomTextFormField(
          controller: passwordController,
          hintText: "Password",
          textInputAction: TextInputAction.done,
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
            child: CustomImageView(
              imagePath: ImageConstant.imgIconEyeoff,
              height: 24.adaptSize,
              width: 24.adaptSize,
            ),
          ),
          suffixConstraints: BoxConstraints(
            maxHeight: 56.v,
          ),
          obscureText: true,
          contentPadding: EdgeInsets.symmetric(vertical: 14.v),
        ),
        SizedBox(height: 14.v),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: EdgeInsets.only(bottom: 1.v),
              child: CustomCheckboxButton(
                text: "Remember me",
                isExpandedText: true,
                value: rememberMe,
                onChange: (value) {
                  rememberMe = value;
                },
              ),
            ),
            Text(
              "Forgot Password?",
              style: CustomTextStyles.titleSmallPrimary.copyWith(
                decoration: TextDecoration.underline,
              ),
            ),
          ],
        ),
        SizedBox(height: 25.v),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 12.h),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Padding(
                padding: EdgeInsets.only(
                  top: 9.v,
                  bottom: 7.v,
                ),
                child: SizedBox(
                  width: 86.h,
                  child: Divider(),
                ),
              ),
              Text(
                "or continue with",
                style: CustomTextStyles.titleSmallMulishGray800,
              ),
              Padding(
                padding: EdgeInsets.only(
                  top: 9.v,
                  bottom: 7.v,
                ),
                child: SizedBox(
                  width: 86.h,
                  child: Divider(),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 20.v),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 14.h),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: CustomElevatedButton(
                  height: 38.v,
                  text: "Google",
                  margin: EdgeInsets.only(right: 8.h),
                  leftIcon: Container(
                    margin: EdgeInsets.only(right: 8.h),
                    child: CustomImageView(
                      imagePath: ImageConstant.imgFlatcoloriconsgoogle,
                      height: 16.adaptSize,
                      width: 16.adaptSize,
                    ),
                  ),
                  buttonStyle: CustomButtonStyles.fillYellow,
                  buttonTextStyle: CustomTextStyles.titleSmallMulishBluegray700,
                ),
              ),
              Expanded(
                child: CustomElevatedButton(
                  height: 38.v,
                  text: "Facebook",
                  margin: EdgeInsets.only(left: 8.h),
                  leftIcon: Container(
                    margin: EdgeInsets.only(right: 8.h),
                    child: CustomImageView(
                      imagePath: ImageConstant.imgFrame,
                      height: 16.adaptSize,
                      width: 16.adaptSize,
                    ),
                  ),
                  buttonStyle: CustomButtonStyles.fillYellow,
                  buttonTextStyle: CustomTextStyles.titleSmallMulishBluegray700,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
