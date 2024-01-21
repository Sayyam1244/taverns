import 'package:flutter/material.dart';
import 'package:taverns/core/app_export.dart';

import '../../../widgets/custom_text_form_field.dart';

// ignore: must_be_immutable
class OtherTavernProfileFields extends StatelessWidget {
  OtherTavernProfileFields({
    Key? key,
    required this.businessNameController,
    required this.businessNumberController,
    required this.businessAddressController,
    required this.emailController,
    required this.businessHoursController,
    required this.validator,
  }) : super(key: key);

  final TextEditingController businessNameController;
  final TextEditingController businessNumberController;
  final TextEditingController businessAddressController;
  final TextEditingController emailController;
  final TextEditingController businessHoursController;
  String? Function(String?)? validator;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 16.v),
        CustomTextFormField(
          controller: businessNameController,
          hintText: "Business Name",
          prefix: Container(
              margin: EdgeInsets.fromLTRB(16.h, 16.v, 12.h, 16.v),
              child: Icon(
                Icons.business,
                color: theme.colorScheme.primary,
                size: 20,
              )),
          prefixConstraints: BoxConstraints(
            maxHeight: 56.v,
          ),
          validator: validator,
        ),
        SizedBox(height: 16.v),
        CustomTextFormField(
            controller: businessNumberController,
            hintText: "Business Number",
            prefix: Container(
                margin: EdgeInsets.fromLTRB(16.h, 16.v, 12.h, 16.v),
                child: Icon(
                  Icons.phone,
                  color: theme.colorScheme.primary,
                  size: 20,
                )),
            prefixConstraints: BoxConstraints(
              maxHeight: 56.v,
            ),
            validator: validator),
        SizedBox(height: 16.v),
        CustomTextFormField(
          controller: businessAddressController,
          hintText: "Business Address",
          prefix: Container(
              margin: EdgeInsets.fromLTRB(16.h, 16.v, 12.h, 16.v),
              child: Icon(
                Icons.location_on,
                color: theme.colorScheme.primary,
                size: 20,
              )),
          prefixConstraints: BoxConstraints(
            maxHeight: 56.v,
          ),
          validator: validator,
        ),
        SizedBox(height: 16.v),
        CustomTextFormField(
          controller: emailController,
          hintText: "Contact Email",
          textInputType: TextInputType.emailAddress,
          prefix: Container(
            margin: EdgeInsets.fromLTRB(16.h, 16.v, 12.h, 16.v),
            child: CustomImageView(
              imagePath: ImageConstant.email,
              height: 24.adaptSize,
              width: 24.adaptSize,
            ),
          ),
          prefixConstraints: BoxConstraints(
            maxHeight: 56.v,
          ),
          validator: validator,
        ),
        SizedBox(height: 16.v),
        CustomTextFormField(
          textInputType: TextInputType.datetime,
          controller: businessHoursController,
          hintText: "Business Hours",
          prefix: Container(
              margin: EdgeInsets.fromLTRB(16.h, 16.v, 12.h, 16.v),
              child: Icon(
                Icons.timelapse,
                color: theme.colorScheme.primary,
                size: 20,
              )),
          prefixConstraints: BoxConstraints(
            maxHeight: 56.v,
          ),
          validator: validator,
        ),
        SizedBox(height: 30.v),
      ],
    );
  }
}
