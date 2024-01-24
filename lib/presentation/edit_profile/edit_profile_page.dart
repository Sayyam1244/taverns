import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taverns/core/app_export.dart';
import 'package:taverns/core/utils/file_picker.dart';
import 'package:taverns/presentation/edit_profile/edit_profile_state.dart';
import 'package:taverns/widgets/custom_text_form_field.dart';
import 'package:taverns/widgets/custome_loading_widget.dart';
import '../../widgets/app_bar/appbar_subtitle_one.dart';
import 'edit_profile_cubit.dart';

class EditProfilePage extends StatefulWidget {
  final EditProfileCubit cubit;

  const EditProfilePage({
    Key? key,
    required this.cubit,
  }) : super(key: key);

  @override
  State<EditProfilePage> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfilePage> {
  EditProfileCubit get cubit => widget.cubit;

  TextEditingController businessNameController = TextEditingController();
  TextEditingController businessNumberController = TextEditingController();
  TextEditingController businessAddressController = TextEditingController();
  TextEditingController marketPlaceController = TextEditingController();
  TextEditingController hoursController = TextEditingController();
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  File? file;
  String? validator(String? value) {
    if (value!.isEmpty) {
      return "Field's empty";
    }
  }

  @override
  void initState() {
    super.initState();
    cubit.navigator.context = context;
    businessNameController.text = cubit.initialParams.userModel.businessName!;
    businessNumberController.text =
        cubit.initialParams.userModel.businessNumber!;
    businessAddressController.text =
        cubit.initialParams.userModel.businessAddress!;
    marketPlaceController.text = cubit.initialParams.userModel.marketPlaceLink!;
    hoursController.text = cubit.initialParams.userModel.businessHours!;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        toolbarHeight: 70.v,
        backgroundColor: theme.colorScheme.background,
        elevation: 0,
        title: AppbarSubtitleOne(text: "Edit profile"),
        actions: [
          Padding(
            padding: EdgeInsets.only(
              right: 16.h,
            ),
            child: GestureDetector(
                onTap: () {
                  if (_formKey.currentState!.validate()) {
                    cubit.saveChanges(
                      businessNameController.text,
                      businessNumberController.text,
                      businessAddressController.text,
                      hoursController.text,
                      marketPlaceController.text,
                      context,
                    );
                  }
                },
                child: Text(
                  'Save changes',
                  style: CustomTextStyles.bodySmallMulishBluegray900,
                )),
          )
        ],
      ),
      body: BlocBuilder<EditProfileCubit, EditProfileState>(
        bloc: cubit,
        builder: (context, state) => state.isloading
            ? CustomLoadingWidget()
            : Form(
                key: _formKey,
                child: ListView(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  children: [
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
                                  image: DecorationImage(
                                    image: file != null
                                        ? FileImage(
                                            file!,
                                          ) as ImageProvider<Object>
                                        : NetworkImage(
                                            cubit.initialParams.userModel
                                                .profilePicture!,
                                          ),
                                    fit: BoxFit.cover,
                                  ),
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
                                      strokeAlign:
                                          BorderSide.strokeAlignOutside,
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
                    SizedBox(height: 16.v),
                    if (cubit.initialParams.userModel.accountType == 'Tavern')
                      TavernEditFields(
                        businessNameController: businessNameController,
                        businessNumberController: businessNumberController,
                        businessAddressController: businessAddressController,
                        hoursController: hoursController,
                        locationChangeOntap: () {
                          cubit.navigateToEditMapScreen(
                            businessNameController.text,
                            businessNumberController.text,
                            businessAddressController.text,
                            hoursController.text,
                            marketPlaceController.text,
                          );
                        },
                        validator: validator,
                      ),
                    CustomTextFormField(
                      controller: marketPlaceController,
                      hintText: "Marketplace",
                      prefix: Container(
                          margin: EdgeInsets.fromLTRB(16.h, 16.v, 12.h, 16.v),
                          child: Icon(
                            Icons.link,
                            color: theme.colorScheme.primary,
                            size: 20,
                          )),
                      prefixConstraints: BoxConstraints(
                        maxHeight: 56.v,
                      ),
                      suffixConstraints: BoxConstraints(
                        maxHeight: 56.v,
                      ),
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}

class TavernEditFields extends StatelessWidget {
  TavernEditFields({
    Key? key,
    required this.businessNameController,
    required this.businessNumberController,
    required this.businessAddressController,
    required this.hoursController,
    required this.locationChangeOntap,
    required this.validator,
  }) : super(key: key);

  final TextEditingController businessNameController;
  final TextEditingController businessNumberController;
  final TextEditingController businessAddressController;
  final TextEditingController hoursController;
  String? Function(String?)? validator;
  final VoidCallback locationChangeOntap;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
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
            validator: validator),
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
          validator: validator,
        ),
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
          enabled: true,
          suffixConstraints: BoxConstraints(
            maxHeight: 56.v,
          ),
          suffix: Padding(
            padding: const EdgeInsets.only(right: 16, left: 8),
            child: InkWell(
              onTap: locationChangeOntap,
              child: Text(
                'Change',
                style: CustomTextStyles.bodySmallPrimary,
              ),
            ),
          ),
        ),
        SizedBox(height: 16.v),
        CustomTextFormField(
          controller: hoursController,
          validator: validator,
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
          suffixConstraints: BoxConstraints(
            maxHeight: 56.v,
          ),
        ),
        SizedBox(height: 16.v),
      ],
    );
  }
}
