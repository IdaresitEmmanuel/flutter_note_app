import 'package:get/get.dart';
import 'package:note_app/repositories/note.dart';
import 'package:note_app/repositories/note_db_provider.dart';

class EditPageController extends GetxController {
  var editMode = true.obs;
  var note = Note.empty().obs;

  setNote(Note note) {
    this.note.value = note;
  }

  editTitle(String value) {
    note.value.copyWith(title: value);
  }

  editNote(String value) {
    note.value.copyWith(note: value);
  }

  saveNote() async {
    try {
      final result = note.value.id == null
          ? await NoteDBProvider.instance.addNote(note.value)
          : await NoteDBProvider.instance.updateNote(note.value);
      editMode.value = !result;
      if (note.value.id == null) {
        NoteDBProvider.instance.getAllNotes().then((value) {
          note.value.copyWith(id: value.last.id);
        });
      }
    } catch (e) {
      printError(info: e.toString());
    }
  }

  deleteNote() => NoteDBProvider.instance.deleteNote(note.value);

  activateEditing() {
    editMode.value = true;
  }
}
