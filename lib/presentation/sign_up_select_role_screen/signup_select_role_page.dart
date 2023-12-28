import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taverns/core/app_export.dart';
import 'package:taverns/presentation/sign_up_select_role_screen/widgets/chipview_item_widget.dart';
import '../../widgets/custom_elevated_button.dart';
import '../forgot_password_screen/forgot_password_page.dart';
import 'signup_select_role_cubit.dart';
import 'signup_select_role_state.dart';

class SignupSelectRolePage extends StatefulWidget {
  final SignupSelectRoleCubit cubit;

  const SignupSelectRolePage({
    Key? key,
    required this.cubit,
  }) : super(key: key);

  @override
  State<SignupSelectRolePage> createState() => _SignupSelectRoleState();
}

class _SignupSelectRoleState extends State<SignupSelectRolePage> {
  SignupSelectRoleCubit get cubit => widget.cubit;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: Stack(
            alignment: Alignment.topCenter,
            children: [
              Align(
                alignment: Alignment.topCenter,
                child: Container(
                  margin: EdgeInsets.only(top: 5.v),
                  padding:
                      EdgeInsets.symmetric(horizontal: 30.h, vertical: 120.v),
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage(ImageConstant.imgGroup3),
                          fit: BoxFit.cover)),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CustomImageView(
                          imagePath: ImageConstant.selectRole,
                          height: 210.v,
                          width: 300.h),
                      SizedBox(height: 81.v),
                      Text("Select Role",
                          style: CustomTextStyles
                              .titleMediumCircularStdBluegray800),
                      SizedBox(height: 29.v),
                      _buildChipView(context),
                      SizedBox(height: 17.v)
                    ],
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding:
                      EdgeInsets.only(left: 24.h, right: 24.h, bottom: 5.v),
                  child: CustomElevatedButton(text: "Next"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Section Widget
  Widget _buildChipView(BuildContext context) {
    return Wrap(
        runSpacing: 12.v,
        spacing: 12.h,
        children: List<Widget>.generate(3, (index) => ChipviewItemWidget(isSelected: false, text: 'Tavern')));
  }

  /// Navigates back to the previous screen.
  onTapImgArrowLeft(BuildContext context) {
    Navigator.pop(context);
  }
}
