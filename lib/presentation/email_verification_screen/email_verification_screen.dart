import 'package:flutter/material.dart';
import 'package:taverns/core/app_export.dart';
import 'package:taverns/widgets/app_bar/appbar_subtitle.dart';
import 'package:taverns/widgets/app_bar/custom_app_bar.dart';
import 'package:taverns/widgets/custom_elevated_button.dart';

class EmailVerificationScreen extends StatelessWidget {
  const EmailVerificationScreen({Key? key})
      : super(
          key: key,
        );

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: _buildAppBar(context),
        body: SizedBox(
          width: SizeUtils.width,
          child: SingleChildScrollView(
            padding: EdgeInsets.only(top: 16.v),
            child: Padding(
              padding: EdgeInsets.only(right: 24.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 180.h,
                    margin: EdgeInsets.only(left: 24.h),
                    child: Text(
                      "Email verification\nsent!",
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: CustomTextStyles.headlineSmallPrimaryContainer
                          .copyWith(
                        height: 1.50,
                      ),
                    ),
                  ),
                  SizedBox(height: 15.v),
                  Container(
                    width: 231.h,
                    margin: EdgeInsets.only(left: 24.h),
                    child: Text(
                      "Email verification has been sent to ****34@gmail.com.",
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: theme.textTheme.bodyLarge!.copyWith(
                        height: 1.50,
                      ),
                    ),
                  ),
                  SizedBox(height: 152.v),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Container(
                      width: 71.h,
                      margin: EdgeInsets.only(right: 128.h),
                      child: Text(
                        "Resend in \n1",
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.center,
                        style: theme.textTheme.displayMedium,
                      ),
                    ),
                  ),
                  SizedBox(height: 92.v),
                  _buildEmailVerificationStack(context),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  /// Section Widget
  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return CustomAppBar(
      height: 64.v,
      centerTitle: true,
      title: AppbarSubtitle(
        text: "Email verification",
      ),
    );
  }

  /// Section Widget
  Widget _buildEmailVerificationStack(BuildContext context) {
    return SizedBox(
      height: 305.v,
      width: 351.h,
      child: Stack(
        alignment: Alignment.bottomRight,
        children: [
          Opacity(
            opacity: 0.03,
            child: CustomImageView(
              imagePath: ImageConstant.img2305x155,
              height: 305.v,
              width: 155.h,
              alignment: Alignment.centerLeft,
            ),
          ),
          CustomElevatedButton(
            width: 327.h,
            text: "Continue",
            margin: EdgeInsets.only(bottom: 112.v),
            alignment: Alignment.bottomRight,
          ),
        ],
      ),
    );
  }
}
