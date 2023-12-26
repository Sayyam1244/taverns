import 'package:flutter/material.dart';
import 'package:taverns/core/app_export.dart';

// ignore_for_file: must_be_immutable
class MorePage extends StatelessWidget {
  const MorePage({Key? key})
      : super(
          key: key,
        );

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          width: double.maxFinite,
          decoration: AppDecoration.fillOnErrorContainer,
          child: SizedBox(
            height: 685.v,
            width: double.maxFinite,
            child: Stack(
              alignment: Alignment.topCenter,
              children: [
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    margin: EdgeInsets.only(top: 15.v),
                    padding: EdgeInsets.symmetric(
                      horizontal: 16.h,
                      vertical: 51.v,
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
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        SizedBox(height: 66.v),
                        Padding(
                          padding: EdgeInsets.only(left: 14.h),
                          child: Row(
                            children: [
                              CustomImageView(
                                imagePath: ImageConstant.imgGroup33151,
                                height: 16.adaptSize,
                                width: 16.adaptSize,
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: 29.h),
                                child: Text(
                                  "Database",
                                  style: CustomTextStyles
                                      .titleSmallCircularStdBluegray800,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 19.v),
                        Divider(),
                        SizedBox(height: 20.v),
                        Padding(
                          padding: EdgeInsets.only(left: 14.h),
                          child: Row(
                            children: [
                              CustomImageView(
                                imagePath: ImageConstant.imgGroup33151,
                                height: 16.adaptSize,
                                width: 16.adaptSize,
                                margin: EdgeInsets.only(bottom: 1.v),
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: 29.h),
                                child: Text(
                                  "QOL (Quality of Life)",
                                  style: CustomTextStyles
                                      .titleSmallCircularStdBluegray800,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 19.v),
                        Divider(),
                        SizedBox(height: 20.v),
                        Padding(
                          padding: EdgeInsets.only(left: 14.h),
                          child: Row(
                            children: [
                              CustomImageView(
                                imagePath: ImageConstant.imgGroup33151,
                                height: 16.adaptSize,
                                width: 16.adaptSize,
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: 29.h),
                                child: Text(
                                  "How-To",
                                  style: CustomTextStyles
                                      .titleSmallCircularStdBluegray800,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 19.v),
                        _buildNineColumn(context),
                        SizedBox(height: 21.v),
                        Padding(
                          padding: EdgeInsets.only(left: 14.h),
                          child: Row(
                            children: [
                              CustomImageView(
                                imagePath: ImageConstant.imgGroup33151,
                                height: 16.adaptSize,
                                width: 16.adaptSize,
                                margin: EdgeInsets.only(bottom: 1.v),
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: 29.h),
                                child: Text(
                                  "Safety Tips",
                                  style: CustomTextStyles
                                      .titleSmallCircularStdBluegray800,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 18.v),
                        Divider(),
                        SizedBox(height: 20.v),
                        Padding(
                          padding: EdgeInsets.only(left: 14.h),
                          child: Row(
                            children: [
                              CustomImageView(
                                imagePath: ImageConstant.imgThumbsUpRed400,
                                height: 20.adaptSize,
                                width: 20.adaptSize,
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                  left: 6.h,
                                  top: 2.v,
                                ),
                                child: Text(
                                  "Logout",
                                  style:
                                      CustomTextStyles.titleSmallMulishRed400,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Spacer(),
                        Align(
                          alignment: Alignment.center,
                          child: Text(
                            "Tavern",
                            style: CustomTextStyles.titleMediumMulishPrimary,
                          ),
                        ),
                        SizedBox(height: 5.v),
                        Align(
                          alignment: Alignment.center,
                          child: Text(
                            "V.0.0.1",
                            style: CustomTextStyles.bodySmallMulishBluegray900,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                _buildFourRow(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// Section Widget
  Widget _buildNineColumn(BuildContext context) {
    return Column(
      children: [
        Divider(),
        SizedBox(height: 21.v),
        Align(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: EdgeInsets.only(left: 14.h),
            child: Row(
              children: [
                CustomImageView(
                  imagePath: ImageConstant.imgGroup33151,
                  height: 16.adaptSize,
                  width: 16.adaptSize,
                  margin: EdgeInsets.only(bottom: 1.v),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 29.h),
                  child: Text(
                    "Support",
                    style: CustomTextStyles.titleSmallCircularStdBluegray800,
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(height: 18.v),
        Divider(),
      ],
    );
  }

  /// Section Widget
  Widget _buildFourRow(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: Container(
        width: double.maxFinite,
        margin: EdgeInsets.only(bottom: 582.v),
        padding: EdgeInsets.all(30.h),
        decoration: AppDecoration.outlineSecondaryContainer.copyWith(
          borderRadius: BorderRadiusStyle.roundedBorder40,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 43.adaptSize,
              width: 43.adaptSize,
              decoration: AppDecoration.fillDeepOrange.copyWith(
                borderRadius: BorderRadiusStyle.circleBorder20,
              ),
              child: CustomImageView(
                imagePath: ImageConstant.imgMaskGroup,
                height: 43.adaptSize,
                width: 43.adaptSize,
                alignment: Alignment.center,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                left: 12.h,
                top: 3.v,
                bottom: 3.v,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Tavern Name",
                    style: CustomTextStyles.titleSmallProductSansBluegray800,
                  ),
                  SizedBox(height: 6.v),
                  Text(
                    "Business Number",
                    style: theme.textTheme.labelMedium,
                  ),
                ],
              ),
            ),
            Spacer(),
            CustomImageView(
              imagePath: ImageConstant.imgEdit,
              height: 18.adaptSize,
              width: 18.adaptSize,
              margin: EdgeInsets.only(
                top: 12.v,
                bottom: 13.v,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
