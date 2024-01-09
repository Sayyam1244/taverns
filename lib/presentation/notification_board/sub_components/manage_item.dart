import 'package:flutter/material.dart';
import 'package:taverns/core/app_export.dart';

import '../../../domain/model/event_model.dart';
import '../../../widgets/custom_elevated_button.dart';
import '../notification_board_cubit.dart';

class ManageItem extends StatelessWidget {
  const ManageItem({
    Key? key,
    required this.event,
    required this.cubit,
  }) : super(key: key);

  final EventModel event;
  final NotificationBoardCubit cubit;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: SizeUtils.width * .05, vertical: 10.v),
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
              child: Text(event.eventName, style: CustomTextStyles.titleMedium16),
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
                        event.eventType,
                        style: CustomTextStyles.titleSmallProductSansBluegray800,
                      ),
                      SizedBox(height: 20.v),
                      Text(
                        'Game System',
                        style: CustomTextStyles.bodySmallSFProBluegray40001,
                      ),
                      SizedBox(height: 6.v),
                      Text(
                        event.gameSystem,
                        style: CustomTextStyles.titleSmallProductSansBluegray800,
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
                        'Game Type',
                        style: CustomTextStyles.bodySmallSFProBluegray40001,
                      ),
                      SizedBox(height: 6.v),
                      Text(
                        event.gameType,
                        style: CustomTextStyles.titleSmallProductSansBluegray800,
                      ),
                      SizedBox(height: 20.v),
                      Text(
                        'Game System',
                        style: CustomTextStyles.bodySmallSFProBluegray40001,
                      ),
                      SizedBox(height: 6.v),
                      Text(
                        event.gameSystem,
                        style: CustomTextStyles.titleSmallProductSansBluegray800,
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
                    onPressed: () {
                      cubit.openRequests(event.docId, event.gmsRequired, event.playerRequired, context, cubit);
                    },
                    buttonStyle: CustomButtonStyles.fillYellow,
                    buttonTextStyle: CustomTextStyles.titleSmallCircularStdBluegray70001,
                    height: 45.v,
                    text: 'Player request',
                  ),
                ),
                SizedBox(width: 12.h),
                Expanded(
                  child: CustomElevatedButton(
                    onPressed: () {
                      cubit.openRequests(
                        event.docId,
                        event.gmsRequired,
                        event.playerRequired,
                        context,
                        cubit,
                      );
                    },
                    buttonStyle: CustomButtonStyles.fillPrimaryTL8,
                    buttonTextStyle: CustomTextStyles.titleSmallOnErrorContainer,
                    height: 45.v,
                    text: 'GM request',
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
