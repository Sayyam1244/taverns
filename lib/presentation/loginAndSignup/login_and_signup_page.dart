import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:taverns/core/app_export.dart';
import 'package:taverns/presentation/loginAndSignup/widgets/login_signup_tabview.dart';
import 'package:taverns/presentation/loginAndSignup/widgets/login_widget.dart';
import 'package:taverns/presentation/loginAndSignup/widgets/signup_widget.dart';

import '../../widgets/custom_elevated_button.dart';
import 'login_and_signup_cubit.dart';

class LoginAndSignupPage extends StatefulWidget {
  final LoginAndSignupCubit cubit;

  const LoginAndSignupPage({
    Key? key,
    required this.cubit,
  }) : super(key: key);

  @override
  State<LoginAndSignupPage> createState() => _LoginAndSignupState();
}

class _LoginAndSignupState extends State<LoginAndSignupPage>
    with SingleTickerProviderStateMixin {
  LoginAndSignupCubit get cubit => widget.cubit;
  TextEditingController loginEmail = TextEditingController();
  TextEditingController loginPassword = TextEditingController();

  TextEditingController signupEmail = TextEditingController();
  TextEditingController signupSetPassword = TextEditingController();
  TextEditingController signupConfirmPassword = TextEditingController();

  //
  GlobalKey<FormState> loginformKey = GlobalKey<FormState>();
  GlobalKey<FormState> signUpformKey = GlobalKey<FormState>();

  bool rememberMe = false;
  late TabController tabviewController;

  @override
  void initState() {
    super.initState();
    tabviewController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return SafeArea(
      child: Scaffold(
        body: Container(
          width: double.maxFinite,
          decoration: AppDecoration.fillOnErrorContainer,
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.h),
                child: Column(
                  children: [
                    SizedBox(height: 54.v),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Tavern".toUpperCase(),
                          style: CustomTextStyles.headlineLargeCairoOnPrimary,
                        ),
                        CustomImageView(
                          imagePath: ImageConstant.imgVectorPrimary,
                          height: 4.adaptSize,
                          width: 4.adaptSize,
                          margin: EdgeInsets.only(
                            left: 4.h,
                            top: 36.v,
                            bottom: 19.v,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 30.v),
                    LoginSignupTabview(tabviewController: tabviewController),
                    SizedBox(height: 30.v),
                  ],
                ),
              ),
              Expanded(
                child: TabBarView(controller: tabviewController, children: [
                  LoginWidget(
                      email: loginEmail,
                      password: loginPassword,
                      loginformKey: loginformKey),
                  SignupWidget(
                    email: signupEmail,
                    setPassword: signupSetPassword,
                    confirmPassword: signupConfirmPassword,
                    loginformKey: signUpformKey,
                  ),
                ]),
              )
            ],
          ),
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
          child: CustomElevatedButton(
            onPressed: () {
              loginformKey.currentState!.validate();
            },
            text: "Continue",
          ),
        ),
      ),
    );
  }
}
