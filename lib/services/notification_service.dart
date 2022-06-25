import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:get/get.dart';
import 'package:note_app/data/models/note.dart';

import '../core/constants/enums.dart';

class NotificationService extends GetxService {
  void scheduleNotification(Note note) {
    AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: note.id ?? DateTime.now().microsecond,
        channelKey: NoteReminderChannel.reminderChannelKey.name,
        title: "${Emojis.time_alarm_clock} SpeedNote Reminder",
        body: note.title,
      ),
      schedule: NotificationCalendar(
        year: note.reminderDate.year,
        month: note.reminderDate.month,
        weekday: note.reminderDate.weekday,
        hour: note.reminderDate.hour,
        minute: note.reminderDate.minute,
        second: 0,
        millisecond: 0,
      ),
    );
  }
}
