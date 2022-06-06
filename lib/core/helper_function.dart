import 'package:flutter/material.dart';
import 'package:note_app/theme/colors.dart';

import '../constants/enums.dart';

Color toColor(NoteColor color) {
  switch (color) {
    case NoteColor.blue:
      return AppColors.noteBlue;
    case NoteColor.yellow:
      return AppColors.noteYellow;
    case NoteColor.grey:
      return AppColors.noteGrey;
    case NoteColor.orange:
      return AppColors.noteOrange;
    case NoteColor.green:
      return AppColors.noteGreen;
    case NoteColor.red:
      return AppColors.noteRed;
  }
}

IconData toIconData(NoteTag tag) {
  switch (tag) {
    case NoteTag.none:
      return Icons.block_rounded;
    case NoteTag.home:
      return Icons.home_rounded;
    case NoteTag.work:
      return Icons.work_rounded;
    case NoteTag.school:
      return Icons.school;
  }
}
