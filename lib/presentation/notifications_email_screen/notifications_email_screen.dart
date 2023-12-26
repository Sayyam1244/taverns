import 'package:flutter/material.dart';
import 'package:taverns/core/app_export.dart';
import 'package:taverns/widgets/app_bar/appbar_leading_image.dart';
import 'package:taverns/widgets/app_bar/appbar_subtitle_one.dart';
import 'package:taverns/widgets/app_bar/appbar_subtitle_two.dart';
import 'package:taverns/widgets/app_bar/custom_app_bar.dart';
import 'package:taverns/widgets/custom_elevated_button.dart';
import 'package:taverns/widgets/custom_switch.dart';

// ignore_for_file: must_be_immutable
class NotificationsEmailScreen extends StatelessWidget {
  NotificationsEmailScreen({Key? key}) : super(key: key);

  bool isSelectedSwitch = false;

  bool isSelectedSwitch1 = false;

  bool isSelectedSwitch2 = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            body: Container(
                height: 768.v,
                width: double.maxFinite,
                padding: EdgeInsets.symmetric(vertical: 10.v),
                child: Stack(alignment: Alignment.topCenter, children: [
                  Align(
                      alignment: Alignment.topCenter,
                      child: Container(
                          margin: EdgeInsets.only(top: 5.v),
                          padding: EdgeInsets.symmetric(
                              horizontal: 16.h, vertical: 63.v),
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage(ImageConstant.imgGroup2),
                                  fit: BoxFit.cover)),
                          child:
                              Column(mainAxisSize: MainAxisSize.min, children: [
                            _buildLikesAndReviews(context),
                            SizedBox(height: 20.v),
                            Divider(),
                            SizedBox(height: 24.v),
                            _buildEventsNearMe(context),
                            SizedBox(height: 19.v),
                            Divider(),
                            SizedBox(height: 25.v),
                            _buildTimeSlotRequests(context),
                            SizedBox(height: 18.v),
                            Divider(),
                            SizedBox(height: 18.v)
                          ]))),
                  Align(
                      alignment: Alignment.topCenter,
                      child: Padding(
                          padding: EdgeInsets.only(
                              left: 24.h, right: 21.h, bottom: 5.v),
                          child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                _buildAppBar(context),
                                Spacer(),
                                CustomElevatedButton(text: "Confirm")
                              ])))
                ]))));
  }

  /// Section Widget
  Widget _buildLikesAndReviews(BuildContext context) {
    return Padding(
        padding: EdgeInsets.symmetric(horizontal: 13.h),
        child:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Text("Likes and Reviews",
              style: CustomTextStyles.titleSmallCircularStdBluegray800),
          CustomSwitch(
              margin: EdgeInsets.only(top: 2.v),
              value: isSelectedSwitch,
              onChange: (value) {
                isSelectedSwitch = value;
              })
        ]));
  }

  /// Section Widget
  Widget _buildEventsNearMe(BuildContext context) {
    return Padding(
        padding: EdgeInsets.symmetric(horizontal: 13.h),
        child:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Text("Events Near Me  ",
              style: CustomTextStyles.titleSmallCircularStdBluegray800),
          CustomSwitch(
              value: isSelectedSwitch1,
              onChange: (value) {
                isSelectedSwitch1 = value;
              })
        ]));
  }

  /// Section Widget
  Widget _buildTimeSlotRequests(BuildContext context) {
    return Padding(
        padding: EdgeInsets.symmetric(horizontal: 13.h),
        child:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Text("Time Slot Requests",
              style: CustomTextStyles.titleSmallCircularStdBluegray800),
          CustomSwitch(
              value: isSelectedSwitch2,
              onChange: (value) {
                isSelectedSwitch2 = value;
              })
        ]));
  }

  /// Section Widget
  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return CustomAppBar(
        leadingWidth: 49.h,
        leading: AppbarLeadingImage(
            imagePath: ImageConstant.imgArrowLeft,
            margin: EdgeInsets.only(left: 25.h),
            onTap: () {
              onTapArrowLeft(context);
            }),
        centerTitle: true,
        title: AppbarSubtitleOne(text: "Notifications Board"),
        actions: [
          AppbarSubtitleTwo(
              text: "Skip",
              margin: EdgeInsets.only(left: 21.h, top: 1.v, right: 21.h))
        ]);
  }

  /// Navigates back to the previous screen.
  onTapArrowLeft(BuildContext context) {
    Navigator.pop(context);
  }
}
