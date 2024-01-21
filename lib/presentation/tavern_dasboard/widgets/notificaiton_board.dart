import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:taverns/core/app_export.dart';
import 'package:taverns/presentation/tavern_dasboard/tavern_dashboard_cubit.dart';
import 'package:taverns/presentation/tavern_dasboard/tavern_dashboard_state.dart';

import 'notificationcard_item_widget.dart';

class NotificationBoardWidget extends StatelessWidget {
  const NotificationBoardWidget(
      {Key? key, required this.cubit, required this.state})
      : super(key: key);
  final TavernDashboardCubit cubit;
  final TavernDashboardState state;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.sizeOf(context).width,
      decoration: BoxDecoration(
        color: theme.colorScheme.onErrorContainer.withOpacity(1),
        borderRadius: BorderRadius.circular(
          16.h,
        ),
        boxShadow: [
          BoxShadow(
            color: theme.colorScheme.secondaryContainer,
            spreadRadius: 2.h,
            blurRadius: 2.h,
            offset: Offset(
              0,
              0,
            ),
          ),
        ],
      ),
      child: Column(
        // alignment: Alignment.topCenter,
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(15.h, 20.v, 15.h, 15.v),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: () {
                    cubit.navigateToNotificaitonBoard();
                  },
                  child: Text(
                    'Notification Board',
                    style: CustomTextStyles.titleMediumCircularStdBluegray800
                        .copyWith(
                      color: appTheme.blueGray800,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    top: 2.v,
                    bottom: 4.v,
                  ),
                  child: GestureDetector(
                    onTap: () {
                      cubit.navigateToNotifications();
                    },
                    child: Text(
                      'See All',
                      style: CustomTextStyles.labelLargePrimary.copyWith(
                        color: theme.colorScheme.primary,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: SizedBox(
              height: 165.v,
              child: ListView.separated(
                padding: EdgeInsets.only(left: 15.h, bottom: 20.v, top: 15.v),
                scrollDirection: Axis.horizontal,
                separatorBuilder: (
                  context,
                  index,
                ) {
                  return SizedBox(
                    width: 17.h,
                  );
                },
                itemCount: 2,
                itemBuilder: (context, index) {
                  return NotificationcardItemWidget();
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
