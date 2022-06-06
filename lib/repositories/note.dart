import 'dart:convert';
import 'dart:math';

import 'package:get/get.dart';

import 'package:note_app/constants/enums.dart';

class Note {
  int? id;
  String title;
  DateTime date;
  String note;
  RxBool isSelected = false.obs;
  NoteColor color;
  NoteTag tag;
  Note(
      {this.id,
      required this.title,
      required this.date,
      required this.note,
      this.color = NoteColor.grey,
      this.tag = NoteTag.none});

  factory Note.empty() => Note(title: "", date: DateTime.now(), note: "");

  String formatDate() {
    return "";
  }

  static List<Note> getExampleList({int count = 20}) {
    List<Note> tempList = [];
    var rand = Random();
    for (int i = 0; i < count; i++) {
      tempList.add(
        Note(
          color: NoteColor.values[rand.nextInt(6)],
          tag: NoteTag.values[rand.nextInt(4)],
          title: "Note Title",
          date: DateTime.now(),
          note: "Lorem Ipsum has been the industry's standard text ever "
              "since the 1500s, when an unknown printer of type "
              "and scrambled it to also make a type specimen. It has a"
              "survived not only five centuries, but also in the leap into...",
        ),
      );
    }
    return tempList;
  }

  Note copyWith({
    int? id,
    String? title,
    DateTime? date,
    String? note,
    NoteColor? color,
    NoteTag? tag,
  }) {
    return Note(
      id: id ?? this.id,
      title: title ?? this.title,
      date: date ?? this.date,
      note: note ?? this.note,
      color: color ?? this.color,
      tag: tag ?? this.tag,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'date': date.millisecondsSinceEpoch,
      'note': note,
      'color': color.name,
      'tag': tag.name,
    };
  }

  factory Note.fromMap(Map<String, dynamic> map) {
    return Note(
      id: map['id']?.toInt(),
      title: map['title'] ?? '',
      date: DateTime.fromMillisecondsSinceEpoch(map['date']),
      note: map['note'] ?? '',
      color: NoteColor.values.byName(map['color']),
      tag: NoteTag.values.byName(map['tag']),
    );
  }

  String toJson() => json.encode(toMap());

  factory Note.fromJson(String source) => Note.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Note(id: $id, title: $title, date: $date, note: $note, color: $color, tag: $tag)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Note &&
        other.id == id &&
        other.title == title &&
        other.date == date &&
        other.note == note &&
        other.color == color &&
        other.tag == tag;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        title.hashCode ^
        date.hashCode ^
        note.hashCode ^
        color.hashCode ^
        tag.hashCode;
  }
}
