import 'package:flutter/material.dart';
import 'package:fpdart/fpdart.dart';
import 'package:taverns/core/app_export.dart';
import 'package:taverns/domain/model/event_model.dart';
import 'package:taverns/domain/model/general_model.dart';
import 'package:taverns/domain/model/user_model.dart';

import '../../../widgets/custom_elevated_button.dart';
import '../../../widgets/custom_search_view.dart';
import '../tavern_dashboard_cubit.dart';
import '../tavern_dashboard_state.dart';
import '../widgets/eventcard_item_widget.dart';
import '../widgets/notificaiton_board.dart';
import '../widgets/tavern_profile_widget.dart';

class TavernHome extends StatelessWidget {
  TavernHome({
    Key? key,
    required this.cubit,
    required this.state,
  }) : super(key: key);

  final TavernDashboardCubit cubit;
  final TavernDashboardState state;
  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: SizeUtils.width,
      child: SingleChildScrollView(
        padding: EdgeInsets.only(top: 2.v),
        child: Padding(
          padding: EdgeInsets.only(
            left: 2.h,
            bottom: 5.v,
          ),
          child: Column(
            children: [
              TavernProfileWidget(cubit: cubit, state: state),
              SizedBox(height: 24.v),
              NotificationBoardWidget(cubit: cubit, state: state),
              SizedBox(height: 24.v),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 18),
                child: CustomSearchView(
                  controller: searchController,
                  hintText: "Find Event",
                ),
              ),
              SizedBox(height: 26.v),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 18, vertical: 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Upcoming Events',
                      style: CustomTextStyles.titleMediumCircularStdBluegray800.copyWith(
                        color: appTheme.blueGray800,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        top: 2.v,
                        bottom: 4.v,
                      ),
                      child: Text(
                        'See All',
                        style: CustomTextStyles.labelLargePrimary.copyWith(
                          color: theme.colorScheme.primary,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 12.v),
              SizedBox(
                height: 130.v,
                child: StreamBuilder<Either<GeneralError, List<EventModel>>>(
                  stream: cubit.events.getEvents(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      List<EventModel> data = [];
                      snapshot.data?.fold((l) => null, (r) => data = r);
                      return ListView.separated(
                        padding: EdgeInsets.only(left: 13.h),
                        scrollDirection: Axis.horizontal,
                        separatorBuilder: (
                          context,
                          index,
                        ) =>
                            SizedBox(
                          width: 16.h,
                        ),
                        itemCount: data.length,
                        itemBuilder: (context, index) {
                          return EventcardItemWidget(
                            event: data[index],
                          );
                        },
                      );
                    }
                    return ListView.separated(
                      padding: EdgeInsets.only(left: 13.h),
                      scrollDirection: Axis.horizontal,
                      separatorBuilder: (
                        context,
                        index,
                      ) {
                        return SizedBox(
                          width: 16.h,
                        );
                      },
                      itemCount: 2,
                      itemBuilder: (context, index) {
                        return Container(
                          padding: EdgeInsets.all(15.h),
                          decoration: AppDecoration.outlineBlueGray.copyWith(
                            borderRadius: BorderRadiusStyle.roundedBorder8,
                          ),
                          width: MediaQuery.sizeOf(context).width * 0.8,
                        );
                      },
                    );
                  },
                ),
              ),
              SizedBox(height: 24.v),
              CustomElevatedButton(
                text: "Safety Tips",
                margin: EdgeInsets.only(
                  left: 22.h,
                  right: 24.h,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
