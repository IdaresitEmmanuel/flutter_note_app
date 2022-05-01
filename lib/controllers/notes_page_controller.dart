import 'package:get/get.dart';
import 'package:note_app/repositories/note.dart';
import 'package:note_app/repositories/note_db_provider.dart';

class NotesPageController extends GetxController with StateMixin<List<Note>> {
  RxBool actionMode = RxBool(false);
  List<Note> noteList = [];

  NotesPageController() {
    getNotesFromDB();
  }

  getNotesFromDB() {
    try {
      change(null, status: RxStatus.loading());
      NoteDBProvider.instance.getAllNotes().then((value) {
        noteList = value;
        change(noteList, status: RxStatus.success());
      }, onError: (error) {
        change(null, status: RxStatus.error(error.toString()));
        printError(info: error.toString());
      });
    } catch (e) {
      change(null, status: RxStatus.error(e.toString()));
      printError(info: e.toString());
    }
  }

  refreshNotes() {
    try {
      // change(null, status: RxStatus.loading());
      NoteDBProvider.instance.getAllNotes().then((value) {
        noteList = value;
        change(noteList, status: RxStatus.success());
      }, onError: (error) {
        change(null, status: RxStatus.error(error.toString()));
        printError(info: error.toString());
      });
    } catch (e) {
      change(null, status: RxStatus.error(e.toString()));
      printError(info: e.toString());
    }
  }

  toggleActionMode([bool? value]) {
    actionMode.value = value ?? !actionMode.value;
    if (!actionMode.value) {
      unselectAllNotes();
    }
  }

  unselectAllNotes() {
    for (var element in noteList) {
      element.isSelected.value = false;
    }
  }

  List<Note> getSelectedNotes() {
    List<Note> tempList = [];
    for (var note in noteList) {
      if (note.isSelected.value) {
        tempList.add(note);
      }
    }
    return tempList;
  }

  deleteNotes() {
    final list = getSelectedNotes();
    for (var note in list) {
      NoteDBProvider.instance.deleteNote(note);
    }
    toggleActionMode(false);
    refreshNotes();
  }
}
