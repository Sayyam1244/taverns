import 'package:flutter/material.dart';
import 'package:taverns/core/app_export.dart';
import 'package:taverns/widgets/custom_checkbox_button.dart';
import 'package:taverns/widgets/custom_elevated_button.dart';
import 'package:taverns/widgets/custom_text_form_field.dart';

// ignore_for_file: must_be_immutable
class SignupPage extends StatefulWidget {
  const SignupPage({Key? key})
      : super(
          key: key,
        );

  @override
  SignupPageState createState() => SignupPageState();
}

class SignupPageState extends State<SignupPage>
    with AutomaticKeepAliveClientMixin<SignupPage> {
  TextEditingController emailController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  TextEditingController confirmpasswordController = TextEditingController();

  bool acceptTermsOfServiceAndPrivacy = false;

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
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 24.h),
                    child: Column(
                      children: [
                        _buildLoginForm(context),
                        Spacer(),
                        CustomElevatedButton(
                          text: "Next",
                        ),
                      ],
                    ),
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
        Container(
          padding: EdgeInsets.symmetric(
            horizontal: 15.h,
            vertical: 1.v,
          ),
          decoration: AppDecoration.outlinePrimary.copyWith(
            borderRadius: BorderRadiusStyle.roundedBorder16,
          ),
          child: Row(
            children: [
              CustomImageView(
                imagePath: ImageConstant.user,
                height: 24.adaptSize,
                width: 24.adaptSize,
                margin: EdgeInsets.symmetric(vertical: 13.v),
              ),
              Padding(
                padding: EdgeInsets.only(
                  left: 12.h,
                  bottom: 1.v,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 52.h,
                      child: Text(
                        "Username",
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: theme.textTheme.bodySmall!.copyWith(
                          height: 1.67,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 75.h,
                      child: RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: "Adam",
                              style: CustomTextStyles
                                  .titleMediumSecondaryContainerSemiBold_1,
                            ),
                            TextSpan(
                              text: "w",
                              style: CustomTextStyles
                                  .titleMediumSecondaryContainerSemiBold_1,
                            ),
                            TextSpan(
                              text: "ale",
                              style: CustomTextStyles
                                  .titleMediumSecondaryContainerSemiBold_1,
                            ),
                            TextSpan(
                              text: "|",
                              style: CustomTextStyles.titleMediumPrimary,
                            ),
                          ],
                        ),
                        textAlign: TextAlign.left,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 16.v),
        CustomTextFormField(
          controller: emailController,
          hintText: "Email address",
          textInputType: TextInputType.emailAddress,
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
        SizedBox(height: 16.v),
        CustomTextFormField(
          controller: passwordController,
          hintText: "Set Password",
          textInputType: TextInputType.visiblePassword,
          prefix: Container(
            margin: EdgeInsets.fromLTRB(16.h, 16.v, 12.h, 16.v),
            child: CustomImageView(
              imagePath: ImageConstant.imgLocationPrimary,
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
              imagePath: ImageConstant.imgIconEyeoffYellow50,
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
        SizedBox(height: 16.v),
        CustomTextFormField(
          controller: confirmpasswordController,
          hintText: "Confirm Password",
          textInputType: TextInputType.visiblePassword,
          prefix: Container(
            margin: EdgeInsets.fromLTRB(16.h, 16.v, 12.h, 16.v),
            child: CustomImageView(
              imagePath: ImageConstant.imgLocationPrimary,
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
              imagePath: ImageConstant.imgIconEyeoffYellow50,
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
        SizedBox(height: 22.v),
        Align(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: EdgeInsets.only(right: 75.h),
            child: CustomCheckboxButton(
              alignment: Alignment.centerLeft,
              text: "Accept Terms of Service and Privacy Policy",
              value: acceptTermsOfServiceAndPrivacy,
              padding: EdgeInsets.symmetric(vertical: 1.v),
              textStyle: CustomTextStyles.labelLargeGray60001,
              onChange: (value) {
                acceptTermsOfServiceAndPrivacy = value;
              },
            ),
          ),
        ),
      ],
    );
  }
}
