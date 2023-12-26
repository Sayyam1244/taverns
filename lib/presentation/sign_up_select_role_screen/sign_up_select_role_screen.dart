import '../sign_up_select_role_screen/widgets/chipview_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:taverns/core/app_export.dart';
import 'package:taverns/widgets/custom_elevated_button.dart';

class SignUpSelectRoleScreen extends StatelessWidget {
  const SignUpSelectRoleScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            body: Container(
                height: 768.v,
                width: double.maxFinite,
                padding: EdgeInsets.symmetric(vertical: 10.v),
                child: Stack(alignment: Alignment.topCenter, children: [
                  Align(
                      alignment: Alignment.topCenter,
                      child: Container(
                          margin: EdgeInsets.only(top: 5.v),
                          padding: EdgeInsets.symmetric(
                              horizontal: 30.h, vertical: 120.v),
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage(ImageConstant.imgGroup3),
                                  fit: BoxFit.cover)),
                          child: Column(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                CustomImageView(
                                    imagePath:
                                        ImageConstant.imgUndrawPlayingCardsCywn,
                                    height: 210.v,
                                    width: 300.h),
                                SizedBox(height: 81.v),
                                Text("Select Role",
                                    style: CustomTextStyles
                                        .titleMediumCircularStdBluegray800),
                                SizedBox(height: 29.v),
                                _buildChipView(context),
                                SizedBox(height: 17.v)
                              ]))),
                  Align(
                      alignment: Alignment.topCenter,
                      child: Padding(
                          padding: EdgeInsets.only(
                              left: 24.h, right: 24.h, bottom: 5.v),
                          child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CustomImageView(
                                    imagePath: ImageConstant.imgArrowLeft,
                                    height: 24.adaptSize,
                                    width: 24.adaptSize,
                                    onTap: () {
                                      onTapImgArrowLeft(context);
                                    }),
                                Spacer(),
                                CustomElevatedButton(text: "Next")
                              ])))
                ]))));
  }

  /// Section Widget
  Widget _buildChipView(BuildContext context) {
    return Wrap(
        runSpacing: 12.v,
        spacing: 12.h,
        children: List<Widget>.generate(3, (index) => ChipviewItemWidget()));
  }

  /// Navigates back to the previous screen.
  onTapImgArrowLeft(BuildContext context) {
    Navigator.pop(context);
  }
}
