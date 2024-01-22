import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:taverns/widgets/custom_text_form_field.dart';
import '../../../core/app_export.dart';
import '../../../widgets/custom_dropdown.dart';
import '../../../widgets/custom_elevated_button.dart';
import '../../../widgets/custom_icon_with_dual_text_button.dart';
import '../notification_board_cubit.dart';
import '../notification_board_state.dart';

class PostWidget extends StatefulWidget {
  const PostWidget({
    Key? key,
    required this.cubit,
    required this.state,
  }) : super(key: key);
  final NotificationBoardCubit cubit;
  final NotificationBoardState state;

  @override
  State<PostWidget> createState() => _PostWidgetState();
}

class _PostWidgetState extends State<PostWidget> {
  @override
  void initState() {
    super.initState();
  }

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  validator(String? v) {
    if (v == null || v.trim().isEmpty) {
      return 'Required';
    } else {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        SizedBox(height: 20),
        Container(
          margin: EdgeInsets.symmetric(horizontal: SizeUtils.width * .05),
          decoration: BoxDecoration(
            color: theme.colorScheme.background,
            borderRadius: BorderRadius.circular(
              12,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text('Post a Notification',
                        style: CustomTextStyles.titleMedium16),
                  ),
                  SizedBox(height: 20.v),
                  if (widget.cubit.initialParams.userModel!.accountType ==
                      "Tavern")
                    TavernPostFields(
                      businessName:
                          widget.cubit.initialParams.userModel!.businessName!,
                      businessNumber:
                          widget.cubit.initialParams.userModel!.businessNumber!,
                      businessAddress: widget
                          .cubit.initialParams.userModel!.businessAddress!,
                    ),
                  if (widget.cubit.initialParams.userModel!.accountType == "GM")
                    GMNearbySelectionWidget(
                      businessAddress: widget.cubit.initialParams
                                  .userModelForOtherTavern?.businessAddress ==
                              null
                          ? 'Not Selected'
                          : widget.cubit.initialParams.userModelForOtherTavern!
                              .businessAddress!,
                      businessName: widget.cubit.initialParams
                                  .userModelForOtherTavern?.businessName ==
                              null
                          ? 'Not Selected'
                          : widget.cubit.initialParams.userModelForOtherTavern!
                              .businessName!,
                      onTap: () {
                        widget.cubit.navigateToPullsNearby();
                      },
                    ),
                  SizedBox(height: 10.v),
                  CustomTextFormField(
                    hintText: 'Event Name',
                    validator: (v) {
                      return validator(v);
                    },
                    onChanged: (v) {
                      widget.cubit.updatePostData(eventName: v);
                    },
                    prefix: Container(
                      margin: EdgeInsets.fromLTRB(16.h, 16.v, 12.h, 16.v),
                      child: CustomImageView(
                        imagePath: ImageConstant.user,
                        height: 24.adaptSize,
                        width: 24.adaptSize,
                      ),
                    ),
                  ),
                  SizedBox(height: 10.v),
                  Row(
                    children: [
                      Expanded(
                        child: CustomIconDualTextButton(
                          title: 'Event date',
                          value: DateFormat('dd/MM/yyyy')
                              .format(widget.state.eventDatetime),
                          icon: Icons.calendar_month,
                          ontap: () {
                            widget.cubit.updateDate(context);
                          },
                        ),
                      ),
                      SizedBox(width: 10.v),
                      Expanded(
                        child: CustomIconDualTextButton(
                          title: 'Event time',
                          value: DateFormat('h:mm a')
                              .format(widget.state.eventDatetime),
                          icon: Icons.timelapse,
                          ontap: () {
                            widget.cubit.updateTime(context);
                          },
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10.v),
                  Row(
                    children: [
                      Expanded(
                          child: CustomDropdownWidget(
                        validator: (v) {
                          return validator(v);
                        },
                        onChanged: (v) {
                          widget.cubit.updatePostData(eventType: v);
                        },
                        hinttext: 'Event Type',
                        list: [
                          'In Person',
                          'Online',
                        ],
                      )),
                      SizedBox(width: 10.v),
                      Expanded(
                          child: CustomDropdownWidget(
                        validator: (v) {
                          return validator(v);
                        },
                        onChanged: (v) {
                          widget.cubit.updatePostData(gameType: v);
                        },
                        hinttext: 'Game Type',
                        list: [
                          'TTRPG',
                          'Board Games',
                          'Card Games',
                        ],
                      )),
                    ],
                  ),
                  SizedBox(height: 10.v),
                  Row(
                    children: [
                      Expanded(
                          child: CustomDropdownWidget(
                        validator: (v) {
                          return validator(v);
                        },
                        hinttext: 'Game System',
                        onChanged: (v) {
                          widget.cubit.updatePostData(gameSystem: v);
                        },
                        list: [
                          'PF2E',
                          'DND5E',
                          'Other',
                        ],
                      )),
                      SizedBox(width: 10.v),
                      Expanded(
                          child: CustomDropdownWidget(
                        validator: (v) {
                          return validator(v);
                        },
                        onChanged: (v) {
                          widget.cubit.updatePostData(
                              isFree: v == 'Free' ? true : false);
                        },
                        hinttext: 'Select',
                        list: [
                          'Free',
                          'Paid',
                        ],
                      )),
                    ],
                  ),
                  SizedBox(height: 10.v),
                  CustomDropdownWidget(
                    validator: (v) {
                      return validator(v);
                    },
                    onChanged: (v) {
                      widget.cubit
                          .updatePostData(gmsRequired: int.parse(v.toString()));
                    },
                    hinttext: 'Number of GMs required',
                    list: [
                      '1',
                      '2',
                      '3',
                      '4',
                    ],
                  ),
                  SizedBox(height: 10.v),
                  CustomDropdownWidget(
                    validator: (v) {
                      return validator(v);
                    },
                    onChanged: (v) {
                      widget.cubit
                          .updatePostData(tables: int.parse(v.toString()));
                    },
                    hinttext: 'Number of tables',
                    list: [
                      '1',
                      '2',
                      '3',
                      '4',
                    ],
                  ),
                  SizedBox(height: 10.v),
                  CustomDropdownWidget(
                    validator: (v) {
                      return validator(v);
                    },
                    onChanged: (v) {
                      widget.cubit.updatePostData(
                          playerRequired: int.parse(v.toString()));
                    },
                    hinttext: 'Number of players',
                    list: [
                      '1',
                      '2',
                      '3',
                      '4',
                      '5',
                      '6',
                      '7',
                      '8',
                    ],
                  ),
                  SizedBox(height: 10.v),
                  CustomTextFormField(
                    maxLines: 5,
                    maxLength: 500,
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    hintText: 'Note',
                    onChanged: (v) {
                      widget.cubit.updatePostData(note: v);
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(
              horizontal: SizeUtils.width * .05, vertical: 20),
          child: CustomElevatedButton(
            text: 'Post',
            isLoading: widget.state.isPostUploading,
            onPressed: () {
              if (widget.cubit.initialParams.userModel!.accountType ==
                  "Tavern") {
                if (formKey.currentState?.validate() ?? false) {
                  widget.cubit.postEvent(context, true);
                } else {
                  log('missing');
                }
              } else if (widget.cubit.initialParams.userModel!.accountType ==
                  "GM") {
                if ((formKey.currentState?.validate() ?? false) &&
                    widget.cubit.initialParams.userModelForOtherTavern
                            ?.businessName !=
                        null &&
                    widget.cubit.initialParams.userModelForOtherTavern
                            ?.businessAddress !=
                        null) {
                  widget.cubit.postEvent(context, false);
                } else {
                  log('missing');
                }
              }
            },
          ),
        )
      ],
    );
  }
}

class GMNearbySelectionWidget extends StatelessWidget {
  const GMNearbySelectionWidget({
    Key? key,
    required this.businessName,
    required this.businessAddress,
    required this.onTap,
  }) : super(key: key);
  final String businessName;
  final String businessAddress;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      decoration: BoxDecoration(
        color: appTheme.yellow50,
        borderRadius: BorderRadius.circular(16.h),
      ),
      child: Column(
        children: [
          GestureDetector(
            onTap: onTap,
            child: Padding(
              padding: const EdgeInsets.only(top: 15, bottom: 15),
              child: Row(
                children: [
                  Icon(Icons.location_pin, color: theme.colorScheme.primary),
                  SizedBox(width: 20.h),
                  Text('Pulls Nearby Businesses'),
                  Spacer(),
                  Icon(Icons.arrow_forward_ios, color: appTheme.gray600),
                ],
              ),
            ),
          ),
          Divider(),
          Padding(
            padding: const EdgeInsets.only(top: 15, bottom: 15),
            child: Row(
              children: [
                Text(businessName),
              ],
            ),
          ),
          Divider(),
          Padding(
            padding: const EdgeInsets.only(top: 15, bottom: 15),
            child: Row(
              children: [
                Expanded(
                  child: Text(businessAddress),
                ),
                SizedBox(width: 20),
                Icon(Icons.location_searching_rounded, color: appTheme.gray600),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class TavernPostFields extends StatelessWidget {
  const TavernPostFields({
    Key? key,
    required this.businessName,
    required this.businessNumber,
    required this.businessAddress,
  }) : super(key: key);
  final String businessName;
  final String businessNumber;
  final String businessAddress;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomTextFormField(
          controller: TextEditingController(text: businessName.toString()),
          enabled: false,
          hintText: 'Business Name',
          prefix: Container(
            margin: EdgeInsets.fromLTRB(16.h, 16.v, 12.h, 16.v),
            child: CustomImageView(
              imagePath: ImageConstant.user,
              height: 24.adaptSize,
              width: 24.adaptSize,
            ),
          ),
        ),
        SizedBox(height: 10.v),
        CustomTextFormField(
          hintText: 'Business Number',
          controller: TextEditingController(text: businessNumber.toString()),
          enabled: false,
          prefix: Container(
            margin: EdgeInsets.fromLTRB(16.h, 16.v, 12.h, 16.v),
            child: CustomImageView(
              imagePath: ImageConstant.user,
              height: 24.adaptSize,
              width: 24.adaptSize,
            ),
          ),
        ),
        SizedBox(height: 10.v),
        CustomTextFormField(
          hintText: 'Business Address',
          controller: TextEditingController(text: businessAddress.toString()),
          enabled: false,
          prefix: Container(
            margin: EdgeInsets.fromLTRB(16.h, 16.v, 12.h, 16.v),
            child: CustomImageView(
              imagePath: ImageConstant.user,
              height: 24.adaptSize,
              width: 24.adaptSize,
            ),
          ),
        ),
      ],
    );
  }
}
