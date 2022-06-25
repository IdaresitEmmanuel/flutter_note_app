import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:note_app/views/notes_page/notes_page_controller.dart';
import 'package:note_app/theme/dimensions.dart';

class DeleteDialog extends StatelessWidget {
  const DeleteDialog({Key? key}) : super(key: key);

  int getSelectedItems() {
    var notes = Get.find<NotesPageController>().filteredNoteList;
    return notes.where((p0) => p0.isSelected.value).length;
  }

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      title: Text(
        "Are you sure you want to delete ${getSelectedItems()} items?",
        style: TextStyle(fontSize: AppDimentions.bodyTextMedium),
      ),
      children: [
        Container(
          margin: const EdgeInsets.only(right: 10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                  onPressed: () =>
                      Navigator.of(context, rootNavigator: true).pop(),
                  child: const Text("Cancel")),
              TextButton(
                  onPressed: () {
                    Get.find<NotesPageController>().deleteNotes();
                    Navigator.of(context, rootNavigator: true).pop();
                  },
                  child: const Text("Confirm"))
            ],
          ),
        )
      ],
    );
  }
}
