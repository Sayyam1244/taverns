import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:taverns/core/app_export.dart';
import 'package:taverns/domain/model/event_model.dart';
import 'package:taverns/widgets/custom_icon_button.dart';
import '../../../widgets/custom_elevated_button.dart';

// ignore: must_be_immutable
class EventcardItemWidget extends StatelessWidget {
  const EventcardItemWidget({Key? key, required this.event})
      : super(
          key: key,
        );
  final EventModel event;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15.h),
      decoration: AppDecoration.outlineBlueGray.copyWith(
        borderRadius: BorderRadiusStyle.roundedBorder8,
      ),
      width: MediaQuery.sizeOf(context).width * 0.8,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            height: 60.adaptSize,
            width: 60.adaptSize,
            decoration: BoxDecoration(
                border: Border.all(color: appTheme.blueGray100, width: 1),
                shape: BoxShape.circle,
                image: event.user!.profilePicture != null ? DecorationImage(image: NetworkImage(event.user?.profilePicture ?? ''), fit: BoxFit.cover) : null),
          ),
          Padding(
            padding: EdgeInsets.only(
              left: 15.h,
              top: 8.v,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  event.eventName,
                  style: CustomTextStyles.titleMediumCircularStdBluegray90001,
                ),
                SizedBox(height: 6.v),
                Text(
                  DateFormat('hh:mm:a - dd/MM/yyyy').format(event.eventDatetime),
                  style: CustomTextStyles.bodySmallSFProBluegray40001,
                ),
                SizedBox(height: 8.v),
                // Row(
                //   children: [
                //     CustomElevatedButton(
                //       height: 31.v,
                //       width: 94.h,
                //       text: "Approve",
                //       buttonStyle: CustomButtonStyles.fillPrimaryTL8,
                //       buttonTextStyle: CustomTextStyles.labelLargeOnErrorContainer_1,
                //     ),
                //     SizedBox(width: 10.h),
                //     CustomElevatedButton(
                //       height: 31.v,
                //       width: 60.h,
                //       text: "Deny",
                //       buttonStyle: CustomButtonStyles.fillYellow,
                //       buttonTextStyle: CustomTextStyles.labelLargePrimary,
                //     )
                //   ],
                // )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
