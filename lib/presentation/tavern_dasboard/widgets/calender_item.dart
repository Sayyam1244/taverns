import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:taverns/core/app_export.dart';
import '../../../domain/model/event_model.dart';
import '../../../widgets/custom_icon_button.dart';

class CalenderItem extends StatelessWidget {
  const CalenderItem({Key? key, required this.event})
      : super(
          key: key,
        );
  final EventModel event;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15.h, vertical: 10.v),
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      decoration: AppDecoration.outlineBlueGray.copyWith(
        borderRadius: BorderRadiusStyle.roundedBorder8,
      ),
      width: MediaQuery.sizeOf(context).width * 0.8,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          CustomIconButton(
            height: 40.adaptSize,
            width: 40.adaptSize,
            padding: EdgeInsets.all(10.h),
            decoration: IconButtonStyleHelper.outlineGrayF,
            child: CustomImageView(
              imagePath: ImageConstant.imgCard,
            ),
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
                Container(
                  width: MediaQuery.sizeOf(context).width * 0.6,
                  child: Text(
                    event.eventName,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: CustomTextStyles.titleMediumCircularStdBluegray90001,
                  ),
                ),
                SizedBox(height: 6.v),
                Text(
                  DateFormat('hh:mm:a - dd/MM/yyyy').format(event.eventDatetime),
                  style: CustomTextStyles.bodySmallSFProBluegray40001,
                ),
                SizedBox(height: 8.v),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
