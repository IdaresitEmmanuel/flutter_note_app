import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:note_app/core/helper_function.dart';
import 'package:note_app/data/repositories/note.dart';
import 'package:note_app/data/repositories/note_db_provider.dart';

import '../../core/constants/enums.dart';

class EditPageController extends GetxController {
  var editMode = true.obs;
  var note = Note.empty().obs;

  setNote(Note note) {
    this.note.value = note;
  }

  editTitle(String value) {
    note.value = note.value.copyWith(title: value);
  }

  editNote(String value) {
    note.value = note.value.copyWith(note: value);
  }

  editTag(NoteTag tag) {
    note.value = note.value.copyWith(tag: tag);
    saveNote();
  }

  editColor(Color color) {
    note.value = note.value.copyWith(color: toNoteColor(color));
    saveNote();
  }

  Future<String> saveNote() async {
    String tempString = "";
    try {
      if (note.value.id == null) {
        final result = await NoteDBProvider.instance.addNote(note.value);
        tempString = result ? "Note successfully added!" : "An error occured";
        NoteDBProvider.instance.getAllNotes().then((value) {
          note.value = note.value.copyWith(id: value.last.id);
        });
        editMode.value = !result;
      } else {
        final result = await NoteDBProvider.instance.updateNote(note.value);
        tempString = result ? "Note successfully updated!" : "An error occured";
        editMode.value = !result;
      }
    } catch (e) {
      printError(info: e.toString());
    }
    return tempString;
  }

  deleteNote() => NoteDBProvider.instance.deleteNote(note.value);

  activateEditing() {
    editMode.value = true;
  }
}
