import 'package:flutter/material.dart';
import 'package:taverns/core/app_export.dart';

import '../../../domain/model/event_model.dart';
import '../../../widgets/custom_elevated_button.dart';
import '../notification_board_cubit.dart';

class EventItem2 extends StatelessWidget {
  const EventItem2({
    Key? key,
    required this.event,
    required this.cubit,
    required this.requestToJoin,
  }) : super(key: key);

  final EventModel event;
  final NotificationBoardCubit cubit;
  final bool requestToJoin;
  @override
  Widget build(BuildContext context) {
    return Container(
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
              child: Row(
                children: [
                  Text(event.eventName,
                      style:
                          CustomTextStyles.titleMediumCircularStdBluegray90001),
                  Spacer(),
                  Text(
                    event.eventDatetime.format(),
                    style: CustomTextStyles.bodySmallSFProBluegray40001,
                  ),
                ],
              ),
            ),
            SizedBox(height: 12.v),
            Align(
              alignment: Alignment.topLeft,
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      event.businessAddress,
                      style: CustomTextStyles.bodySmallSFProBluegray40001,
                    ),
                  ),
                  SizedBox(width: 20),
                  Icon(Icons.location_pin, color: appTheme.gray600),
                ],
              ),
            ),
            SizedBox(height: 30.v),
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
            if (requestToJoin) SizedBox(height: 20.v),
            if (requestToJoin)
              CustomElevatedButton(
                text: 'Request to join',
                onPressed: () {
                  cubit.requestToJoin(event: event, context: context);
                },
              ),
            SizedBox(height: 20.v),
          ],
        ),
      ),
    );
  }
}
