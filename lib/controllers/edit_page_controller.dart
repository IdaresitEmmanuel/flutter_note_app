import 'package:get/get.dart';
import 'package:note_app/models/edit_page_model.dart';
import 'package:note_app/repositories/note.dart';
import 'package:note_app/repositories/note_db_provider.dart';

class EditPageController extends GetxController {
  final model = EditPageModel();
  var editMode = true.obs;
  Note? note;
  EditPageController(this.note) {
    note ??= Note.empty();
  }

  editTitle(String value) {
    note = note!.copyWith(title: value);
  }

  editNote(String value) {
    note = note!.copyWith(note: value);
  }

  saveNote() async {
    try {
      final result = note!.id == null
          ? await NoteDBProvider.instance.addNote(note!)
          : await NoteDBProvider.instance.updateNote(note!);
      editMode.value = !result;
      if (note!.id == null) {
        NoteDBProvider.instance.getAllNotes().then((value) {
          note = note!.copyWith(id: value.last.id);
        });
      }
    } catch (e) {
      printError(info: e.toString());
    }
  }

  deleteNote() => NoteDBProvider.instance.deleteNote(note!);

  activateEditing() {
    editMode.value = true;
  }
}
