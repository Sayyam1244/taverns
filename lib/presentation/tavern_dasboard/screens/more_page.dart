import 'package:flutter/material.dart';
import 'package:taverns/core/app_export.dart';
import 'package:taverns/presentation/quality_of_life/quality_of_life_initial_params.dart';
import 'package:taverns/presentation/tavern_dasboard/tavern_dashboard_cubit.dart';
import 'package:taverns/presentation/tavern_dasboard/tavern_dashboard_state.dart';

import '../widgets/tavern_profile_topbar.dart';

// ignore_for_file: must_be_immutable
class MorePage extends StatelessWidget {
  const MorePage({Key? key, required this.cubit, required this.state})
      : super(
          key: key,
        );
  final TavernDashboardCubit cubit;
  final TavernDashboardState state;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      decoration: AppDecoration.fillOnErrorContainer,
      child: Column(
        children: [
          TavernProfileTopbar(cubit: cubit, state: state),
          Expanded(
            child: Container(
              margin: EdgeInsets.only(top: 15.v),
              padding: EdgeInsets.symmetric(
                horizontal: 16.h,
              ),
              child: Column(
                children: [
                  MoreItem(
                      title: 'Notification Board',
                      ontap: () {
                        cubit.navigateToNotificaitonBoard();
                      }),
                  MoreItem(
                      title: 'Database',
                      ontap: () {
                        cubit.navigateToDatabase();
                      }),
                  MoreItem(
                      title: 'QOL (Quality of Life)',
                      ontap: () {
                        cubit.navigator
                            .openQualityOfLife(QualityOfLifeInitialParams());
                      }),
                  MoreItem(title: 'How-To', ontap: () {}),
                  MoreItem(title: 'Support', ontap: () {}),
                  MoreItem(title: 'Safety Tips', ontap: () {}),
                  SizedBox(height: 20.v),
                  GestureDetector(
                    onTap: () {
                      cubit.logout();
                    },
                    child: Padding(
                      padding: EdgeInsets.only(left: 14.h),
                      child: Row(
                        children: [
                          CustomImageView(
                            imagePath: ImageConstant.imgThumbsUpRed400,
                            height: 20.adaptSize,
                            width: 20.adaptSize,
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 8.h),
                            child: Text(
                              "Logout",
                              style: CustomTextStyles.titleSmallMulishRed400,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Spacer(),
                  Align(
                    alignment: Alignment.center,
                    child: Text(
                      "Tavern",
                      style: CustomTextStyles.titleMediumMulishPrimary,
                    ),
                  ),
                  SizedBox(height: 5.v),
                  Align(
                    alignment: Alignment.center,
                    child: Text(
                      "V.0.0.1",
                      style: CustomTextStyles.bodySmallMulishBluegray900,
                    ),
                  ),
                  SizedBox(height: 20.v),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class MoreItem extends StatelessWidget {
  const MoreItem({
    Key? key,
    required this.title,
    required this.ontap,
  }) : super(key: key);
  final String title;
  final VoidCallback ontap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ontap,
      child: Column(
        children: [
          SizedBox(height: 20.v),
          Padding(
            padding: EdgeInsets.only(left: 14.h),
            child: Row(
              children: [
                CustomImageView(
                  imagePath: ImageConstant.imgGroup33151,
                  height: 16.adaptSize,
                  width: 16.adaptSize,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 29.h),
                  child: Text(
                    title,
                    style: CustomTextStyles.titleSmallCircularStdBluegray800,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 20.v),
          Divider(),
        ],
      ),
    );
  }
}
