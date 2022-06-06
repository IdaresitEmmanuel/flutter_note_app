import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:note_app/dependency_ijn.dart' as dependency;
import 'package:note_app/views/core/app_widget.dart';

void main() {
  dependency.init();
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
