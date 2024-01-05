import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:taverns/core/app_export.dart';
import 'package:taverns/widgets/custom_elevated_button.dart';
import 'package:taverns/widgets/custom_rating_bar.dart';

class TavernProfileWidget extends StatelessWidget {
  const TavernProfileWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                CustomImageView(
                  fit: BoxFit.cover,
                  imagePath: ImageConstant.imgMaskGroup,
                  height: 40.adaptSize,
                  width: 40.adaptSize,
                  alignment: Alignment.center,
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
                        style: CustomTextStyles.titleSmallProductSansBluegray800,
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
          Divider(
            color: appTheme.gray90060.withOpacity(0.1),
            indent: 6.h,
            thickness: 1,
            endIndent: 6.h,
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
                    initialRating: 5,
                    color: theme.colorScheme.primary,
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
                CustomElevatedButton(
                  height: 31.v,
                  width: 94.h,
                  text: "View profile",
                  buttonStyle: CustomButtonStyles.fillPrimaryTL8,
                  buttonTextStyle: CustomTextStyles.labelLargeOnErrorContainer_1,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
