
import 'package:flutter/material.dart';
import 'package:taverns/core/app_export.dart';
import 'package:taverns/presentation/tavern_dasboard/widgets/eventcard_item_widget.dart';
import 'package:taverns/presentation/tavern_dasboard/widgets/notificationcard_item_widget.dart';
import 'package:taverns/widgets/app_bar/appbar_title.dart';
import 'package:taverns/widgets/app_bar/appbar_title_image.dart';
import 'package:taverns/widgets/app_bar/custom_app_bar.dart';
import 'package:taverns/widgets/custom_elevated_button.dart';
import 'package:taverns/widgets/custom_rating_bar.dart';
import 'package:taverns/widgets/custom_search_view.dart';

// ignore_for_file: must_be_immutable
class TavernDasboardPage extends StatelessWidget {
  TavernDasboardPage({Key? key})
      : super(
          key: key,
        );

  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: appTheme.gray5001,
        resizeToAvoidBottomInset: false,
        appBar: _buildAppBar(context),
        body: SizedBox(
          width: SizeUtils.width,
          child: SingleChildScrollView(
            padding: EdgeInsets.only(top: 2.v),
            child: Padding(
              padding: EdgeInsets.only(
                left: 2.h,
                bottom: 5.v,
              ),
              child: Column(
                children: [
                  _buildViewProfile(context),
                  SizedBox(height: 24.v),
                  _buildNotificationCard(context),
                  SizedBox(height: 24.v),
                  Padding(
                    padding: EdgeInsets.only(
                      left: 13.h,
                      right: 16.h,
                    ),
                    child: CustomSearchView(
                      controller: searchController,
                      hintText: "Fint Event",
                    ),
                  ),
                  SizedBox(height: 26.v),
                  Padding(
                    padding: EdgeInsets.only(
                      left: 13.h,
                      right: 16.h,
                    ),
                    child: _buildUpcomingEvents(
                      context,
                      upcomingEventsText: "Upcoming Events",
                      seeAllText: "See all",
                    ),
                  ),
                  SizedBox(height: 12.v),
                  _buildEventCard(context),
                  SizedBox(height: 24.v),
                  _buildSafetyTips(context),
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
      height: 59.v,
      title: Padding(
        padding: EdgeInsets.only(left: 16.h),
        child: Row(
          children: [
            AppbarTitle(
              text: "Tavern".toUpperCase(),
            ),
            AppbarTitleImage(
              imagePath: ImageConstant.imgVectorBlue700,
              margin: EdgeInsets.only(
                left: 3.h,
                top: 26.v,
                bottom: 14.v,
              ),
            ),
          ],
        ),
      ),
      actions: [
        Container(
          height: 34.v,
          width: 32.h,
          margin: EdgeInsets.fromLTRB(17.h, 8.v, 17.h, 13.v),
          child: Stack(
            alignment: Alignment.topRight,
            children: [
              CustomImageView(
                imagePath: ImageConstant.imgClockPrimary,
                height: 30.adaptSize,
                width: 30.adaptSize,
                alignment: Alignment.bottomLeft,
                margin: EdgeInsets.only(
                  top: 4.v,
                  right: 2.h,
                ),
              ),
              Align(
                alignment: Alignment.topRight,
                child: Container(
                  height: 14.adaptSize,
                  width: 14.adaptSize,
                  margin: EdgeInsets.only(
                    left: 18.h,
                    bottom: 20.v,
                  ),
                  decoration: BoxDecoration(
                    color: appTheme.green300,
                    borderRadius: BorderRadius.circular(
                      7.h,
                    ),
                    border: Border.all(
                      color: theme.colorScheme.onErrorContainer.withOpacity(1),
                      width: 2.h,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  /// Section Widget
  Widget _buildSeeAll(BuildContext context) {
    return CustomElevatedButton(
      height: 31.v,
      width: 94.h,
      text: "View profile",
      buttonStyle: CustomButtonStyles.fillPrimaryTL8,
      buttonTextStyle: CustomTextStyles.labelLargeOnErrorContainer_1,
    );
  }

  /// Section Widget
  Widget _buildViewProfile(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 15.h),
      padding: EdgeInsets.symmetric(
        horizontal: 14.h,
        vertical: 15.v,
      ),
      decoration: AppDecoration.fillOnErrorContainer.copyWith(
        borderRadius: BorderRadiusStyle.roundedBorder16,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(height: 4.v),
          Align(
            alignment: Alignment.centerLeft,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 40.adaptSize,
                  width: 40.adaptSize,
                  decoration: AppDecoration.fillDeepOrange.copyWith(
                    borderRadius: BorderRadiusStyle.circleBorder20,
                  ),
                  child: CustomImageView(
                    imagePath: ImageConstant.imgMaskGroup,
                    height: 40.adaptSize,
                    width: 40.adaptSize,
                    alignment: Alignment.center,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    left: 10.h,
                    top: 2.v,
                    bottom: 4.v,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Tavern Name",
                        style:
                            CustomTextStyles.titleSmallProductSansBluegray800,
                      ),
                      SizedBox(height: 3.v),
                      Text(
                        "Business Number",
                        style: theme.textTheme.labelMedium,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 15.v),
          Opacity(
            opacity: 0.07,
            child: Divider(
              color: appTheme.gray90060,
              indent: 6.h,
              endIndent: 6.h,
            ),
          ),
          SizedBox(height: 15.v),
          Padding(
            padding: EdgeInsets.only(
              left: 6.h,
              right: 4.h,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.only(
                    top: 8.v,
                    bottom: 7.v,
                  ),
                  child: CustomRatingBar(
                    initialRating: 0,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    left: 12.h,
                    top: 9.v,
                    bottom: 5.v,
                  ),
                  child: Text(
                    "(22235)",
                    style: CustomTextStyles.labelLargePrimary,
                  ),
                ),
                Spacer(),
                _buildSeeAll(context),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// Section Widget
  Widget _buildNotificationCard(BuildContext context) {
    return SizedBox(
      height: 195.v,
      width: 373.h,
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          Align(
            alignment: Alignment.center,
            child: Container(
              height: 195.v,
              width: 373.h,
              decoration: BoxDecoration(
                color: theme.colorScheme.onErrorContainer.withOpacity(1),
                borderRadius: BorderRadius.circular(
                  16.h,
                ),
                boxShadow: [
                  BoxShadow(
                    color: theme.colorScheme.secondaryContainer,
                    spreadRadius: 2.h,
                    blurRadius: 2.h,
                    offset: Offset(
                      0,
                      0,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(15.h, 20.v, 15.h, 151.v),
            child: _buildUpcomingEvents(
              context,
              upcomingEventsText: "Notification Board",
              seeAllText: "See All",
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: SizedBox(
              height: 195.v,
              child: ListView.separated(
                padding: EdgeInsets.only(
                  left: 15.h,
                  top: 55.v,
                  bottom: 20.v,
                ),
                scrollDirection: Axis.horizontal,
                separatorBuilder: (
                  context,
                  index,
                ) {
                  return SizedBox(
                    width: 17.h,
                  );
                },
                itemCount: 2,
                itemBuilder: (context, index) {
                  return NotificationcardItemWidget();
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Section Widget
  Widget _buildEventCard(BuildContext context) {
    return SizedBox(
      height: 123.v,
      child: ListView.separated(
        padding: EdgeInsets.only(left: 13.h),
        scrollDirection: Axis.horizontal,
        separatorBuilder: (
          context,
          index,
        ) {
          return SizedBox(
            width: 16.h,
          );
        },
        itemCount: 2,
        itemBuilder: (context, index) {
          return EventcardItemWidget();
        },
      ),
    );
  }

  /// Section Widget
  Widget _buildSafetyTips(BuildContext context) {
    return CustomElevatedButton(
      text: "Safety Tips",
      margin: EdgeInsets.only(
        left: 22.h,
        right: 24.h,
      ),
    );
  }

  /// Common widget
  Widget _buildUpcomingEvents(
    BuildContext context, {
    required String upcomingEventsText,
    required String seeAllText,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          upcomingEventsText,
          style: CustomTextStyles.titleMediumCircularStdBluegray800.copyWith(
            color: appTheme.blueGray800,
          ),
        ),
        Padding(
          padding: EdgeInsets.only(
            top: 2.v,
            bottom: 4.v,
          ),
          child: Text(
            seeAllText,
            style: CustomTextStyles.labelLargePrimary.copyWith(
              color: theme.colorScheme.primary,
            ),
          ),
        ),
      ],
    );
  }
}
