import 'package:flutter/material.dart';
import 'package:taverns/core/app_export.dart';

class CustomIconDualTextButton extends StatelessWidget {
  const CustomIconDualTextButton(
      {Key? key,
      required this.title,
      required this.value,
      required this.icon,
      required this.ontap})
      : super(key: key);
  final String title;
  final String value;
  final IconData icon;
  final VoidCallback ontap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ontap,
      child: Container(
        height: 60,
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: appTheme.yellow50,
          borderRadius: BorderRadius.circular(16.h),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(width: 10.h),
            Icon(
              icon,
              color: theme.colorScheme.primary,
            ),
            SizedBox(width: 10.h),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: 8.v),
                  Text(
                    title,
                    style: CustomTextStyles.bodySmallSFProBluegray40001,
                  ),
                  SizedBox(height: 4.v),
                  Expanded(
                    child: Text(
                      value,
                      maxLines: 1,
                      style: CustomTextStyles.titleSmallProductSansBluegray800,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(width: 10.h),
          ],
        ),
      ),
    );
  }
}
