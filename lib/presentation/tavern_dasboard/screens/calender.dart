import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:taverns/core/app_export.dart';
import 'package:taverns/domain/model/event_model.dart';
import 'package:taverns/domain/model/general_model.dart';
import 'package:fpdart/fpdart.dart' as either;

import '../tavern_dashboard_cubit.dart';
import '../tavern_dashboard_state.dart';

class CalenderScreen extends StatefulWidget {
  const CalenderScreen({Key? key, required this.cubit, required this.state}) : super(key: key);
  final TavernDashboardCubit cubit;
  final TavernDashboardState state;
  @override
  State<CalenderScreen> createState() => _CalenderScreenState();
}

class _CalenderScreenState extends State<CalenderScreen> {
  DateTime _focusedDay = DateTime.now();
  DateTime _selectedDay = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: appTheme.gray5001,
      child: Column(
        children: [
          Container(
            height: 50.v,
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
          Container(
            width: double.infinity,
            color: appTheme.white,
            child: Column(
              children: [
                StreamBuilder<either.Either<GeneralError, List<EventModel>>>(
                    stream: widget.cubit.events.getEvents(getUser: true, limit: 1000, userId: widget.cubit.auth.currentUser().uid),
                    builder: (context, snapshot) {
                      return TableCalendar(
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
                        focusedDay: _focusedDay,
                        selectedDayPredicate: (day) {
                          return isSameDay(_selectedDay, day);
                        },
                        onDaySelected: (selectedDay, focusedDay) {
                          setState(() {
                            _selectedDay = selectedDay;
                            _focusedDay = focusedDay; // update `_focusedDay` here as well
                          });
                        },
                        eventLoader: (day) {
                          List<DateTime> specificDates = [
                            DateTime(2024, 1, 3),
                            DateTime(2024, 1, 8),
                            DateTime(2024, 1, 3),
                            DateTime(2024, 1, 10),
                            DateTime(2024, 2, 10),
                          ];

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
                      );
                    }),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
