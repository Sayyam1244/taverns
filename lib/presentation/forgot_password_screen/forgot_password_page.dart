import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taverns/core/app_export.dart';
import '../../widgets/custom_elevated_button.dart';
import '../../widgets/custom_text_form_field.dart';
import 'forgot_password_cubit.dart';
import 'forgot_password_state.dart';

class ForgotPasswordPage extends StatefulWidget {
  final ForgotPasswordCubit cubit;

  const ForgotPasswordPage({
    Key? key,
    required this.cubit,
  }) : super(key: key);

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPasswordPage> {
  ForgotPasswordCubit get cubit => widget.cubit;
  TextEditingController passwordController = TextEditingController();

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
    cubit.navigator.context= context;
  }

  @override
  Widget build(BuildContext context) {
    return 
    SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Form(
          key: _formKey,
          child: SizedBox(
            width: double.maxFinite,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 24,top: 20,bottom: 20),
                  child: CustomPopButton(ontap: () {

                    cubit.navigateBack();
                  },),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 24.h),
                  child: Text(
                    "Forgot password",
                    style: theme.textTheme.headlineSmall,
                  ),
                ),
                SizedBox(height: 7.v),
                Container(
                  width: 240.h,
                  margin: EdgeInsets.only(left: 24.h),
                  child: Text(
                    "Enter Email\rto reset your password.",
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: theme.textTheme.bodyLarge!.copyWith(
                      height: 1.50,
                    ),
                  ),
                ),
                SizedBox(height: 21.v),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24.h),
                  child: CustomTextFormField(
                    controller: passwordController,
                    hintText: "Email address",
                    textInputAction: TextInputAction.done,
                    textInputType: TextInputType.emailAddress,
                    alignment: Alignment.center,
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
                  ),
                ),
                SizedBox(height: 27.v),
                CustomElevatedButton(
                  text: "Continue",
                  margin: EdgeInsets.symmetric(horizontal: 24.h),
                  alignment: Alignment.center,
                ),
                SizedBox(height: 5.v),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

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