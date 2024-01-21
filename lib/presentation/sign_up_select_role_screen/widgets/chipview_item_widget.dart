import 'package:flutter/material.dart';
import 'package:taverns/core/app_export.dart';

// ignore: must_be_immutable
class ChipviewItemWidget extends StatelessWidget {
  const ChipviewItemWidget(
      {Key? key,
      required this.isSelected,
      required this.text,
      required this.ontap})
      : super(
          key: key,
        );
  final bool isSelected;
  final String text;
  final VoidCallback ontap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ontap,
      child: Container(
        clipBehavior: Clip.hardEdge,
        height: 43.v,
        decoration: BoxDecoration(
          color: isSelected ? theme.colorScheme.primary : appTheme.yellow50,
          borderRadius: BorderRadius.circular(16.h),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            isSelected
                ? Icon(Icons.check, color: theme.colorScheme.background)
                : Container(),
            SizedBox(width: 10.h),
            Text(
              text,
              style: TextStyle(
                color: isSelected
                    ? theme.colorScheme.background
                    : theme.colorScheme.onBackground.withOpacity(0.7),
                fontSize: 14.fSize,
                fontFamily: 'Circular Std',
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      ),
    );

  }
}
