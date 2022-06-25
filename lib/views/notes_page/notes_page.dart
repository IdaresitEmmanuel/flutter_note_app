import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:note_app/views/notes_page/notes_page_controller.dart';
import 'package:note_app/theme/colors.dart';
import 'package:note_app/theme/dimensions.dart';
import 'package:note_app/views/edit_note_page/edit_note_page.dart';
import 'package:note_app/views/notes_page/widgets/action_bar.dart';
import 'package:note_app/views/notes_page/widgets/note_item.dart';
import 'package:note_app/views/notes_page/widgets/search_bar.dart';

class NotesPage extends StatefulWidget {
  const NotesPage({Key? key}) : super(key: key);

  @override
  State<NotesPage> createState() => _NotesPageState();
}

class _NotesPageState extends State<NotesPage> {
  final stateController = Get.find<NotesPageController>();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
          floatingActionButton: Obx(() => stateController.actionMode.value
              ? const SizedBox.shrink()
              : FloatingActionButton(
                  onPressed: () => Get.to(() => const EditNotePage(),
                      transition: Transition.zoom),
                  child: const Icon(Icons.add),
                )),
          body: SafeArea(
            child: Column(children: [
              Container(
                width: double.maxFinite,
                margin: EdgeInsets.symmetric(
                    horizontal: AppDimentions.pageMargin, vertical: 10.0),
                child: Row(
                  children: [
                    Obx(() => stateController.actionMode.value
                        ? InkResponse(
                            onTap: () => stateController.toggleActionMode(),
                            radius: 20.0,
                            child: Icon(
                              Icons.chevron_left_rounded,
                              color: AppColors.primaryColor,
                            ))
                        : const SizedBox.shrink()),
                    Obx(() => stateController.actionMode.value
                        ? const SizedBox(width: 10.0)
                        : const SizedBox.shrink()),
                    Text(
                      "My Notes",
                      style: TextStyle(fontSize: AppDimentions.bodyTextLarge),
                    ),
                  ],
                ),
              ),
              Obx(() => stateController.actionMode.value
                  ? Obx(() {
                      return ActionBar(
                        selectedList: stateController.filteredNoteList
                            .where((p0) => p0.isSelected.value)
                            .toList(),
                      );
                    })
                  : const SearchBar()),
              Expanded(
                child: Obx(() {
                  return stateController.noteList.isEmpty
                      ? Container(
                          padding: const EdgeInsets.all(20.0),
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(
                                    "assets/images/history_is_empty.png",
                                    height: 160),
                                const SizedBox(height: 20.0),
                                const Text(
                                  "No Notes available, click the plus button to add a new note",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(fontSize: 16.0),
                                ),
                              ]),
                        )
                      : ListView.builder(
                          padding: EdgeInsets.symmetric(
                              horizontal: AppDimentions.pageMargin),
                          shrinkWrap: true,
                          itemCount: stateController.filteredNoteList.length,
                          itemBuilder: (context, index) {
                            return Obx(() {
                              final note =
                                  stateController.filteredNoteList[index];
                              return NoteItem(
                                note: note,
                                isActionMode: stateController.actionMode.value,
                                stateController: stateController,
                                onPress: () {
                                  if (stateController.actionMode.value) {
                                    note.isSelected.value =
                                        !note.isSelected.value;
                                  } else {
                                    Get.to(() => EditNotePage(note: note),
                                        transition: Transition.zoom);
                                  }
                                },
                                onLongPress: () {
                                  note.isSelected.value = true;
                                  stateController.toggleActionMode();
                                },
                              );
                            });
                          });
                }),
              )
            ]),
          )),
    );
  }
}
