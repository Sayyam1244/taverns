import 'package:flutter/widgets.dart';
import 'package:taverns/widgets/custom_elevated_button.dart';

import '../../../core/app_export.dart';
import '../notification_board_cubit.dart';
import '../notification_board_state.dart';

class ManageWidget extends StatelessWidget {
  const ManageWidget({
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
        SizedBox(height: 10),
        ...[
          1,
          1,
          1,
          1,
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
                  Text('Notification 1', style: CustomTextStyles.titleMedium16),
            ),
            SizedBox(height: 12.v),
            Row(
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
            SizedBox(height: 30.v),
            Row(
              children: [
                Expanded(
                  child: CustomElevatedButton(
                      buttonStyle: CustomButtonStyles.fillYellow,
                      buttonTextStyle:
                          CustomTextStyles.titleSmallCircularStdBluegray70001,
                      height: 45.v,
                      text: 'Player request(3)'),
                ),
                SizedBox(width: 12.h),
                Expanded(
                  child: CustomElevatedButton(
                      buttonStyle: CustomButtonStyles.fillPrimaryTL8,
                      buttonTextStyle:
                          CustomTextStyles.titleSmallOnErrorContainer,
                      height: 45.v,
                      text: 'GM request(3)'),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
