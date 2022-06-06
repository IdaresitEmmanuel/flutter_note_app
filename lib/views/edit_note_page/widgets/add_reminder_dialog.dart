import "package:flutter/material.dart";
import 'package:intl/intl.dart';
import 'package:note_app/theme/colors.dart';
import 'package:note_app/views/edit_note_page/widgets/calender_widget.dart';
import 'package:note_app/views/edit_note_page/widgets/time_widget.dart';

class AddReminderDialog extends StatefulWidget {
  const AddReminderDialog({Key? key}) : super(key: key);

  @override
  State<AddReminderDialog> createState() => _AddReminderDialogState();
}

class _AddReminderDialogState extends State<AddReminderDialog> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
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
            child: Column(mainAxisSize: MainAxisSize.min, children: [
              const Text("Set reminder", style: TextStyle(fontSize: 24.0)),
              const ReminderTime(),
              Theme(
                data: Theme.of(context)
                    .copyWith(dividerColor: Colors.transparent),
                child: ExpansionTile(
                  textColor: Colors.black,
                  iconColor: Colors.black,
                  title: Text(
                      DateFormat("EEE MMM d, yyyy").format(DateTime.now())),
                  children: const [ReminderCalender()],
                ),
              ),
              ElevatedButton(
                onPressed: () {},
                child: const Text("Set reminder"),
                style: ElevatedButton.styleFrom(
                    primary: AppColors.primaryColor,
                    fixedSize: const Size(double.maxFinite, 40.0)),
              )
            ]),
          ),
        ),
      ),
    );
  }
}
