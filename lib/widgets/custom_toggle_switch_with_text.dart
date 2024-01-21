
import 'package:flutter/material.dart';
import 'package:taverns/core/app_export.dart';
import 'package:taverns/widgets/custom_switch.dart';

class CustomToggleButtonWithPrefixText extends StatelessWidget {
  const CustomToggleButtonWithPrefixText({
    Key? key,
    required this.text,
    required this.isSelected,
    required this.onChange,
  }) : super(key: key);
  final String text;
  final bool isSelected;
  final Function(bool) onChange;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 13.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(text, style: CustomTextStyles.titleSmallCircularStdBluegray800),
          CustomSwitch(
            margin: EdgeInsets.only(top: 2.v),
            onChange: onChange,
            value: isSelected,
          ),
        ],
      ),
    );
  }
}
