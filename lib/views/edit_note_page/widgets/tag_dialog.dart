import "package:flutter/material.dart";
import 'package:get/get.dart';
import 'package:note_app/constants/enums.dart';
import 'package:note_app/controllers/edit_page_controller.dart';

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
          padding: const EdgeInsets.symmetric(vertical: 10.0),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0), color: Colors.white),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text("Tag", style: TextStyle(fontSize: 16.0)),
              ListTile(
                onTap: () {
                  controller.note.value =
                      controller.note.value.copyWith(tag: NoteTag.none);
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
                  controller.note.value =
                      controller.note.value.copyWith(tag: NoteTag.home);
                },
                leading: const Icon(Icons.home_rounded),
                title: const Text("Home"),
                trailing: controller.note.value.tag == NoteTag.home
                    ? const AppCheckBox()
                    : null,
              ),
              ListTile(
                onTap: () {
                  controller.note.value =
                      controller.note.value.copyWith(tag: NoteTag.work);
                },
                leading: const Icon(Icons.work_rounded),
                title: const Text("Work"),
                trailing: controller.note.value.tag == NoteTag.work
                    ? const AppCheckBox()
                    : null,
              ),
              ListTile(
                onTap: () {
                  controller.note.value =
                      controller.note.value.copyWith(tag: NoteTag.school);
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