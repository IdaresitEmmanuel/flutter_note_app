import 'package:flutter/material.dart';

import '../../../theme/colors.dart';

class ReminderTime extends StatefulWidget {
  const ReminderTime({Key? key}) : super(key: key);

  @override
  State<ReminderTime> createState() => _ReminderTimeState();
}

class _ReminderTimeState extends State<ReminderTime> {
  @override
  Widget build(BuildContext context) {
    return Transform.scale(
      scale: .8,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 50,
              width: 50,
              decoration: BoxDecoration(
                  border: Border.all(color: AppColors.dividerColor),
                  borderRadius: BorderRadius.circular(6)),
              child: const Center(
                child: Text("7", style: TextStyle(fontSize: 24.0)),
              ),
            ),
            const SizedBox(width: 10.0),
            Column(
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
            ),
            const SizedBox(width: 10.0),
            Container(
              height: 50,
              width: 50,
              decoration: BoxDecoration(
                  border: Border.all(color: AppColors.dividerColor),
                  borderRadius: BorderRadius.circular(6)),
              child: const Center(
                child: Text("15", style: TextStyle(fontSize: 24.0)),
              ),
            ),
            const SizedBox(width: 20.0),
            Column(
              children: [
                Container(
                  height: 25,
                  width: 50,
                  decoration: BoxDecoration(
                    color: AppColors.primaryColor,
                    // border: Border.all(),
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(6),
                        topRight: Radius.circular(6)),
                  ),
                  child: const Center(
                      child: Text("AM", style: TextStyle(color: Colors.white))),
                ),
                Container(
                  height: 25,
                  width: 50,
                  decoration: BoxDecoration(
                    border: Border.all(color: AppColors.dividerColor),
                    borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(6),
                        bottomRight: Radius.circular(6)),
                  ),
                  child: const Center(
                    child: Text(
                      "PM",
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
