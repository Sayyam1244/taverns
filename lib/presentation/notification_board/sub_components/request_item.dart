import 'package:flutter/material.dart';
import 'package:taverns/domain/model/request_model.dart';
import 'package:taverns/presentation/notification_board/notification_board_cubit.dart';

import '../../../core/app_export.dart';
import '../../../widgets/custom_elevated_button.dart';

class RequestItem extends StatelessWidget {
  const RequestItem({Key? key, required this.requestModel, required this.cubit})
      : super(key: key);
  final RequestModel requestModel;
  final NotificationBoardCubit cubit;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 20.v),
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
              child: Text(
                  "The ${requestModel.userName} has requested a ${requestModel.requestedFor} slot.",
                  style: CustomTextStyles.titleMediumCircularStdBluegray90001),
            ),
            SizedBox(height: 20.v),
            Row(
              children: [
                Expanded(
                  child: CustomElevatedButton(
                    onPressed: () {
                      cubit.requestApproved(true, requestModel.docId,
                          requestModel.eventId, context);
                    },
                    buttonStyle: CustomButtonStyles.fillYellow,
                    buttonTextStyle:
                        CustomTextStyles.titleSmallCircularStdBluegray70001,
                    height: 45.v,
                    text: 'Approve',
                  ),
                ),
                SizedBox(width: 12.h),
                Expanded(
                  child: CustomElevatedButton(
                    onPressed: () {
                      cubit.requestApproved(false, requestModel.docId,
                          requestModel.eventId, context);
                    },
                    buttonStyle: CustomButtonStyles.fillPrimaryTL8,
                    buttonTextStyle:
                        CustomTextStyles.titleSmallOnErrorContainer,
                    height: 45.v,
                    text: 'Deny',
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
