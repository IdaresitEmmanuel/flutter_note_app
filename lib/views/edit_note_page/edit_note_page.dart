import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:note_app/core/constants/enums.dart';
import 'package:note_app/views/edit_note_page/edit_page_controller.dart';
import 'package:note_app/core/helper_function.dart';
import 'package:note_app/data/repositories/note.dart';
import 'package:note_app/theme/colors.dart';
import 'package:note_app/theme/dimensions.dart';
import 'package:note_app/views/edit_note_page/widgets/options_bottom_sheet.dart';

class EditNotePage extends StatefulWidget {
  const EditNotePage({Key? key, this.note, required this.refresh})
      : super(key: key);
  final Note? note;
  final Function() refresh;
  @override
  State<EditNotePage> createState() => _EditNotePageState();
}

class _EditNotePageState extends State<EditNotePage> {
  final EditPageController controller = Get.find<EditPageController>();
  final titleController = TextEditingController();
  @override
  void initState() {
    if (widget.note != null) {
      controller.setNote(widget.note!);
    }
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
                      Obx(() {
                        return controller.editMode.value
                            ? InkResponse(
                                onTap: () async {
                                  FocusScope.of(context).unfocus();
                                  final result = await controller.saveNote();
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(content: Text(result)));
                                },
                                radius: 20.0,
                                child: Icon(Icons.check,
                                    color: AppColors.primaryColor),
                              )
                            : InkResponse(
                                onTap: () => Navigator.maybePop(context),
                                radius: 20.0,
                                child: Icon(Icons.chevron_left_rounded,
                                    color: AppColors.primaryColor),
                              );
                      }),
                      Row(
                        children: [
                          const SizedBox(width: 10.0),
                          Text("Note",
                              style: TextStyle(
                                  fontSize: AppDimentions.bodyTextMedium,
                                  fontWeight: FontWeight.w500)),
                        ],
                      ),
                      InkResponse(
                        radius: 20.0,
                        onTap: () {
                          showModalBottomSheet(
                              context: context,
                              builder: (context) {
                                return const OptionsBottomSheet();
                              });
                        },
                        child: Icon(Icons.more_vert_rounded,
                            color: AppColors.primaryColor),
                      )
                    ]),
              ),
              Container(
                height: 40.0,
                margin:
                    EdgeInsets.symmetric(horizontal: AppDimentions.pageMargin),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      controller.note.value.date.toString(),
                      style: const TextStyle(
                          fontSize: 12.0, color: Color(0xFF807E7E)),
                    ),
                    Obx(() {
                      return controller.note.value.tag != NoteTag.none
                          ? Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8.0, vertical: 4.0),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20.0),
                                  color: AppColors.cardColor),
                              child: Row(children: [
                                Icon(
                                  toIconData(controller.note.value.tag),
                                  size: 20,
                                ),
                                const SizedBox(width: 10.0),
                                Text(controller.note.value.tag.name)
                              ]),
                            )
                          : const SizedBox.shrink();
                    })
                  ],
                ),
              ),
              Expanded(
                  child: NoteForm(
                      note: controller.note.value, controller: controller))
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
