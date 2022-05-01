import 'dart:convert';

import 'package:get/get.dart';

class Note {
  final int? id;
  final String title;
  final DateTime date;
  final String note;
  final isSelected = false.obs;
  Note({
    this.id,
    required this.title,
    required this.date,
    required this.note,
  });

  factory Note.empty() => Note(title: "", date: DateTime.now(), note: "");

  Note copyWith({
    int? id,
    String? title,
    DateTime? date,
    String? note,
  }) {
    return Note(
      id: id ?? this.id,
      title: title ?? this.title,
      date: date ?? this.date,
      note: note ?? this.note,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'date': date.toIso8601String(),
      'note': note,
    };
  }

  factory Note.fromMap(Map<String, dynamic> map) {
    return Note(
      id: map['id']?.toInt() ?? 0,
      title: map['title'] ?? '',
      date: DateTime.parse(map['date']),
      note: map['note'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Note.fromJson(String source) => Note.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Note(id: $id, title: $title, date: $date, note: $note)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Note &&
        other.id == id &&
        other.title == title &&
        other.date == date &&
        other.note == note;
  }

  @override
  int get hashCode {
    return id.hashCode ^ title.hashCode ^ date.hashCode ^ note.hashCode;
  }
}
