import 'package:flutter/material.dart';
import 'package:taverns/core/app_export.dart';
import 'package:taverns/widgets/custom_icon_button.dart';

// ignore: must_be_immutable
class NotificationcardItemWidget extends StatelessWidget {
  const NotificationcardItemWidget({Key? key})
      : super(
          key: key,
        );

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.sizeOf(context).width * .8,
      padding: EdgeInsets.symmetric(
        horizontal: 12.h,
        vertical: 13.v,
      ),
      decoration: AppDecoration.outlinePrimaryContainer.copyWith(
        borderRadius: BorderRadiusStyle.roundedBorder16,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(
              top: 2.v,
              bottom: 50.v,
            ),
            child: CustomIconButton(
              height: 40.adaptSize,
              width: 40.adaptSize,
              padding: EdgeInsets.all(10.h),
              decoration: IconButtonStyleHelper.outlineGrayF,
              child: CustomImageView(
                imagePath: ImageConstant.imgCard,
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(left: 19.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "Latest Notification",
                        style: CustomTextStyles.titleSmallSecondaryContainer_1,
                      ),
                      Text(
                        "2:00 pm",
                        style: CustomTextStyles.labelLargePrimary,
                      ),
                    ],
                  ),
                  SizedBox(height: 4.v),
                  Text(
                    "Amet minim mollit non deserunt ullamco est sit al mollit non deserunt ullamco est sit al mollit non deserunt ullamco est sit aliqua dolor do amet sint exercitation veniam.",
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    style: CustomTextStyles.labelLargeBluegray500.copyWith(
                      height: 1.67,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
