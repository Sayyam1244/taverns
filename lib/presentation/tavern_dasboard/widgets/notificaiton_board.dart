import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:taverns/core/app_export.dart';
import 'package:taverns/presentation/tavern_dasboard/tavern_dashboard_cubit.dart';
import 'package:taverns/presentation/tavern_dasboard/tavern_dashboard_state.dart';

import 'notificationcard_item_widget.dart';

class NotificationBoardWidget extends StatelessWidget {
  const NotificationBoardWidget({Key? key, required this.cubit, required this.state}) : super(key: key);
  final TavernDashboardCubit cubit;
  final TavernDashboardState state;
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.topCenter,
      children: [
        Align(
          alignment: Alignment.center,
          child: Container(
            height: 195.v,
            width: 373.h,
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
          ),
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(15.h, 20.v, 15.h, 151.v),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Notification Board',
                style: CustomTextStyles.titleMediumCircularStdBluegray800.copyWith(
                  color: appTheme.blueGray800,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                  top: 2.v,
                  bottom: 4.v,
                ),
                child: InkWell(
                  onTap: () {
                    log('message');
                    cubit.navigateToNotificaitonBoard();
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
            height: 195.v,
            child: ListView.separated(
              padding: EdgeInsets.only(
                left: 15.h,
                top: 55.v,
                bottom: 20.v,
              ),
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
    );
  }
}
