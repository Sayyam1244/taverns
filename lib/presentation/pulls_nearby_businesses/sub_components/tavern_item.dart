import 'package:flutter/material.dart';
import 'package:taverns/core/app_export.dart';

class TavernsItem extends StatelessWidget {
  const TavernsItem({
    Key? key,
    required this.isSelected,
    required this.ontap,
    required this.title,
    required this.subTitle,
  }) : super(key: key);
  final bool isSelected;
  final VoidCallback ontap;
  final String title;
  final String subTitle;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ontap,
      child: Container(
        padding: EdgeInsets.all(16),
        margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: BoxDecoration(
          color: theme.colorScheme.background,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
              color: isSelected
                  ? theme.colorScheme.primary
                  : theme.colorScheme.background),
          boxShadow: [
            BoxShadow(
              color: appTheme.black9000a,
              spreadRadius: 2.h,
              blurRadius: 2.h,
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: theme.colorScheme.primary,
              ),
              child: Icon(
                Icons.location_on,
                color: appTheme.white,
              ),
            ),
            SizedBox(width: 20),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: CustomTextStyles.titleSmallCircularStdBluegray70001,
                ),
                Text(
                  subTitle,
                  style: CustomTextStyles.bodySmallSFProBluegray40001,
                ),
              ],
            ),
            Spacer(),
            Icon(
              isSelected ? Icons.check_circle_rounded : Icons.circle_outlined,
              color: theme.colorScheme.primary,
            )
            // Icon(Icons.check_circle_rounded)
          ],
        ),
      ),
    );
  }
}
