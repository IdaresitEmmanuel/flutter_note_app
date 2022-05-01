import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:note_app/controllers/notes_page_controller.dart';
import 'package:note_app/repositories/note.dart';
import 'package:note_app/theme/colors.dart';
import 'package:note_app/views/edit_note_page/edit_note_page.dart';
import 'package:note_app/views/notes_page/widgets/note_check_box.dart';

class NoteItem extends StatefulWidget {
  const NoteItem(
      {Key? key,
      required this.note,
      required this.isActionMode,
      required this.stateController})
      : super(key: key);
  final Note note;
  final bool isActionMode;
  final NotesPageController stateController;
  @override
  State<NoteItem> createState() => _NoteItemState();
}

class _NoteItemState extends State<NoteItem> {
  @override
  Widget build(BuildContext context) {
    var controller = widget.stateController;
    var note = widget.note;
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5.0),
      child: InkWell(
        onTap: () {
          if (controller.actionMode.value) {
            note.isSelected.value = !note.isSelected.value;
          } else {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (_) => EditNotePage(
                          note: note,
                          refresh: controller.refreshNotes,
                        )));
          }
        },
        onLongPress: () {
          if (!controller.actionMode.value) {
            widget.note.isSelected.value = true;
            controller.toggleActionMode();
          }
        },
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            widget.isActionMode
                ? Obx(
                    () => NoteCheckBox(isChecked: widget.note.isSelected.value))
                : const SizedBox.shrink(),
            Expanded(
              child: Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: 10.0, vertical: 10.0),
                decoration: BoxDecoration(
                    border: Border.all(color: AppColors.dividerColor),
                    borderRadius: BorderRadius.circular(6.0)),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.note.title,
                        style: const TextStyle(
                            fontSize: 20.0, color: Color(0xFF2D2D2D)),
                      ),
                      const SizedBox(height: 6.0),
                      Text(
                        widget.note.date.toString(),
                        style: const TextStyle(
                            fontSize: 10.0, color: Color(0xFF807E7E)),
                      ),
                      const SizedBox(height: 10.0),
                      Text(
                        widget.note.note,
                        style: const TextStyle(
                            fontSize: 14.0, color: Color(0xFF464646)),
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                      )
                    ]),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
