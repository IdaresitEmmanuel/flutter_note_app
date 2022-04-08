import 'package:flutter/material.dart';
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
  bool actionMode = false;
  toggleActionMode() {
    setState(() {
      actionMode = !actionMode;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () => Navigator.push(
              context, MaterialPageRoute(builder: (_) => const EditNotePage())),
          child: const Icon(Icons.add),
        ),
        body: SafeArea(
          child: Column(children: [
            Container(
              width: double.maxFinite,
              margin: EdgeInsets.symmetric(
                  horizontal: AppDimentions.pageMargin, vertical: 10.0),
              child: Row(
                children: [
                  actionMode
                      ? InkResponse(
                          onTap: () {},
                          radius: 20.0,
                          child: Icon(
                            Icons.chevron_left_rounded,
                            color: AppColors.primaryColor,
                          ))
                      : const SizedBox.shrink(),
                  actionMode
                      ? const SizedBox(width: 10.0)
                      : const SizedBox.shrink(),
                  Text(
                    "My Notes",
                    style: TextStyle(fontSize: AppDimentions.bodyTextLarge),
                  ),
                ],
              ),
            ),
            actionMode ? const ActionBar() : const SearchBar(),
            ListView.builder(
                padding:
                    EdgeInsets.symmetric(horizontal: AppDimentions.pageMargin),
                shrinkWrap: true,
                itemCount: 3,
                itemBuilder: (context, index) {
                  return NoteItem(isActionMode: actionMode);
                })
          ]),
        ));
  }
}
