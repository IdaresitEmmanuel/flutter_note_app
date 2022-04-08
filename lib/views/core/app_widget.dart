import 'package:flutter/material.dart';
import 'package:note_app/theme/theme.dart';
import 'package:note_app/views/notes_page/notes_page.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: lightTheme,
        home: const NotesPage());
  }
}
