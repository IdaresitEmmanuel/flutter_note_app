import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

class ReminderCalender extends StatefulWidget {
  const ReminderCalender({Key? key}) : super(key: key);

  @override
  State<ReminderCalender> createState() => _ReminderCalenderState();
}

class _ReminderCalenderState extends State<ReminderCalender> {
  @override
  Widget build(BuildContext context) {
    return Transform.scale(
      scale: .8,
      child: TableCalendar(
          headerStyle: HeaderStyle(
              formatButtonVisible: false,
              titleCentered: true,
              titleTextFormatter: (dateTime, dynamic) {
                return DateFormat("MMMM").format(dateTime);
              }),
          daysOfWeekStyle: DaysOfWeekStyle(
              weekdayStyle: const TextStyle(
                color: Color(0xFF4F4F4F),
                fontWeight: FontWeight.bold,
              ),
              weekendStyle: const TextStyle(
                  fontWeight: FontWeight.bold, color: Color(0xFF4F4F4F)),
              dowTextFormatter: (dateTime, dynamic) {
                return DateFormat("E").format(dateTime).substring(0, 1);
              }),
          focusedDay: DateTime.now(),
          firstDay: DateTime.now(),
          lastDay: DateTime.utc(2030)),
    );
  }
}
