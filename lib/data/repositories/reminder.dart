// import 'dart:convert';

// class Reminder {
//   int id;
//   DateTime date;
//   Reminder({
//     required this.id,
//     required this.date,
//   });

//   Reminder copyWith({
//     int? id,
//     DateTime? date,
//   }) {
//     return Reminder(
//       id: id ?? this.id,
//       date: date ?? this.date,
//     );
//   }

//   Map<String, dynamic> toMap() {
//     return {
//       'id': id,
//       'date': date.millisecondsSinceEpoch,
//     };
//   }

//   factory Reminder.fromMap(Map<String, dynamic> map) {
//     return Reminder(
//       id: map['id']?.toInt() ?? 0,
//       date: DateTime.fromMillisecondsSinceEpoch(map['date']),
//     );
//   }

//   String toJson() => json.encode(toMap());

//   factory Reminder.fromJson(String source) =>
//       Reminder.fromMap(json.decode(source));

//   @override
//   String toString() => 'Reminder(id: $id, date: $date)';

//   @override
//   bool operator ==(Object other) {
//     if (identical(this, other)) return true;

//     return other is Reminder && other.id == id && other.date == date;
//   }

//   @override
//   int get hashCode => id.hashCode ^ date.hashCode;
// }
