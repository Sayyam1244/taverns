import 'package:flutter/material.dart';
import 'package:taverns/core/app_export.dart';
import 'package:taverns/domain/model/notification_model.dart';

class NotificationItem extends StatelessWidget {
  const NotificationItem({
    Key? key,
    required this.notification,
  }) : super(key: key);
  final NotificationModel notification;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: 20.h,
        vertical: 10.v,
      ),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: theme.colorScheme.background,
        border: Border.all(
          color: appTheme.gray50,
        ),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            notification.sender!,
            style: CustomTextStyles.titleMediumCircularStdBluegray800,
          ),
          SizedBox(height: 4.v),
          Text(
            notification.createdDate!.format(),
            style: CustomTextStyles.bodySmallCircularStdBluegray40001,
          ),
          SizedBox(height: 6.v),
          Text(
            notification.notification.toString(),
            style: CustomTextStyles.bodySmallCircularStdBluegray40001
                .copyWith(height: 1.5),
          ),
        ],
      ),
    );
  }
}
