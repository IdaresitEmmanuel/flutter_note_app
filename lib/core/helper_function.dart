import 'package:flutter/material.dart';
import 'package:note_app/theme/colors.dart';

import '../core/constants/enums.dart';

Color toColor(NoteColor color) {
  // switch (color) {
  //   case NoteColor.blue:
  //     return AppColors.noteBlue;
  //   case NoteColor.yellow:
  //     return AppColors.noteYellow;
  //   case NoteColor.grey:
  //     return AppColors.noteGrey;
  //   case NoteColor.orange:
  //     return AppColors.noteOrange;
  //   case NoteColor.green:
  //     return AppColors.noteGreen;
  //   case NoteColor.red:
  //     return AppColors.noteRed;
  // }

  return {
    NoteColor.blue: AppColors.noteBlue,
    NoteColor.yellow: AppColors.noteYellow,
    NoteColor.grey: AppColors.noteGrey,
    NoteColor.orange: AppColors.noteOrange,
    NoteColor.green: AppColors.noteGreen,
    NoteColor.red: AppColors.noteRed,
  }[color] as Color;
}

NoteColor toNoteColor(Color color) {
  return {
    AppColors.noteBlue: NoteColor.blue,
    AppColors.noteYellow: NoteColor.yellow,
    AppColors.noteGrey: NoteColor.grey,
    AppColors.noteOrange: NoteColor.orange,
    AppColors.noteGreen: NoteColor.green,
    AppColors.noteRed: NoteColor.red,
  }[color] as NoteColor;
}

IconData toIconData(NoteTag tag) {
  // switch (tag) {
  //   case NoteTag.none:
  //     return Icons.block_rounded;
  //   case NoteTag.home:
  //     return Icons.home_rounded;
  //   case NoteTag.work:
  //     return Icons.work_rounded;
  //   case NoteTag.school:
  //     return Icons.school;
  // }

  return {
    NoteTag.none: Icons.block_rounded,
    NoteTag.home: Icons.home_rounded,
    NoteTag.work: Icons.work_rounded,
    NoteTag.school: Icons.school_rounded,
  }[tag] as IconData;
}
