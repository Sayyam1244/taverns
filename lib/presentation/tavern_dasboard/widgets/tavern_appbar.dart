import 'package:flutter/material.dart';
import 'package:taverns/core/app_export.dart';
import 'package:taverns/widgets/app_bar/custom_app_bar.dart';

import '../../../widgets/app_bar/appbar_title.dart';

PreferredSizeWidget tavernAppBar(
    BuildContext context, VoidCallback notificationCallBack) {
  return CustomAppBar(
    height: 59.v,
    title: Padding(
      padding: EdgeInsets.only(left: 16.h),
      child: Row(
        children: [
          AppbarTitle(
            text: "Tavern".toUpperCase(),
          ),
        ],
      ),
    ),
    actions: [
      Container(
        height: 34.v,
        width: 32.h,
        margin: EdgeInsets.fromLTRB(17.h, 0, 17.h, 16.v),
        child: Stack(
          alignment: Alignment.topRight,
          children: [
            GestureDetector(
              onTap: notificationCallBack,
              child: CustomImageView(
                imagePath: ImageConstant.imgClockPrimary,
                height: 25.adaptSize,
                width: 25.adaptSize,
                alignment: Alignment.bottomLeft,
              ),
            ),
            // Align(
            //   alignment: Alignment.topRight,
            //   child: Container(
            //     height: 14.adaptSize,
            //     width: 14.adaptSize,
            //     margin: EdgeInsets.only(
            //       right: 6.h,
            //       top: 2.h,
            //       bottom: 20.v,
            //     ),
            //     decoration: BoxDecoration(
            //       color: appTheme.green300,
            //       borderRadius: BorderRadius.circular(
            //         7.h,
            //       ),
            //       border: Border.all(
            //         color: theme.colorScheme.onErrorContainer.withOpacity(1),
            //         width: 2.h,
            //       ),
            //     ),
            //   ),
            // ),
          ],
        ),
      ),
    ],
  );
}
