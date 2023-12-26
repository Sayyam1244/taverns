import 'package:flutter/material.dart';
import 'package:taverns/core/app_export.dart';
import 'package:taverns/widgets/custom_elevated_button.dart';

class SignUpSuccessfulScreen extends StatelessWidget {
  const SignUpSuccessfulScreen({Key? key})
      : super(
          key: key,
        );

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          width: double.maxFinite,
          padding: EdgeInsets.symmetric(
            horizontal: 29.h,
            vertical: 109.v,
          ),
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(
                ImageConstant.imgGroup3,
              ),
              fit: BoxFit.cover,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomImageView(
                imagePath: ImageConstant.imgGroup8370,
                height: 282.v,
                width: 315.h,
              ),
              SizedBox(height: 42.v),
              Container(
                width: 269.h,
                margin: EdgeInsets.symmetric(horizontal: 24.h),
                child: Text(
                  "You have signed up successfully\nTavern Profile",
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                  style: theme.textTheme.headlineLarge!.copyWith(
                    height: 1.40,
                  ),
                ),
              ),
              SizedBox(height: 5.v),
            ],
          ),
        ),
        bottomNavigationBar: _buildStartExploringButton(context),
      ),
    );
  }

  /// Section Widget
  Widget _buildStartExploringButton(BuildContext context) {
    return CustomElevatedButton(
      text: "Start Exploring",
      margin: EdgeInsets.only(
        left: 24.h,
        right: 24.h,
        bottom: 36.v,
      ),
    );
  }
}
