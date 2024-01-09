import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:taverns/core/app_export.dart';
import 'package:taverns/domain/model/event_model.dart';
import 'package:taverns/domain/model/general_model.dart';
import 'package:fpdart/fpdart.dart' as either;
import 'package:taverns/presentation/tavern_dasboard/widgets/calender_item.dart';
import 'package:taverns/widgets/custome_loading_widget.dart';

import '../tavern_dashboard_cubit.dart';
import '../tavern_dashboard_state.dart';

class CalenderScreen extends StatefulWidget {
  const CalenderScreen({Key? key, required this.cubit}) : super(key: key);
  final TavernDashboardCubit cubit;
  @override
  State<CalenderScreen> createState() => _CalenderScreenState();
}

class _CalenderScreenState extends State<CalenderScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: appTheme.gray5001,
      child: Column(
        children: [
          Container(
            height: 65.v,
            width: double.infinity,
            color: appTheme.white,
            child: Center(
              child: Text(
                'Calender',
                style: CustomTextStyles.titlelarge,
              ),
            ),
          ),
          SizedBox(height: 12.v),
          Expanded(
            child: Container(
              width: double.infinity,
              color: appTheme.white,
              child: StreamBuilder<either.Either<GeneralError, List<EventModel>>>(
                  stream: widget.cubit.events.getEvents(getUser: false, limit: 1000, userId: widget.cubit.auth.currentUser().uid),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      List<EventModel> data = [];
                      snapshot.data?.fold((l) => null, (r) => data = r);

                      return BlocBuilder<TavernDashboardCubit, TavernDashboardState>(
                        bloc: widget.cubit,
                        builder: (context, state) {
                          List<EventModel?> events = data.map((e) {
                            if (e.eventDatetime.year == state.focusedDay.year && e.eventDatetime.month == state.focusedDay.month && e.eventDatetime.day == state.focusedDay.day) {
                              return e;
                            }
                          }).toList();

                          return Column(
                            children: [
                              TableCalendar(
                                calendarStyle: CalendarStyle(
                                  todayDecoration: BoxDecoration(
                                    color: theme.colorScheme.primary.withOpacity(0.5),
                                    shape: BoxShape.circle,
                                  ),
                                  selectedDecoration: BoxDecoration(
                                    color: theme.colorScheme.primary,
                                    shape: BoxShape.circle,
                                  ),
                                ),
                                daysOfWeekVisible: false,
                                availableCalendarFormats: {CalendarFormat.month: 'Month'},
                                calendarFormat: CalendarFormat.month,
                                firstDay: DateTime.utc(2010, 10, 16),
                                lastDay: DateTime.utc(2030, 3, 14),
                                focusedDay: state.focusedDay,
                                selectedDayPredicate: (day) {
                                  return isSameDay(state.selectedDay, day);
                                },
                                onDaySelected: (selectedDay, focusedDay) {
                                  widget.cubit.updateDates(selectedDay, focusedDay);
                                },
                                eventLoader: (day) {
                                  List<DateTime> specificDates = data.map((e) {
                                    return DateTime(
                                      e.eventDatetime.year,
                                      e.eventDatetime.month,
                                      e.eventDatetime.day,
                                    );
                                  }).toList();

                                  if (specificDates.contains(DateTime(day.year, day.month, day.day))) {
                                    List dates = specificDates.where((element) {
                                      if (element.day == day.day && element.month == day.month && element.year == day.year) {
                                        return true;
                                      } else {
                                        return false;
                                      }
                                    }).toList();
                                    return dates;
                                  } else {
                                    return [];
                                  }
                                },
                              ),
                              Align(
                                alignment: Alignment.topLeft,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                                  child: Text(
                                    'Events',
                                    style: CustomTextStyles.titleMedium16,
                                  ),
                                ),
                              ),
                              events.isNotEmpty
                                  ? Expanded(
                                      child: ListView.separated(
                                        separatorBuilder: (
                                          context,
                                          index,
                                        ) =>
                                            SizedBox(
                                          width: 16.h,
                                        ),
                                        itemCount: events.length,
                                        itemBuilder: (context, index) {
                                          if (events[index] != null) {
                                            return CalenderItem(
                                              event: events[index]!,
                                            );
                                          } else {
                                            // Handle the case where event is null, e.g., return a placeholder widget or an empty container.
                                            return Container();
                                          }
                                        },
                                      ),
                                    )
                                  : Container()
                            ],
                          );
                        },
                      );
                    } else {
                      return Column(
                        children: [
                          SizedBox(height: MediaQuery.sizeOf(context).height * 0.4),
                          CustomLoadingWidget(),
                        ],
                      );
                    }
                  }),
            ),
          ),
        ],
      ),
    );
  }
}
