import 'package:flutter/material.dart';
import 'package:note_app/theme/colors.dart';

class FilterDialog extends StatelessWidget {
  const FilterDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      title: const Text("Filter"),
      children: [
        RadioListTile(
            title:
                Text("None", style: TextStyle(color: AppColors.primaryColor)),
            value: 1,
            groupValue: 1,
            onChanged: (value) {}),
        RadioListTile(
            title: const Text("Alphabetically"),
            value: 2,
            groupValue: 1,
            onChanged: (value) {}),
        RadioListTile(
            title: const Text("By Date"),
            value: 3,
            groupValue: 1,
            onChanged: (value) {}),
      ],
    );
  }
}
