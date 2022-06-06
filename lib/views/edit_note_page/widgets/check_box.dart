import "package:flutter/material.dart";
import 'package:note_app/theme/colors.dart';

class AppCheckBox extends StatelessWidget {
  const AppCheckBox({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 20.0,
      width: 20.0,
      decoration: BoxDecoration(
          color: AppColors.primaryColor,
          borderRadius: BorderRadius.circular(12)),
      child: const Icon(
        Icons.check_rounded,
        color: Colors.white,
        size: 16,
      ),
    );
  }
}
