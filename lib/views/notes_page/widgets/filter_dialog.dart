import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:note_app/core/constants/enums.dart';
import 'package:note_app/data/local/app_preferences.dart';
import 'package:note_app/theme/colors.dart';
import 'package:note_app/views/notes_page/notes_page_controller.dart';

class FilterDialog extends StatefulWidget {
  const FilterDialog({Key? key}) : super(key: key);

  @override
  FilterDialogState createState() => FilterDialogState();
}

class FilterDialogState extends State<FilterDialog> {
  Filter groupValue = Filter.none;
  @override
  void initState() {
    _setCurrentFilter();
    super.initState();
  }

  _setCurrentFilter() {
    AppPrefrences.getFilter().then((value) {
      setState(() {
        groupValue = value;
      });
    });
  }

  _setNewFilter(Filter filter) async {
    if (groupValue != filter) {
      final result = await AppPrefrences.setFilter(filter);
      if (result) {
        setState(() {
          groupValue = filter;
          Get.find<NotesPageController>().refreshNotes();
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      title: const Text("Filter"),
      children: [
        RadioListTile(
            title:
                Text("None", style: TextStyle(color: AppColors.primaryColor)),
            value: Filter.none,
            groupValue: groupValue,
            onChanged: (Filter? value) {
              _setNewFilter(value!);
            }),
        RadioListTile(
            title: const Text("Alphabetically"),
            value: Filter.alphabet,
            groupValue: groupValue,
            onChanged: (Filter? value) {
              _setNewFilter(value!);
            }),
        RadioListTile(
            title: const Text("By Date"),
            value: Filter.date,
            groupValue: groupValue,
            onChanged: (Filter? value) {
              _setNewFilter(value!);
            }),
      ],
    );
  }
}
