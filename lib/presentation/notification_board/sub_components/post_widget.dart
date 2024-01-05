import 'package:flutter/material.dart';
import 'package:taverns/widgets/custom_text_form_field.dart';

import '../../../core/app_export.dart';
import '../../../widgets/custom_elevated_button.dart';
import '../notification_board_cubit.dart';
import '../notification_board_page.dart';
import '../notification_board_state.dart';

class PostWidget extends StatelessWidget {
  const PostWidget({
    Key? key,
    required this.cubit,
    required this.state,
  }) : super(key: key);
  final NotificationBoardCubit cubit;
  final NotificationBoardState state;
  @override
  Widget build(BuildContext context) {
    return Column(
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
            child: Column(
              children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: Text('Post a Notification',
                      style: CustomTextStyles.titleMedium16),
                ),
                SizedBox(height: 20.v),
                CustomTextFormField(
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
                            value: '01/12/2023',
                            icon: Icons.calendar_month)),
                    SizedBox(width: 10.v),
                    Expanded(
                        child: CustomIconDualTextButton(
                            title: 'Event time',
                            value: '2:00PM',
                            icon: Icons.timelapse)),
                  ],
                ),
                SizedBox(height: 10.v),
                Row(
                  children: [
                    Expanded(
                        child: CustomDropdownWidget(
                      hinttext: 'Event Type',
                      list: [
                        'Gasdd',
                        'Gasdd1',
                        'Gasdd2',
                        'Gasdd4',
                        'Gasdd23',
                      ],
                    )),
                    SizedBox(width: 10.v),
                    Expanded(
                        child: CustomDropdownWidget(
                      hinttext: 'Game Type',
                      list: [
                        'Gasdd',
                        'Gasdd1',
                        'Gasdd2',
                        'Gasdd4',
                        'Gasdd23',
                      ],
                    )),
                  ],
                ),
                SizedBox(height: 10.v),
                Row(
                  children: [
                    Expanded(
                        child: CustomDropdownWidget(
                      hinttext: 'Game System',
                      list: [
                        'Gasdd',
                        'Gasdd1',
                        'Gasdd2',
                        'Gasdd4',
                        'Gasdd23',
                      ],
                    )),
                    SizedBox(width: 10.v),
                    Expanded(
                        child: CustomDropdownWidget(
                      hinttext: 'Free',
                      list: [
                        'Gasdd',
                        'Gasdd1',
                        'Gasdd2',
                        'Gasdd4',
                        'Gasdd23',
                      ],
                    )),
                  ],
                ),
                SizedBox(height: 10.v),
                CustomDropdownWidget(
                  hinttext: 'Number of GMs required',
                  list: [
                    'Gasdd',
                    'Gasdd1',
                    'Gasdd2',
                    'Gasdd4',
                    'Gasdd23',
                  ],
                ),
                SizedBox(height: 10.v),
                CustomDropdownWidget(
                  hinttext: 'Number of tables',
                  list: [
                    'Gasdd',
                    'Gasdd1',
                    'Gasdd2',
                    'Gasdd4',
                    'Gasdd23',
                  ],
                ),
                SizedBox(height: 10.v),
                CustomDropdownWidget(
                  hinttext: 'Number of players',
                  list: [
                    'Gasdd',
                    'Gasdd1',
                    'Gasdd2',
                    'Gasdd4',
                    'Gasdd23',
                  ],
                ),
                SizedBox(height: 10.v),
                CustomTextFormField(
                  maxLines: 5,
                  contentPadding: EdgeInsets.all(12),
                )
              ],
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(
              horizontal: SizeUtils.width * .05, vertical: 20),
          child: CustomElevatedButton(text: 'Post'),
        )
      ],
    );
  }
}
