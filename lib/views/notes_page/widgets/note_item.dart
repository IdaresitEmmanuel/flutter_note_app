import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:note_app/core/constants/enums.dart';
import 'package:note_app/views/notes_page/notes_page_controller.dart';
import 'package:note_app/core/helper_function.dart';
import 'package:note_app/data/repositories/note.dart';
import 'package:note_app/views/notes_page/widgets/note_check_box.dart';

import 'note_tag.dart';

class NoteItem extends StatefulWidget {
  const NoteItem(
      {Key? key,
      required this.note,
      required this.isActionMode,
      required this.stateController,
      required this.onPress,
      required this.onLongPress})
      : super(key: key);
  final Note note;
  final bool isActionMode;
  final NotesPageController stateController;
  final void Function() onPress;
  final void Function() onLongPress;
  @override
  State<NoteItem> createState() => _NoteItemState();
}

class _NoteItemState extends State<NoteItem> {
  @override
  Widget build(BuildContext context) {
    var note = widget.note;
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5.0),
      child: InkWell(
        onTap: widget.onPress,
        onLongPress: widget.onLongPress,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            widget.isActionMode
                ? Obx(
                    () => NoteCheckBox(isChecked: widget.note.isSelected.value))
                : const SizedBox.shrink(),
            Expanded(
              child: Stack(
                children: [
                  Container(
                    width: double.maxFinite,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10.0, vertical: 10.0),
                    decoration: BoxDecoration(
                        color: toColor(note.color),
                        borderRadius: BorderRadius.circular(6.0)),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.note.title,
                            style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20.0,
                                color: Color(0xFF2D2D2D)),
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
                  note.tag == NoteTag.none
                      ? const SizedBox.shrink()
                      : Padding(
                          padding: const EdgeInsets.only(right: 20.0),
                          child: Align(
                            alignment: Alignment.topRight,
                            child: NoteTagWidget(
                              size: const Size(20, 40),
                              child: Icon(
                                toIconData(note.tag),
                                color: Colors.white,
                                size: 16,
                              ),
                            ),
                          ),
                        ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
