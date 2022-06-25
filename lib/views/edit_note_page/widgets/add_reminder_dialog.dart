import 'package:awesome_notifications/awesome_notifications.dart';
import "package:flutter/material.dart";
import 'package:get/get.dart';
import 'package:note_app/core/date_time_extensions.dart';
import 'package:note_app/theme/colors.dart';
import 'package:note_app/views/edit_note_page/edit_page_controller.dart';
import 'package:note_app/views/edit_note_page/widgets/calender_widget.dart';
import 'package:note_app/views/edit_note_page/widgets/time_controller.dart';
import 'package:note_app/views/edit_note_page/widgets/time_widget.dart';

class AddReminderDialog extends StatefulWidget {
  const AddReminderDialog({Key? key}) : super(key: key);

  @override
  State<AddReminderDialog> createState() => _AddReminderDialogState();
}

class _AddReminderDialogState extends State<AddReminderDialog> {
  var selectedTime = DateTime.now();
  var timeController = TimeController();
  var dayController = CalendarController();
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      elevation: 0.0,
      backgroundColor: Colors.transparent,
      insetPadding:
          const EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
      child: SingleChildScrollView(
        child: Center(
          child: Container(
            constraints: const BoxConstraints(maxWidth: 500.0),
            padding:
                const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(10.0)),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text("Set reminder", style: TextStyle(fontSize: 24.0)),
                ReminderTime(timeController: timeController),
                ReminderCalender(controller: dayController),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () =>
                          Navigator.of(context, rootNavigator: true).pop(),
                      child: Text(
                        "Cancel",
                        style: TextStyle(color: AppColors.primaryColor),
                      ),
                    ),
                    const SizedBox(width: 10.0),
                    TextButton(
                      onPressed: () async {
                        if (timeController.isValidated()) {
                          bool isAllowed = await AwesomeNotifications()
                              .isNotificationAllowed();
                          if (!isAllowed) {
                            bool hasPermission = await AwesomeNotifications()
                                .requestPermissionToSendNotifications();
                            if (!hasPermission) return;
                          }

                          var reminderDate = DateTime.now().copyWith(
                            year: dayController.getDay().year,
                            month: dayController.getDay().month,
                            day: dayController.getDay().day,
                            hour: timeController.getTime().hour,
                            minute: timeController.getTime().minute,
                            second: 0,
                            millisecond: 0,
                          );
                          Get.find<EditPageController>()
                              .setReminderDate(reminderDate);
                          Navigator.of(context, rootNavigator: true).pop();
                        }
                      },
                      child: Text(
                        "Add",
                        style: TextStyle(color: AppColors.primaryColor),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
