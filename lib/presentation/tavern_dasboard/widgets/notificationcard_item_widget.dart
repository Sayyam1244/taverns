import 'package:flutter/material.dart';
import 'package:taverns/core/app_export.dart';
import 'package:taverns/domain/model/notification_model.dart';
import 'package:taverns/widgets/custom_icon_button.dart';

// ignore: must_be_immutable
class NotificationcardItemWidget extends StatelessWidget {
  const NotificationcardItemWidget(
      {Key? key, required this.notificationModel, required this.onTap})
      : super(
          key: key,
        );
  final NotificationModel notificationModel;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
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
                bottom: 25.v,
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
                          notificationModel.sender!,
                          style:
                              CustomTextStyles.titleSmallSecondaryContainer_1,
                        ),
                        Text(
                          notificationModel.createdDate!.format(),
                          style: CustomTextStyles.labelLargePrimary,
                        ),
                      ],
                    ),
                    SizedBox(height: 4.v),
                    Text(
                      notificationModel.notification!,
                      maxLines: 2,
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
      ),
    );
  }
}
