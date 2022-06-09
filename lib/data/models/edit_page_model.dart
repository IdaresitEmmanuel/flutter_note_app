import 'package:note_app/data/repositories/note.dart';
// import 'package:note_app/repositories/note_db_provider.dart';

class EditPageModel {
  Future<Note> getNote(int id) async {
    // return NoteDBProvider.instance.getNote(id);

    return Note(
        title: "The best note",
        date: DateTime.now(),
        note: "Lorem Ipsum has been the industry's standard text ever "
            "since the 1500s, when an unknown printer of type "
            "and scrambled it to also make a type specimen. It has a"
            "survived not only five centuries, but also in the leap into...",
        reminderDate: DateTime.now());
  }
}
