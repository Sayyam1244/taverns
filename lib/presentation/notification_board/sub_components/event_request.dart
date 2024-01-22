import 'package:flutter/material.dart';
import 'package:taverns/domain/model/event_model.dart';
import 'package:taverns/presentation/notification_board/notification_board_cubit.dart';

import '../../../core/app_export.dart';
import '../../../widgets/custom_elevated_button.dart';

class EventRequest extends StatelessWidget {
  const EventRequest({
    Key? key,
    required this.event,
    required this.cubit,
  }) : super(key: key);
  final EventModel event;
  final NotificationBoardCubit cubit;
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
              child: Text('${event.user!.userName} Request',
                  style: CustomTextStyles.titleMedium16),
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
                          event.eventType,
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
                          event.gameSystem,
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
                          'Game Type',
                          style: CustomTextStyles.bodySmallSFProBluegray40001,
                        ),
                        SizedBox(height: 6.v),
                        Text(
                          event.gameType,
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
                          event.gameSystem,
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
                      onPressed: () {
                        cubit.approveEventRequest(true, event);
                      },
                      buttonStyle: CustomButtonStyles.fillYellow,
                      buttonTextStyle:
                          CustomTextStyles.titleSmallCircularStdBluegray70001,
                      height: 45.v,
                      text: 'Approve'),
                ),
                SizedBox(width: 12.h),
                Expanded(
                  child: CustomElevatedButton(
                      onPressed: () {
                        cubit.approveEventRequest(false, event);
                      },
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
                  'Number of Players (${event.playerRequired})',
                  style: CustomTextStyles.headlineSmallOnPrimary,
                ),
                Expanded(
                  child: ListView(
                    children: [
                      Text(
                        event.note,
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
