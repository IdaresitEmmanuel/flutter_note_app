import 'package:flutter/material.dart';
import 'package:note_app/theme/dimensions.dart';

class DeleteDialog extends StatelessWidget {
  const DeleteDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      title: Text(
        "Are you sure you want to delete 2 items?",
        style: TextStyle(fontSize: AppDimentions.bodyTextMedium),
      ),
      children: [
        Container(
          margin: const EdgeInsets.only(right: 10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(onPressed: () {}, child: const Text("Cancel")),
              TextButton(onPressed: () {}, child: const Text("Confirm"))
            ],
          ),
        )
      ],
    );
  }
}
