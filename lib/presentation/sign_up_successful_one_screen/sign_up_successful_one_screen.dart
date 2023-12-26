import 'package:flutter/material.dart';
import 'package:taverns/core/app_export.dart';
import 'package:taverns/widgets/custom_elevated_button.dart';

class SignUpSuccessfulOneScreen extends StatelessWidget {
  const SignUpSuccessfulOneScreen({Key? key})
      : super(
          key: key,
        );

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          height: 768.v,
          width: double.maxFinite,
          padding: EdgeInsets.symmetric(vertical: 14.v),
          child: Stack(
            alignment: Alignment.center,
            children: [
              Align(
                alignment: Alignment.topCenter,
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 37.h,
                    vertical: 105.v,
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
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CustomImageView(
                        imagePath: ImageConstant.imgUndrawMyLocationReR52x,
                        height: 265.v,
                        width: 300.h,
                      ),
                      SizedBox(height: 63.v),
                      Container(
                        width: 294.h,
                        margin: EdgeInsets.only(left: 5.h),
                        child: Text(
                          "Location Permissions (For Nearby Events)",
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.center,
                          style: theme.textTheme.headlineLarge!.copyWith(
                            height: 1.40,
                          ),
                        ),
                      ),
                      SizedBox(height: 76.v),
                    ],
                  ),
                ),
              ),
              Align(
                alignment: Alignment.center,
                child: Padding(
                  padding: EdgeInsets.only(
                    left: 24.h,
                    right: 21.h,
                    bottom: 5.v,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Align(
                        alignment: Alignment.centerRight,
                        child: Text(
                          "Skip",
                          style: CustomTextStyles.bodySmallPrimary,
                        ),
                      ),
                      Spacer(),
                      CustomElevatedButton(
                        text: "Enable Location",
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
