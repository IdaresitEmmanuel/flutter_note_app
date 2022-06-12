import 'package:flutter/material.dart';
import 'package:note_app/views/notes_page/notes_page_controller.dart';
import 'package:note_app/data/models/note.dart';
import 'package:note_app/theme/dimensions.dart';
import 'package:note_app/views/notes_page/widgets/delete_dialog.dart';

class ActionBar extends StatelessWidget {
  const ActionBar(
      {Key? key, required this.selectedList, required this.controller})
      : super(key: key);
  final List<Note> selectedList;
  final NotesPageController controller;
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.symmetric(
            horizontal: AppDimentions.pageMargin, vertical: 10.0),
        child: Row(children: [
          Expanded(
            child: Container(
                height: 40.0,
                alignment: Alignment.centerLeft,
                child: Text(
                  "${selectedList.length} Items Selected",
                  style: TextStyle(fontSize: AppDimentions.bodyTextMedium),
                )),
          ),
          const SizedBox(width: 10.0),
          SizedBox(
            width: 40.0,
            height: 40.0,
            child: ElevatedButton(
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (context) {
                      return DeleteDialog(controller: controller);
                    });
              },
              child: Image.asset("assets/images/delete.png", width: 24),
              style: ElevatedButton.styleFrom(
                shadowColor: Colors.transparent,
                primary: Colors.transparent,
                padding: const EdgeInsets.all(0),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6.0)),
                elevation: 0.0,
              ),
            ),
          )
        ]));
  }
}
