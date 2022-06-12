import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:note_app/theme/colors.dart';
import 'package:note_app/views/edit_note_page/edit_page_controller.dart';
import 'package:table_calendar/table_calendar.dart';

class ReminderCalender extends StatefulWidget {
  const ReminderCalender({Key? key, this.controller}) : super(key: key);

  final CalendarController? controller;

  @override
  State<ReminderCalender> createState() => _ReminderCalenderState();
}

class _ReminderCalenderState extends State<ReminderCalender> {
  late CalendarController calendarController;
  var editPageController = Get.find<EditPageController>();
  final _firstDay = Get.find<EditPageController>().note.value.date;
  final _lastDay = DateTime.now().add(const Duration(days: 3650));
  final _currentDay = DateTime.now();
  var _focusedDay = Get.find<EditPageController>().note.value.reminderDate;
  var _selectedDay = Get.find<EditPageController>().note.value.reminderDate;

  @override
  void initState() {
    calendarController = widget.controller ?? CalendarController();
    calendarController.setDay(_selectedDay);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
        data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
        child: ExpansionTile(
            textColor: Colors.black,
            iconColor: Colors.black,
            title: Text(DateFormat("EEE MMM d, yyyy").format(_selectedDay)),
            children: [
              Divider(color: AppColors.dividerColor),
              Transform.scale(
                scale: .9,
                child: SizedBox(
                  height: 400.0,
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
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF4F4F4F)),
                        dowTextFormatter: (dateTime, dynamic) {
                          return DateFormat("E")
                              .format(dateTime)
                              .substring(0, 1);
                        }),
                    calendarStyle: CalendarStyle(
                        selectedDecoration: BoxDecoration(
                            color: AppColors.primaryColor,
                            shape: BoxShape.circle)),
                    focusedDay: _focusedDay,
                    firstDay: _firstDay,
                    lastDay: _lastDay,
                    currentDay: _currentDay,
                    selectedDayPredicate: (day) {
                      return isSameDay(_selectedDay, day);
                    },
                    onDaySelected: ((selectedDay, focusedDay) {
                      setState(() {
                        _selectedDay = selectedDay;
                        _focusedDay = focusedDay;
                        calendarController.setDay(selectedDay);
                      });
                    }),
                  ),
                ),
              )
            ]));
  }
}

class CalendarController {
  DateTime _day = DateTime.now();

  setDay(DateTime day) {
    _day = day;
  }

  DateTime getDay() {
    return _day;
  }
}
