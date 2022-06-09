import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:note_app/views/edit_note_page/edit_page_controller.dart';
import 'package:note_app/views/edit_note_page/widgets/time_controller.dart';

import '../../../theme/colors.dart';

class ReminderTime extends StatefulWidget {
  const ReminderTime({Key? key, this.timeController}) : super(key: key);
  final TimeController? timeController;
  @override
  State<ReminderTime> createState() => _ReminderTimeState();
}

class _ReminderTimeState extends State<ReminderTime> {
  DateTime currentReminderDate =
      Get.find<EditPageController>().note.value.reminderDate;
  late TimeController timeController;
  var inputMask =
      MaskTextInputFormatter(mask: '##', filter: {"#": RegExp(r'[0-9]')});

  @override
  void initState() {
    timeController = widget.timeController ?? TimeController();
    timeController.computeHours(currentReminderDate.hour);
    timeController.setMinutes(currentReminderDate.minute.toString());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 50,
                width: 50,
                decoration: BoxDecoration(
                    border: Border.all(color: AppColors.dividerColor),
                    borderRadius: BorderRadius.circular(6)),
                child: Center(
                  child: TextFormField(
                    inputFormatters: [inputMask],
                    enabled: true,
                    initialValue: timeController.hours,
                    keyboardType: TextInputType.number,
                    textAlign: TextAlign.center,
                    maxLines: 1,
                    maxLength: 2,
                    maxLengthEnforcement: MaxLengthEnforcement.enforced,
                    decoration: const InputDecoration(
                      counter: SizedBox.shrink(),
                      border: InputBorder.none,
                    ),
                    style: const TextStyle(fontSize: 24.0),
                    onChanged: (value) {
                      timeController.setHours(value);
                    },
                  ),
                ),
              ),
              const SizedBox(width: 10.0),
              const TimeDivider(),
              const SizedBox(width: 10.0),
              Container(
                height: 50,
                width: 50,
                decoration: BoxDecoration(
                    border: Border.all(color: AppColors.dividerColor),
                    borderRadius: BorderRadius.circular(6)),
                child: Center(
                  child: TextFormField(
                    inputFormatters: [inputMask],
                    enabled: true,
                    initialValue: timeController.minute,
                    keyboardType: TextInputType.number,
                    textAlign: TextAlign.center,
                    maxLines: 1,
                    maxLength: 2,
                    maxLengthEnforcement: MaxLengthEnforcement.enforced,
                    decoration: const InputDecoration(
                      counter: SizedBox.shrink(),
                      border: InputBorder.none,
                    ),
                    onChanged: (value) {
                      timeController.setMinutes(value);
                    },
                    validator: (value) {
                      if (value!.isEmpty) return "";
                      if (int.parse(value) > 59) return "";
                      return null;
                    },
                    style: const TextStyle(fontSize: 24.0),
                  ),
                ),
              ),
              const SizedBox(width: 20.0),
              Meridiem(
                initialIsPM: timeController.isPM,
                onChange: (isPM) {
                  timeController.isPM = isPM;
                },
              ),
            ],
          ),
          Obx(() {
            return timeController.shouldValidate.value &&
                    timeController.errorString.value.isNotEmpty
                ? Text(timeController.errorString.value,
                    style: const TextStyle(color: Colors.red))
                : const SizedBox.shrink();
          })
        ],
      ),
    );
  }
}

class TimeDivider extends StatelessWidget {
  const TimeDivider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          height: 8.0,
          width: 8.0,
          decoration: BoxDecoration(
              color: AppColors.primaryColor,
              borderRadius: BorderRadius.circular(4)),
        ),
        const SizedBox(height: 5.0),
        Container(
          height: 8.0,
          width: 8.0,
          decoration: BoxDecoration(
              color: AppColors.primaryColor,
              borderRadius: BorderRadius.circular(4)),
        )
      ],
    );
  }
}

// ignore: must_be_immutable
class Meridiem extends StatefulWidget {
  const Meridiem({Key? key, this.initialIsPM = false, this.onChange})
      : super(key: key);
  final bool initialIsPM;
  final Function(bool isPM)? onChange;

  @override
  MeridiemState createState() => MeridiemState();
}

class MeridiemState extends State<Meridiem> {
  bool isPM = false;
  @override
  void initState() {
    isPM = widget.initialIsPM;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: () {
            setState(() {
              isPM = false;
              widget.onChange!(false);
            });
          },
          child: Container(
            height: 25,
            width: 50,
            decoration: BoxDecoration(
              color: !isPM ? AppColors.primaryColor : null,
              border: Border.all(
                  color:
                      !isPM ? AppColors.primaryColor : AppColors.dividerColor),
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(6), topRight: Radius.circular(6)),
            ),
            child: Center(
              child: Text(
                "AM",
                style: TextStyle(color: !isPM ? Colors.white : null),
              ),
            ),
          ),
        ),
        GestureDetector(
          onTap: () {
            setState(() {
              isPM = true;
              widget.onChange!(true);
            });
          },
          child: Container(
            height: 25,
            width: 50,
            decoration: BoxDecoration(
              color: isPM ? AppColors.primaryColor : null,
              border: Border.all(
                  color:
                      isPM ? AppColors.primaryColor : AppColors.dividerColor),
              borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(6),
                  bottomRight: Radius.circular(6)),
            ),
            child: Center(
              child: Text(
                "PM",
                style: TextStyle(color: isPM ? Colors.white : null),
              ),
            ),
          ),
        )
      ],
    );
  }
}
