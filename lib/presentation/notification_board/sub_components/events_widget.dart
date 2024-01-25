import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fpdart/fpdart.dart';
import 'package:taverns/domain/model/keyboolModel.dart';
import 'package:taverns/presentation/notification_board/sub_components/eventItem2.dart';
import 'package:taverns/widgets/custom_elevated_button.dart';
import '../../../core/app_export.dart';
import '../../../domain/model/event_model.dart';
import '../../../domain/model/general_model.dart';
import '../notification_board_cubit.dart';
import '../notification_board_state.dart';
import 'package:collection/collection.dart';

class EventsWidget extends StatelessWidget {
  const EventsWidget({
    Key? key,
    required this.cubit,
    required this.state,
  }) : super(key: key);
  final NotificationBoardCubit cubit;
  final NotificationBoardState state;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NotificationBoardCubit, NotificationBoardState>(
      bloc: cubit,
      builder: (context, state) =>
          StreamBuilder<Either<GeneralError, List<EventModel>>>(
        stream: cubit.event.getEvents(getUser: false, limit: 1000),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<EventModel> data = [];
            snapshot.data?.fold((l) => null, (r) {
              if (cubit.initialParams.userModel!.accountType != 'Tavern')
                r.removeWhere((element) =>
                    element.userId == cubit.auth.currentUser().uid);
              if (state.isFilterApplied!) {
                data = r.where((element) {
                  bool filterCondition = true;

                  if (state.tavernGmOnly[0].istrue ||
                      state.tavernGmOnly[1].istrue) {
                    filterCondition = filterCondition &&
                        ((state.tavernGmOnly[0].istrue &&
                                element.requestedTavern == null) ||
                            (state.tavernGmOnly[1].istrue &&
                                element.requestedTavern != null));
                  }

                  // Event type filters
                  if (state.otherFilters[0].istrue) {
                    filterCondition =
                        filterCondition && (element.eventType == 'Online');
                  }
                  if (state.otherFilters[1].istrue) {
                    filterCondition =
                        filterCondition && (element.eventType == 'In Person');
                  }

                  if (state.otherFilters[2].istrue ||
                      state.otherFilters[3].istrue) {
                    filterCondition = filterCondition &&
                        ((state.otherFilters[2].istrue &&
                                element.isFree == false) ||
                            (state.otherFilters[3].istrue &&
                                element.isFree == true));
                  }

                  // Game type filters
                  // Game type filters
                  bool anyGameTypeSelected = state.otherFilters
                      .sublist(4)
                      .any((filter) => filter.istrue);
                  if (anyGameTypeSelected) {
                    filterCondition = filterCondition &&
                        state.otherFilters.sublist(4).any((filter) {
                          return filter.istrue &&
                              element.gameType == filter.title;
                        });
                  }

                  return filterCondition;
                }).toList();
              } else {
                data = r;
              }
            });

            log(state.isFilterApplied.toString());
            return Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    if (state.isFilterApplied!)
                      GestureDetector(
                        onTap: () {
                          cubit.applyFilters(false);
                        },
                        child: Container(
                          margin: EdgeInsets.only(top: 10, right: 10),
                          decoration: BoxDecoration(
                              color: appTheme.gray400,
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(color: appTheme.gray400)),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 12),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              SizedBox(width: 10),
                              Text(
                                'Clear Filters',
                                style: CustomTextStyles.titleMedium16.copyWith(
                                    color: appTheme.white, fontSize: 14),
                              ),
                              SizedBox(width: 10),
                              Icon(
                                Icons.close,
                                color: appTheme.white,
                                size: 10,
                              )
                            ],
                          ),
                        ),
                      ),
                    GestureDetector(
                      onTap: () {
                        cubit.toggleFilterVisibility();
                      },
                      child: Container(
                        margin: EdgeInsets.only(top: 10, right: 20),
                        decoration: BoxDecoration(
                            color: state.showFilter!
                                ? theme.colorScheme.primary
                                : appTheme.white,
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(color: appTheme.gray400)),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 12),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            SizedBox(width: 10),
                            Text(
                              'Filter',
                              style: CustomTextStyles.titleMedium16.copyWith(
                                  fontSize: 14,
                                  color: state.showFilter!
                                      ? appTheme.white
                                      : appTheme.blueGray800),
                            ),
                            SizedBox(width: 10),
                            Icon(
                              Icons.keyboard_arrow_down_outlined,
                              size: 14,
                              color: state.showFilter!
                                  ? appTheme.white
                                  : appTheme.blueGray800,
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                if (!state.showFilter!)
                  Expanded(
                    child: ListView.separated(
                      separatorBuilder: (
                        context,
                        index,
                      ) =>
                          SizedBox(width: 16.h),
                      itemCount: data.length,
                      itemBuilder: (context, index) {
                        return EventItem2(
                          event: data[index],
                          cubit: cubit,
                          requestToJoin: true,
                        );
                      },
                    ),
                  ),
                if (state.showFilter!)
                  Column(
                    children: [
                      Container(
                        height: 40,
                        margin: EdgeInsets.only(top: 10),
                        width: double.infinity,
                        child: ListView(
                          padding: EdgeInsets.only(
                            left: 18,
                          ),
                          scrollDirection: Axis.horizontal,
                          children: state.tavernGmOnly
                              .mapIndexed(
                                (index, element) => Padding(
                                  padding: const EdgeInsets.only(right: 18),
                                  child: FilterChip(
                                    label: Text(element.title),
                                    onSelected: (v) {
                                      cubit.changeOnlyTavernGm(index);
                                    },
                                    selected: state.tavernGmOnly[index].istrue,
                                    checkmarkColor:
                                        theme.colorScheme.background,
                                    selectedColor: theme.colorScheme.primary,
                                    labelStyle: CustomTextStyles
                                        .bodySmallCircularStdBluegray40001
                                        .copyWith(
                                            color: element.istrue
                                                ? appTheme.white
                                                : appTheme.blueGray900
                                            //  theme.colorScheme.background,
                                            ),
                                  ),
                                ),
                              )
                              .toList(),
                        ),
                      ),
                      Padding(
                        padding:
                            const EdgeInsets.only(left: 18, right: 18, top: 20),
                        child: Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            'Game and Event Filters',
                            style: CustomTextStyles
                                .titleMediumCircularStdBluegray90001
                                .copyWith(color: appTheme.blueGray800),
                          ),
                        ),
                      ),
                      Container(
                        height: 40,
                        margin: EdgeInsets.only(top: 10),
                        width: double.infinity,
                        child: ListView(
                          padding: EdgeInsets.only(
                            left: 18,
                          ),
                          scrollDirection: Axis.horizontal,
                          children: state.otherFilters
                              .mapIndexed(
                                (index, element) => Padding(
                                  padding: const EdgeInsets.only(right: 18),
                                  child: FilterChip(
                                    label: Text(element.title),
                                    onSelected: (v) {
                                      cubit.changeFilterByIndex(index);
                                    },
                                    selected: element.istrue,
                                    checkmarkColor:
                                        theme.colorScheme.background,
                                    selectedColor: theme.colorScheme.primary,
                                    labelStyle: CustomTextStyles
                                        .bodySmallCircularStdBluegray40001
                                        .copyWith(
                                            color: element.istrue
                                                ? appTheme.white
                                                : appTheme.blueGray900),
                                  ),
                                ),
                              )
                              .toList(),
                        ),
                      ),
                      SizedBox(height: 20),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 18),
                        child: CustomElevatedButton(
                          text:
                              // state.isFilterApplied!
                              //     ? "Clear Filters"
                              // :
                              'Apply Filters',
                          onPressed: () {
                            // if (state.isFilterApplied!) {
                            //   cubit.applyFilters(false);
                            // } else {
                            cubit.applyFilters(true);
                            // }
                          },
                        ),
                      )
                    ],
                  )
              ],
            );
          }
          return ListView.separated(
            separatorBuilder: (
              context,
              index,
            ) =>
                SizedBox(width: 16.h),
            itemCount: 2,
            itemBuilder: (context, index) {
              return Container(
                height: 250,
                margin: EdgeInsets.symmetric(
                    horizontal: SizeUtils.width * .05, vertical: 10.v),
                decoration: BoxDecoration(
                  color: theme.colorScheme.background,
                  borderRadius: BorderRadius.circular(
                    12,
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class TagWidget extends StatelessWidget {
  const TagWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 10),
      height: 30,
      padding: EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
          color: appTheme.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: appTheme.gray400)),
      child: Center(child: Text('Taverns only')),
    );
  }
}
