import "package:flutter/material.dart";
import 'package:get/get.dart';
import 'package:note_app/core/constants/enums.dart';
import 'package:note_app/core/helper_function.dart';
import 'package:note_app/views/edit_note_page/edit_page_controller.dart';
import 'package:note_app/theme/colors.dart';
import 'package:note_app/views/edit_note_page/widgets/add_reminder_dialog.dart';
import 'package:note_app/views/edit_note_page/widgets/tag_dialog.dart';

class OptionsBottomSheet extends StatefulWidget {
  const OptionsBottomSheet({Key? key}) : super(key: key);

  @override
  State<OptionsBottomSheet> createState() => _OptionsBottomSheetState();
}

class _OptionsBottomSheetState extends State<OptionsBottomSheet> {
  var controller = Get.find<EditPageController>();
  List<Widget> getColorWidgetList() {
    return AppColors.noteColorList
        .map((e) => GestureDetector(
              onTap: () => controller.editColor(e),
              child: Obx(() {
                return Container(
                  margin: const EdgeInsets.symmetric(horizontal: 6.0),
                  width: 40.0,
                  height: 40.0,
                  decoration: BoxDecoration(
                      border: toColor(controller.note.value.color) == e
                          ? Border.all(width: 2, color: AppColors.primaryColor)
                          : null,
                      color: e,
                      borderRadius: BorderRadius.circular(20)),
                  child: toColor(controller.note.value.color) == e
                      ? Icon(Icons.check_rounded, color: AppColors.primaryColor)
                      : const SizedBox.shrink(),
                );
              }),
            ))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          constraints: const BoxConstraints(maxWidth: 500.0, minWidth: 300),
          decoration: const BoxDecoration(
              color: Color.fromRGBO(255, 255, 255, 1),
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20), topRight: Radius.circular(20))),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                margin: const EdgeInsets.only(top: 10.0, bottom: 20.0),
                height: 8.0,
                width: 60,
                decoration: BoxDecoration(
                    color: AppColors.dividerColor,
                    borderRadius: BorderRadius.circular(4.0)),
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: getColorWidgetList(),
                ),
              ),
              const SizedBox(height: 10.0),
              ListTile(
                onTap: () {
                  Navigator.of(context, rootNavigator: false).pop();
                  controller.deleteNote();
                  Navigator.pop(context);
                },
                leading: const Icon(
                  Icons.delete_rounded,
                ),
                title: const Text("delete note"),
              ),
              ListTile(
                onTap: () {},
                leading: const Icon(
                  Icons.copy_rounded,
                ),
                title: const Text("copy note"),
              ),
              ListTile(
                onTap: () {
                  Navigator.of(context, rootNavigator: true).pop();
                  showDialog(
                      context: context,
                      builder: (context) {
                        return const TagDialog();
                      });
                },
                leading: const Icon(
                  Icons.bookmark_rounded,
                ),
                title: const Text("add tag"),
              ),
              ListTile(
                onTap: () {
                  Navigator.of(context, rootNavigator: true).pop();
                  if (controller.note.value.reminderStatus ==
                      NoteReminder.none) {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return const AddReminderDialog();
                        });
                  } else {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return Dialog(
                            child: Container(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    ListTile(
                                      onTap: () => Navigator.of(context,
                                              rootNavigator: true)
                                          .pop(),
                                      leading: const Icon(
                                        Icons.close_rounded,
                                        color: Colors.red,
                                      ),
                                      title: const Text("Remove reminder"),
                                    ),
                                    ListTile(
                                      onTap: () {
                                        Navigator.of(context,
                                                rootNavigator: true)
                                            .pop();
                                        showDialog(
                                            context: context,
                                            builder: (context) {
                                              return const AddReminderDialog();
                                            });
                                      },
                                      leading: const Icon(
                                        Icons.edit_rounded,
                                        color: Colors.green,
                                      ),
                                      title: const Text("Modify reminder"),
                                    )
                                  ],
                                )),
                          );
                        });
                  }
                },
                leading: const Icon(Icons.alarm),
                title: const Text("add a reminder"),
              )
            ],
          ),
        ),
      ],
    );
  }
}
