import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:note_app/dependency_ijn.dart' as dependency;
import 'package:note_app/views/core/app_widget.dart';

import 'core/constants/enums.dart';

void main() {
  dependency.init();
  AwesomeNotifications().initialize(null, [
    NotificationChannel(
        channelKey: NoteReminderChannel.reminderChannelKey.name,
        channelName: 'reminder alarm notification',
        importance: NotificationImportance.High,
        channelDescription: 'To show scheduled note reminder notifications'),
  ]);
  if (kIsWeb) {
    // sqfliteWindowsFfiInit();
  }
  // font license
  LicenseRegistry.addLicense(() async* {
    final license = await rootBundle.loadString('assets/fonts/OFL.txt');
    yield LicenseEntryWithLineBreaks(['google_fonts'], license);
  });
  runApp(const AppWidget());
}
