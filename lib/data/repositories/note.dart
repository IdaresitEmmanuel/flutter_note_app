import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import 'package:note_app/core/constants/enums.dart';
import 'package:note_app/theme/colors.dart';

class Note {
  int? id;
  String title;
  DateTime date;
  String note;
  RxBool isSelected = false.obs;
  NoteColor color;
  NoteTag tag;
  DateTime reminderDate;
  NoteReminder reminderStatus;
  Note(
      {this.id,
      required this.title,
      required this.date,
      required this.note,
      this.color = NoteColor.grey,
      this.tag = NoteTag.none,
      required this.reminderDate,
      this.reminderStatus = NoteReminder.none});

  factory Note.empty() => Note(
      title: "", date: DateTime.now(), note: "", reminderDate: DateTime.now());

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
          reminderDate: DateTime.now(),
          reminderStatus: NoteReminder.values[rand.nextInt(2)],
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
    DateTime? reminderDate,
    NoteReminder? reminderStatus,
  }) {
    return Note(
      id: id ?? this.id,
      title: title ?? this.title,
      date: date ?? this.date,
      note: note ?? this.note,
      color: color ?? this.color,
      tag: tag ?? this.tag,
      reminderDate: reminderDate ?? this.reminderDate,
      reminderStatus: reminderStatus ?? this.reminderStatus,
    );
  }

  String getFormattedDate() {
    return DateFormat().format(date);
  }

  String getFormattedReminderDate() {
    return DateFormat().format(reminderDate);
  }

  Color getReminderTextColor() {
    return reminderDate.millisecondsSinceEpoch >
            DateTime.now().millisecondsSinceEpoch
        ? AppColors.primaryColor
        : Colors.orange;
  }

  bool isReminderActive() {
    return reminderDate.millisecondsSinceEpoch >
            DateTime.now().millisecondsSinceEpoch
        ? true
        : false;
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'date': date.millisecondsSinceEpoch,
      'note': note,
      'color': color.name,
      'tag': tag.name,
      'reminder_date': reminderDate.millisecondsSinceEpoch,
      'reminder_status': reminderStatus.name,
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
      reminderDate: DateTime.fromMicrosecondsSinceEpoch(map['reminder_date']),
      reminderStatus: NoteReminder.values.byName(map['reminder_status']),
    );
  }

  String toJson() => json.encode(toMap());

  factory Note.fromJson(String source) => Note.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Note(id: $id, title: $title, date: $date, note: $note, color: $color, tag: $tag, reminderDate: $reminderDate, reminderStatus: $reminderStatus)';
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
        other.tag == tag &&
        other.reminderDate == reminderDate &&
        other.reminderStatus == reminderStatus;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        title.hashCode ^
        date.hashCode ^
        note.hashCode ^
        color.hashCode ^
        tag.hashCode ^
        reminderDate.hashCode ^
        reminderStatus.hashCode;
  }
}
