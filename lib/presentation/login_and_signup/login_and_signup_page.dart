import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taverns/core/app_export.dart';
import 'package:taverns/core/utils/flushbar.dart';
import 'package:taverns/presentation/login_and_signup/login_and_signup_state.dart';
import 'package:taverns/presentation/login_and_signup/widgets/login_signup_tabview.dart';
import 'package:taverns/presentation/login_and_signup/widgets/login_widget.dart';
import 'package:taverns/presentation/login_and_signup/widgets/signup_widget.dart';

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

class _LoginAndSignupState extends State<LoginAndSignupPage> with SingleTickerProviderStateMixin {
  LoginAndSignupCubit get cubit => widget.cubit;
  TextEditingController loginEmail = TextEditingController();
  TextEditingController loginPassword = TextEditingController();

  TextEditingController signupEmail = TextEditingController();
  TextEditingController signupSetPassword = TextEditingController();
  TextEditingController signupConfirmPassword = TextEditingController();

  //
  GlobalKey<FormState> loginformKey = GlobalKey<FormState>();
  GlobalKey<FormState> signUpformKey = GlobalKey<FormState>();

  late TabController tabviewController;

  @override
  void initState() {
    super.initState();
    cubit.navigator.context = context;
    tabviewController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginAndSignupCubit, LoginAndSignupState>(
      bloc: cubit,
      builder: (context, state) => SafeArea(
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
                      loginformKey: loginformKey,
                      cubit: cubit,
                      state: state,
                    ),
                    SignupWidget(
                      email: signupEmail,
                      setPassword: signupSetPassword,
                      confirmPassword: signupConfirmPassword,
                      loginformKey: signUpformKey,
                      cubit: cubit,

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
                if (tabviewController.index == 0) {
                  if (loginformKey.currentState!.validate()==true) {
                    cubit.signInWithEmail(loginEmail.text.trim(),loginPassword.text, context);
                  }
                }else
                 {
                  if (signUpformKey.currentState!.validate()==true && signupSetPassword.text == signupConfirmPassword.text && state.termsAccepted == true) {
                    cubit.signUpwithEmail(signupEmail.text.trim(), signupConfirmPassword.text, context);
                  }else if (state.termsAccepted != true){
                    FlushbarDialogue().showErrorFlushbar(context: context, title: 'Error', body:'Please accept Terms of Service and Privacy Policy to continue');
                  }else if (signupSetPassword.text != signupConfirmPassword.text){
                    FlushbarDialogue().showErrorFlushbar(context: context, title: 'Error', body:'Confirm password and set password does not match');
                    
                  }
                }
              },
              text: "Continue",
            ),
          ),
        ),
      ),
    );
  }
}
