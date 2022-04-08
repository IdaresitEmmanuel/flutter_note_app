import 'package:flutter/material.dart';
import 'package:note_app/theme/dimensions.dart';
import 'package:note_app/views/notes_page/widgets/delete_dialog.dart';

class ActionBar extends StatelessWidget {
  const ActionBar({Key? key}) : super(key: key);

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
                  "2 Items Selected",
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
                      return const DeleteDialog();
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
                // fixedSize: const Size(30.0, 40.0)
              ),
            ),
          )
        ]));
  }
}
