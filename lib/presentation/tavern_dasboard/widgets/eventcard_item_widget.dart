import 'package:flutter/material.dart';
import 'package:taverns/core/app_export.dart';
import 'package:taverns/widgets/custom_icon_button.dart';
import '../../../widgets/custom_elevated_button.dart';
import 'thirtysix1_item_widget.dart';

// ignore: must_be_immutable
class EventcardItemWidget extends StatelessWidget {
  const EventcardItemWidget({Key? key})
      : super(
          key: key,
        );

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(15.h),
      decoration: AppDecoration.outlineBlueGray.copyWith(
        borderRadius: BorderRadiusStyle.roundedBorder8,
      ),
      width: MediaQuery.sizeOf(context).width * 0.8,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomIconButton(
            height: 60.adaptSize,
            width: 60.adaptSize,
            padding: EdgeInsets.all(11.h),
            child: CustomImageView(
              imagePath: ImageConstant.imgThumbsUp,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
              left: 15.h,
              top: 8.v,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Event 1",
                  style: CustomTextStyles.titleMediumCircularStdBluegray90001,
                ),
                SizedBox(height: 6.v),
                Text(
                  "2:00 pm  - April 2020",
                  style: CustomTextStyles.bodySmallSFProBluegray40001,
                ),
                SizedBox(height: 8.v),
                Row(
                  children: [
                    CustomElevatedButton(
                      height: 31.v,
                      width: 94.h,
                      text: "Approve",
                      buttonStyle: CustomButtonStyles.fillPrimaryTL8,
                      buttonTextStyle: CustomTextStyles.labelLargeOnErrorContainer_1,
                    ),
                    SizedBox(width: 10.h),
                    CustomElevatedButton(
                      height: 31.v,
                      width: 60.h,
                      text: "Deny",
                      buttonStyle: CustomButtonStyles.fillYellow,
                      buttonTextStyle: CustomTextStyles.labelLargePrimary,
                    )
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
