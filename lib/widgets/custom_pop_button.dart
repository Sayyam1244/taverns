
import 'package:flutter/material.dart';
import 'package:taverns/core/app_export.dart';

class CustomPopButton extends StatelessWidget {
  const CustomPopButton({
    Key? key, required this.ontap,
  }) : super(key: key);
  final VoidCallback ontap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ontap,
      child: Container(
        height: 40.v,
        width: 40.v,
        padding: EdgeInsets.only(left: 10.h),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: appTheme.gray400
          )
        ),
        child: Icon(Icons.arrow_back_ios,color: appTheme.gray600,),
      ),
    );
  }
}