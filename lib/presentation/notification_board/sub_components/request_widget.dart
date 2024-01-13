import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:taverns/widgets/custom_elevated_button.dart';

import '../../../core/app_export.dart';
import '../notification_board_cubit.dart';
import '../notification_board_state.dart';

class RequestWidget extends StatelessWidget {
  const RequestWidget({
    Key? key,
    required this.cubit,
    required this.state,
  }) : super(key: key);
  final NotificationBoardCubit cubit;
  final NotificationBoardState state;
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        SizedBox(height: 10),
        ...[
          1,
        ].map((e) => ManageItem()).toList()
      ],
    );
  }
}

class ManageItem extends StatelessWidget {
  const ManageItem({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: 250,
      margin: EdgeInsets.symmetric(
          horizontal: SizeUtils.width * .05, vertical: 10.v),
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
              child:
                  Text('GM001 Request', style: CustomTextStyles.titleMedium16),
            ),
            SizedBox(height: 12.v),
            InkWell(
              onTap: () {
                showBottomSheet(context);
              },
              child: Row(
                children: [
                  Expanded(
                    flex: 4,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Event Type',
                          style: CustomTextStyles.bodySmallSFProBluegray40001,
                        ),
                        SizedBox(height: 6.v),
                        Text(
                          'PERSON',
                          style:
                              CustomTextStyles.titleSmallProductSansBluegray800,
                        ),
                        SizedBox(height: 20.v),
                        Text(
                          'Game System',
                          style: CustomTextStyles.bodySmallSFProBluegray40001,
                        ),
                        SizedBox(height: 6.v),
                        Text(
                          'PF2E',
                          style:
                              CustomTextStyles.titleSmallProductSansBluegray800,
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Event Type',
                          style: CustomTextStyles.bodySmallSFProBluegray40001,
                        ),
                        SizedBox(height: 6.v),
                        Text(
                          'PERSON',
                          style:
                              CustomTextStyles.titleSmallProductSansBluegray800,
                        ),
                        SizedBox(height: 20.v),
                        Text(
                          'Game System',
                          style: CustomTextStyles.bodySmallSFProBluegray40001,
                        ),
                        SizedBox(height: 6.v),
                        Text(
                          'PF2E',
                          style:
                              CustomTextStyles.titleSmallProductSansBluegray800,
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            SizedBox(height: 30.v),
            Row(
              children: [
                Expanded(
                  child: CustomElevatedButton(
                      buttonStyle: CustomButtonStyles.fillYellow,
                      buttonTextStyle:
                          CustomTextStyles.titleSmallCircularStdBluegray70001,
                      height: 45.v,
                      text: 'Approve'),
                ),
                SizedBox(width: 12.h),
                Expanded(
                  child: CustomElevatedButton(
                      buttonStyle: CustomButtonStyles.fillPrimaryTL8,
                      buttonTextStyle:
                          CustomTextStyles.titleSmallOnErrorContainer,
                      height: 45.v,
                      text: 'Deny'),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  showBottomSheet(context) {
    return showModalBottomSheet(
      backgroundColor: Colors.transparent,
      context: context,
      builder: (BuildContext context) {
        return Container(
          decoration: BoxDecoration(
              color: theme.colorScheme.background,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              )),
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Align(
                    alignment: Alignment.topRight,
                    child: IconButton(
                      icon: Icon(Icons.close),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    )),
                Text(
                  'Number of Players (0)',
                  style: CustomTextStyles.headlineSmallOnPrimary,
                ),
                Expanded(
                  child: ListView(
                    children: [
                      Text(
                        '''Requesting the time slot specified so I may run a table of adventurers through xyz. Please let me know if that is okay. Since this is a public event The following rules will be in effect:\n-No horror\n-No sexually explicit or vulgar content\n-No PVP unless agreed upon before the session startsRequesting the time slot specified so I may run a table of adventurers through xyz. Please let me know if that is okay. Since this is a public event The following rules will be in effect:\n-No horror\n-No sexually explicit or vulgar content\n-No PVP unless agreed upon before the session starts''',
                        style: CustomTextStyles.titleMediumGray60001,
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
