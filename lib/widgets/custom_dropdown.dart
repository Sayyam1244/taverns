import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:taverns/core/app_export.dart';

class CustomDropdownWidget extends StatelessWidget {
  const CustomDropdownWidget({Key? key, required this.hinttext, required this.list, this.onChanged, this.validator}) : super(key: key);
  final String hinttext;
  final List<String> list;
  final Function(String?)? onChanged;
  final String? Function(String?)? validator;
  @override
  Widget build(BuildContext context) {
    return CustomDropdown<String>(
        validator: validator,
        decoration: CustomDropdownDecoration(
          closedFillColor: appTheme.yellow50,
          closedBorderRadius: BorderRadius.circular(16.h),
        ),
        hintText: hinttext,
        items: list,
        // initialItem: list[0],
        onChanged: onChanged);
  }
}
