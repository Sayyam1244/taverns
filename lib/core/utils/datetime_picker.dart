import 'package:flutter/material.dart';

class DatetimePicker {
  Future<DateTime> selectDate(BuildContext context, DateTime dateTime) async {
    final DateTime? pickedDateTime = await showDatePicker(
      context: context,
      initialDate: dateTime,
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
    );
    if (pickedDateTime != null) {
      return pickedDateTime;
    } else {
      return dateTime;
    }
  }

  Future<TimeOfDay> selectTime(BuildContext context, DateTime dateTime) async {
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.fromDateTime(dateTime),
    );
    if (pickedTime != null) {
      return pickedTime;
    } else {
      return TimeOfDay.fromDateTime(dateTime);
    }
  }
}
