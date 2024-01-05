import 'package:flutter/material.dart';

import '../../../core/app_export.dart';

class TavernProfileTopbar extends StatelessWidget {
  const TavernProfileTopbar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      padding: EdgeInsets.all(30.h),
      decoration: AppDecoration.outlineSecondaryContainer.copyWith(
        borderRadius: BorderRadiusStyle.roundedBorder40B,
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
    );
  }
}
