import "package:flutter/material.dart";
import 'package:get/get.dart';
import 'package:note_app/core/constants/enums.dart';
import 'package:note_app/views/edit_note_page/edit_page_controller.dart';

import 'check_box.dart';

class TagDialog extends StatefulWidget {
  const TagDialog({Key? key}) : super(key: key);

  @override
  State<TagDialog> createState() => _TagDialogState();
}

class _TagDialogState extends State<TagDialog> {
  var controller = Get.find<EditPageController>();
  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: Obx(() {
        return Container(
          constraints: const BoxConstraints(maxWidth: 500.0),
          padding: const EdgeInsets.symmetric(vertical: 10.0),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0), color: Colors.white),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text("Tag", style: TextStyle(fontSize: 16.0)),
              ListTile(
                onTap: () {
                  controller.editTag(NoteTag.none);
                },
                leading: const Icon(
                  Icons.block_rounded,
                ),
                title: const Text("None"),
                trailing: controller.note.value.tag == NoteTag.none
                    ? const AppCheckBox()
                    : null,
              ),
              ListTile(
                onTap: () {
                  controller.editTag(NoteTag.home);
                },
                leading: const Icon(Icons.home_rounded),
                title: const Text("Home"),
                trailing: controller.note.value.tag == NoteTag.home
                    ? const AppCheckBox()
                    : null,
              ),
              ListTile(
                onTap: () {
                  controller.editTag(NoteTag.work);
                },
                leading: const Icon(Icons.work_rounded),
                title: const Text("Work"),
                trailing: controller.note.value.tag == NoteTag.work
                    ? const AppCheckBox()
                    : null,
              ),
              ListTile(
                onTap: () {
                  controller.editTag(NoteTag.school);
                },
                leading: const Icon(Icons.school_rounded),
                title: const Text("School"),
                trailing: controller.note.value.tag == NoteTag.school
                    ? const AppCheckBox()
                    : null,
              ),
            ],
          ),
        );
      }),
    );
  }
}
