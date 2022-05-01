import 'package:flutter/material.dart';

class NoteCheckBox extends StatelessWidget {
  const NoteCheckBox({Key? key, this.isChecked = false}) : super(key: key);
  final bool isChecked;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 10.0, top: 10.0),
      height: 30.0,
      width: 30.0,
      decoration: BoxDecoration(
          border: Border.all(color: isChecked ? Colors.blue : Colors.black),
          color: isChecked ? Colors.blue : null,
          borderRadius: BorderRadius.circular(15.0)),
      child: isChecked
          ? const Icon(Icons.check, color: Colors.white)
          : const SizedBox.shrink(),
    );
  }
}
