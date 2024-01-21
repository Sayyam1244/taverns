import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taverns/core/app_export.dart';
import 'package:taverns/core/utils/file_picker.dart';
import 'package:taverns/presentation/signup_completion/sub_components/other_tavern_fields.dart';
import '../../core/utils/flushbar.dart';
import '../../widgets/custom_elevated_button.dart';
import '../../widgets/custom_text_form_field.dart';
import 'signup_completion_cubit.dart';
import 'signup_completion_state.dart';

class SignupCompletionPage extends StatefulWidget {
  final SignupCompletionCubit cubit;

  const SignupCompletionPage({
    Key? key,
    required this.cubit,
  }) : super(key: key);

  @override
  State<SignupCompletionPage> createState() => _SignupCompletionState();
}

class _SignupCompletionState extends State<SignupCompletionPage> {
  SignupCompletionCubit get cubit => widget.cubit;

  @override
  void initState() {
    super.initState();
    cubit.navigator.context = context;
  }

  TextEditingController usernameController = TextEditingController();
  TextEditingController businessNameController = TextEditingController();
  TextEditingController businessNumberController = TextEditingController();
  TextEditingController businessAddressController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController businessHoursController = TextEditingController();
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  File? file;
  String? validator(String? value) {
    if (value!.isEmpty) {
      return "Field's empty";
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Form(
          key: _formKey,
          child: Container(
            width: double.maxFinite,
            decoration: AppDecoration.fillOnErrorContainer,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: ListView(
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
                  Align(
                    alignment: Alignment.center,
                    child: GestureDetector(
                      onTap: () async {
                        file = await CustomFilePicker().getImageFromGallery();
                        setState(() {});
                      },
                      child: Container(
                        height: 120.v,
                        width: 120.v,
                        child: Stack(
                          children: [
                            Container(
                              height: 120.v,
                              width: 120.v,
                              clipBehavior: Clip.hardEdge,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                image: file != null
                                    ? DecorationImage(
                                        image: FileImage(
                                          file!,
                                        ),
                                        fit: BoxFit.cover,
                                      )
                                    : null,
                                border: Border.all(
                                  color: theme.colorScheme.primary,
                                  width: 2,
                                ),
                              ),
                            ),
                            Align(
                              alignment: Alignment.bottomRight,
                              child: Container(
                                margin:
                                    EdgeInsets.only(bottom: 5.v, right: 5.v),
                                padding: EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: theme.colorScheme.primary,
                                  border: Border.all(
                                    color: theme.colorScheme.background,
                                    width: 5,
                                    strokeAlign: BorderSide.strokeAlignOutside,
                                  ),
                                ),
                                child: Icon(
                                  Icons.add,
                                  size: 16,
                                  color: theme.colorScheme.background,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  if (cubit.initialParams.type == 'Tavern')
                    SizedBox(height: 16.v),
                  SizedBox(height: 30.v),

                  CustomTextFormField(
                      controller: usernameController,
                      hintText: "Username",
                      prefix: Container(
                        margin: EdgeInsets.fromLTRB(16.h, 16.v, 12.h, 16.v),
                        child: CustomImageView(
                          imagePath: ImageConstant.user,
                          height: 24.adaptSize,
                          width: 24.adaptSize,
                        ),
                      ),
                      prefixConstraints: BoxConstraints(
                        maxHeight: 56.v,
                      ),
                      validator: validator),
                  //
                  if (cubit.initialParams.type == 'Tavern')
                    OtherTavernProfileFields(
                        businessNameController: businessNameController,
                        businessNumberController: businessNumberController,
                        businessAddressController: businessAddressController,
                        emailController: emailController,
                        businessHoursController: businessHoursController,
                        validator: cubit.initialParams.type == 'Tavern'
                            ? validator
                            : null),
                ],
              ),
            ),
          ),
        ),
        bottomNavigationBar:
            BlocBuilder<SignupCompletionCubit, SignupCompletionState>(
          bloc: cubit,
          builder: (context, state) => Padding(
            padding: EdgeInsets.only(left: 24.h, right: 24.h, bottom: 20.v),
            child: CustomElevatedButton(
              isLoading: state.isloading,
              text: "Next",
              onPressed: () {
                if (_formKey.currentState!.validate() == true && file != null) {
                  cubit.saveUserData(
                    context,
                    usernameController.text,
                    businessNameController.text,
                    businessNumberController.text,
                    businessAddressController.text,
                    emailController.text,
                    businessHoursController.text,
                    file!,
                  );
                } else if (file == null) {
                  FlushbarDialogue().showErrorFlushbar(
                      context: context,
                      title: 'Error',
                      body: 'Profile photo required');
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}
