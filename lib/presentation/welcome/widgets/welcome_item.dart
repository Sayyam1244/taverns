import 'package:flutter/material.dart';
import 'package:taverns/core/app_export.dart';

class WelcomeItem extends StatelessWidget {
  const WelcomeItem({Key? key, required this.imagePath, required this.title, required this.body})
      : super(
          key: key,
        );
  final String imagePath;
  final String title;
  final String body;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 40.h, vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 48.adaptSize,
            width: 48.adaptSize,
            margin: EdgeInsets.only(
              top: 1.v,
              bottom: 17.v,
            ),
            child: Stack(
              alignment: Alignment.center,
              children: [
                Align(
                  alignment: Alignment.center,
                  child: Container(
                    height: 48.adaptSize,
                    width: 48.adaptSize,
                    decoration: BoxDecoration(
                      color: appTheme.yellow50,
                      borderRadius: BorderRadius.circular(
                        24.h,
                      ),
                    ),
                  ),
                ),
                CustomImageView(
                  imagePath: imagePath,
                  height: 28.adaptSize,
                  width: 28.adaptSize,
                  alignment: Alignment.center,
                ),
              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(left: 12.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: CustomTextStyles.titleSmallSecondaryContainer.copyWith(
                      height: 1.71,
                    ),
                  ),
                  Opacity(
                    opacity: 0.7,
                    child: Text(
                      body,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: CustomTextStyles.labelLargeCairoGray80001.copyWith(
                        height: 1.67,
                      ),
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
