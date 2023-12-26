import 'package:flutter/material.dart';
import 'package:taverns/core/app_export.dart';
import 'package:taverns/widgets/custom_elevated_button.dart';
import 'package:taverns/widgets/custom_text_form_field.dart';

// ignore_for_file: must_be_immutable
class SignupCompletionPage extends StatefulWidget {
  const SignupCompletionPage({Key? key})
      : super(
          key: key,
        );

  @override
  SignupCompletionPageState createState() => SignupCompletionPageState();
}

class SignupCompletionPageState extends State<SignupCompletionPage>
    with AutomaticKeepAliveClientMixin<SignupCompletionPage> {
  TextEditingController addressController = TextEditingController();

  TextEditingController addressController1 = TextEditingController();

  TextEditingController emailController = TextEditingController();

  TextEditingController fieldController = TextEditingController();

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
                      _buildAddressSection(context),
                      SizedBox(height: 19.v),
                      CustomElevatedButton(
                        text: "Next",
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
  Widget _buildAddressSection(BuildContext context) {
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
            crossAxisAlignment: CrossAxisAlignment.start,
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
                  bottom: 2.v,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 78.h,
                      child: Text(
                        "Business Name",
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: theme.textTheme.bodySmall!.copyWith(
                          height: 1.67,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 46.h,
                      child: Text(
                        "Tavern",
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: CustomTextStyles
                            .titleMediumSecondaryContainerSemiBold
                            .copyWith(
                          height: 1.50,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 16.v),
        Container(
          padding: EdgeInsets.symmetric(
            horizontal: 16.h,
            vertical: 14.v,
          ),
          decoration: AppDecoration.fillYellow.copyWith(
            borderRadius: BorderRadiusStyle.roundedBorder16,
          ),
          child: Row(
            children: [
              CustomImageView(
                imagePath: ImageConstant.user,
                height: 24.adaptSize,
                width: 24.adaptSize,
                margin: EdgeInsets.symmetric(vertical: 1.v),
              ),
              Container(
                width: 105.h,
                margin: EdgeInsets.only(left: 12.h),
                child: Text(
                  "Business Number",
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: theme.textTheme.titleSmall!.copyWith(
                    height: 1.71,
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 16.v),
        CustomTextFormField(
          controller: addressController,
          hintText: "Address (with Google Maps Integration)",
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
          controller: addressController1,
          hintText: "Business Address",
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
          controller: emailController,
          hintText: "Contact Email",
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
          controller: fieldController,
          hintText: "Business Hours",
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
      ],
    );
  }
}
