import 'package:flutter/material.dart';

import '../../../core/app_export.dart';
import '../tavern_dashboard_cubit.dart';
import '../tavern_dashboard_state.dart';

class TavernProfileTopbar extends StatelessWidget {
  const TavernProfileTopbar({
    Key? key,
    required this.cubit,
    required this.state,
  }) : super(key: key);
  final TavernDashboardCubit cubit;
  final TavernDashboardState state;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      padding: EdgeInsets.all(20.h),
      decoration: AppDecoration.outlineSecondaryContainer.copyWith(
        borderRadius: BorderRadiusStyle.roundedBorder40B,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: 43.adaptSize,
            width: 43.adaptSize,
            alignment: Alignment.center,
            decoration: BoxDecoration(
                // image: state.user.profilePicture != null
                //     ? DecorationImage(
                //         image: NetworkImage(state.user.profilePicture!),
                //         fit: BoxFit.cover)
                //     : null,
                shape: BoxShape.circle,
                border: Border.all(
                  color: theme.colorScheme.primary,
                  width: 1,
                ),
                color: theme.colorScheme.primary),
            child: Text(
              state.user.userName.toString().characters.first,
              style:
                  CustomTextStyles.titlelarge.copyWith(color: appTheme.white),
            ),
          ),
          state.user.accountType == 'Tavern'
              ? Padding(
                  padding: EdgeInsets.only(
                    left: 12.h,
                    top: 3.v,
                    bottom: 3.v,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        state.user.userName ?? '',
                        style:
                            CustomTextStyles.titleSmallProductSansBluegray800,
                      ),
                      SizedBox(height: 6.v),
                      Text(
                        state.user.businessNumber ?? '',
                        style: theme.textTheme.labelMedium,
                      ),
                    ],
                  ),
                )
              : Padding(
                  padding: EdgeInsets.only(
                    left: 12.h,
                  ),
                  child: Text(
                    state.user.userName ?? '',
                    style: CustomTextStyles.titleSmallProductSansBluegray800,
                  ),
                ),
          Spacer(),
          GestureDetector(
            onTap: () {
              cubit.onEditProfile();
            },
            child: CustomImageView(
              imagePath: ImageConstant.imgEdit,
              height: 18.adaptSize,
              width: 18.adaptSize,
              margin: EdgeInsets.only(
                top: 12.v,
                bottom: 13.v,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
