import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:note_app/controllers/edit_page_controller.dart';
import 'package:note_app/repositories/note.dart';
import 'package:note_app/theme/colors.dart';
import 'package:note_app/theme/dimensions.dart';

class EditNotePage extends StatefulWidget {
  const EditNotePage({Key? key, this.note, required this.refresh})
      : super(key: key);
  final Note? note;
  final Function() refresh;
  @override
  State<EditNotePage> createState() => _EditNotePageState();
}

class _EditNotePageState extends State<EditNotePage> {
  late final controller = EditPageController(widget.note);
  final titleController = TextEditingController();
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        widget.refresh();
        return true;
      },
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
          body: SafeArea(
              child: Column(
            children: [
              Container(
                height: 60.0,
                padding: EdgeInsets.symmetric(
                    horizontal: AppDimentions.pageMargin, vertical: 20.0),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          InkResponse(
                            onTap: () => Navigator.maybePop(context),
                            radius: 20.0,
                            child: Icon(Icons.chevron_left_rounded,
                                color: AppColors.primaryColor),
                          ),
                          const SizedBox(width: 10.0),
                          Text("Note",
                              style: TextStyle(
                                  fontSize: AppDimentions.bodyTextMedium,
                                  fontWeight: FontWeight.w500)),
                        ],
                      ),
                      Obx(() {
                        return controller.editMode.value
                            ? InkResponse(
                                onTap: () {
                                  FocusScope.of(context).unfocus();
                                  controller.saveNote();
                                },
                                radius: 20.0,
                                child: Icon(Icons.check,
                                    color: AppColors.primaryColor),
                              )
                            : PopupMenuButton(
                                onSelected: (value) =>
                                    Navigator.maybePop(context),
                                padding: const EdgeInsets.all(0),
                                icon: Icon(Icons.more_vert_rounded,
                                    color: AppColors.primaryColor),
                                itemBuilder: (c) {
                                  return [
                                    PopupMenuItem(
                                        onTap: () {
                                          controller.deleteNote();
                                          widget.refresh();
                                          Navigator.pop(context);
                                        },
                                        height: 20,
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 10.0),
                                        child: const Text('Delete'))
                                  ];
                                });
                      }),
                    ]),
              ),
              Container(
                  padding: EdgeInsets.symmetric(
                      horizontal: AppDimentions.pageMargin),
                  width: double.maxFinite,
                  child: const Text(
                    "Jan 20th 2020 03:04 PM",
                    style: TextStyle(fontSize: 12.0, color: Color(0xFF807E7E)),
                  )),
              Expanded(
                  child:
                      NoteForm(note: controller.note!, controller: controller))
            ],
          )),
        ),
      ),
    );
  }
}

class NoteForm extends StatelessWidget {
  const NoteForm({Key? key, required this.note, required this.controller})
      : super(key: key);
  final Note note;
  final EditPageController controller;
  @override
  Widget build(BuildContext context) {
    return Form(
        child: Column(
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: AppDimentions.pageMargin),
          child: TextFormField(
            onTap: () => controller.editMode.value = true,
            // focusNode: ,
            onChanged: (value) => controller.editTitle(value),
            initialValue: note.title,
            style: const TextStyle(fontSize: 20.0, fontWeight: FontWeight.w500),
            decoration: const InputDecoration(
                hintStyle:
                    TextStyle(fontSize: 20.0, fontWeight: FontWeight.w500),
                hintText: "Title",
                border: InputBorder.none),
          ),
        ),
        Expanded(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: AppDimentions.pageMargin),
            child: TextFormField(
              onTap: () => controller.editMode.value = true,
              onChanged: (value) => controller.editNote(value),
              initialValue: note.note,
              maxLines: 1000,
              style: TextStyle(fontSize: AppDimentions.bodyTextMedium),
              decoration: InputDecoration(
                  hintStyle: TextStyle(fontSize: AppDimentions.bodyTextMedium),
                  hintText: "Write something here!",
                  border: InputBorder.none),
            ),
          ),
        ),
      ],
    ));
  }
}
