import 'package:get/get.dart';
import 'package:note_app/data/models/note.dart';
import 'package:note_app/data/repositories/note_db_provider.dart';

class NotesPageController extends GetxController {
  RxBool actionMode = RxBool(false);
  RxBool isNoteLoading = RxBool(false);
  RxList<Note> noteList = RxList.empty(growable: true);
  RxList<Note> filteredNoteList = RxList.empty(growable: true);

  NotesPageController() {
    getNotesFromDB();
  }

  void _setNotes(List<Note> notes) {
    noteList.clear();
    filteredNoteList.clear();
    noteList.addAll(notes);
    filteredNoteList.addAll(noteList);
  }

  void filterNotes(String query) {
    final tempQuery = query.trim();
    filteredNoteList.clear();
    if (tempQuery.isEmpty) {
      filteredNoteList.addAll(noteList);
      return;
    }
    for (var note in noteList) {
      if (note.title.trim().toLowerCase().contains(tempQuery.toLowerCase())) {
        filteredNoteList.add(note);
      }
    }
  }

  getNotesFromDB() {
    try {
      isNoteLoading.value = true;
      NoteDBProvider.instance.getAllNotes().then((value) {
        _setNotes(value);
      }, onError: (error) {
        printError(info: error.toString());
      });
      // noteList = Note.getExampleList();
      // change(noteList, status: RxStatus.success());
    } catch (e) {
      printError(info: e.toString());
    }
    isNoteLoading.value = false;
  }

  refreshNotes() {
    try {
      NoteDBProvider.instance.getAllNotes().then((value) {
        _setNotes(value);
      }, onError: (error) {
        printError(info: error.toString());
      });
      // noteList = Note.getExampleList();
      // change(noteList, status: RxStatus.success());
    } catch (e) {
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
    for (var note in filteredNoteList) {
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
