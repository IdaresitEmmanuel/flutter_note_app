import 'package:flutter/material.dart';

class AppColors {
  static Color primaryColor = const Color(0xFF2A83DB);
  // static Color primaryAccent = const Color(0xFFDF78EF);
  // static Color primaryDark = const Color(0xFF790E8B);
  static Color cardColor = const Color(0xFFF6F1F1);
  static Color iconColor = const Color(0xFF484848);
  static Color dividerColor = const Color(0xFFE5E0E0);
  static double opacity = .5;
  // note color
  static Color noteBlue = const Color(0xFFA0DAF8).withOpacity(opacity);
  static Color noteYellow = const Color(0xFFF9F97F).withOpacity(opacity);
  static Color noteGrey = const Color(0xFFF8EFEF).withOpacity(opacity);
  static Color noteOrange = const Color(0xFFF8E0A0).withOpacity(opacity);
  static Color noteGreen = const Color(0xFF8CFF7F).withOpacity(opacity);
  static Color noteRed = const Color(0xFFFCC8C8).withOpacity(opacity);
  static List<Color> noteColorList = [
    noteBlue,
    noteYellow,
    noteGrey,
    noteOrange,
    noteGreen,
    noteRed
  ];
}
