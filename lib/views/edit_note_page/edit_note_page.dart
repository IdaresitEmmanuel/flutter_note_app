import 'package:flutter/material.dart';
import 'package:note_app/theme/colors.dart';
import 'package:note_app/theme/dimensions.dart';

class EditNotePage extends StatefulWidget {
  const EditNotePage({Key? key}) : super(key: key);

  @override
  State<EditNotePage> createState() => _EditNotePageState();
}

class _EditNotePageState extends State<EditNotePage> {
  bool shouldEdit = true;
  toggleEdit() {
    setState(() {
      shouldEdit = !shouldEdit;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(
                horizontal: AppDimentions.pageMargin, vertical: 20.0),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      InkResponse(
                        onTap: () => Navigator.pop(context),
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
                  shouldEdit
                      ? InkResponse(
                          onTap: () => toggleEdit(),
                          radius: 20.0,
                          child:
                              Icon(Icons.check, color: AppColors.primaryColor),
                        )
                      : PopupMenuButton(
                          padding: const EdgeInsets.all(0),
                          icon: Icon(Icons.more_vert_rounded,
                              color: AppColors.primaryColor),
                          itemBuilder: (context) {
                            return [
                              const PopupMenuItem(
                                  height: 20,
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 10.0),
                                  child: Text('Delete'))
                            ];
                          }),
                ]),
          ),
          Container(
              padding:
                  EdgeInsets.symmetric(horizontal: AppDimentions.pageMargin),
              width: double.maxFinite,
              child: const Text(
                "Jan 20th 2020 03:04 PM",
                style: TextStyle(fontSize: 12.0, color: Color(0xFF807E7E)),
              )),
          Expanded(
            child: Form(
                child: Column(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(
                      horizontal: AppDimentions.pageMargin),
                  child: TextFormField(
                    style: const TextStyle(
                        fontSize: 20.0, fontWeight: FontWeight.w500),
                    decoration: const InputDecoration(
                        hintStyle: TextStyle(
                            fontSize: 20.0, fontWeight: FontWeight.w500),
                        hintText: "Title",
                        border: InputBorder.none),
                  ),
                ),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.symmetric(
                        horizontal: AppDimentions.pageMargin),
                    child: TextFormField(
                      maxLines: 1000,
                      style: TextStyle(fontSize: AppDimentions.bodyTextMedium),
                      decoration: InputDecoration(
                          hintStyle:
                              TextStyle(fontSize: AppDimentions.bodyTextMedium),
                          hintText: "Write something here!",
                          border: InputBorder.none),
                    ),
                  ),
                ),
              ],
            )),
          )
        ],
      )),
    );
  }
}
