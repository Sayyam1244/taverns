import 'package:flutter/material.dart';
import 'package:taverns/core/app_export.dart';
import 'package:taverns/widgets/custom_elevated_button.dart';
import 'signup_success_full_cubit.dart';

class SignupSuccessFullPage extends StatefulWidget {
  final SignupSuccessFullCubit cubit;

  const SignupSuccessFullPage({
    Key? key,
    required this.cubit,
  }) : super(key: key);

  @override
  State<SignupSuccessFullPage> createState() => _SignupSuccessFullState();
}

class _SignupSuccessFullState extends State<SignupSuccessFullPage> {
  SignupSuccessFullCubit get cubit => widget.cubit;

  @override
  void initState() {
    super.initState();
    cubit.navigator.context = context;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: Container(
            width: double.maxFinite,
            padding: EdgeInsets.symmetric(
              horizontal: 29.h,
              vertical: 109.v,
            ),
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                  ImageConstant.imgGroup3,
                ),
                fit: BoxFit.cover,
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomImageView(
                  imagePath: ImageConstant.imgGroup8370,
                  height: 282.v,
                  width: 315.h,
                ),
                SizedBox(height: 42.v),
                Container(
                  width: 269.h,
                  margin: EdgeInsets.symmetric(horizontal: 24.h),
                  child: Text(
                    "You have signed up successfully for Tavern Profile",
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                    style: theme.textTheme.headlineLarge!.copyWith(
                      height: 1.40,
                    ),
                  ),
                ),
                SizedBox(height: 5.v),
              ],
            ),
          ),
          bottomNavigationBar: CustomElevatedButton(
            onPressed: () {
              cubit.navigateToTavernDashboard();
            },
            text: "Start Exploring",
            margin: EdgeInsets.only(
              left: 24.h,
              right: 24.h,
              bottom: 36.v,
            ),
          )),
    );
  }
}
