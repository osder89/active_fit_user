
import 'package:flutter/material.dart';

class AppTheme {
  static const Color primaryColor = Color.fromARGB(255, 193, 21, 21);
  static const Color scaffoldBbColor = Color(0xFF0C0B0C);
  static const Color textFieldBgColor = Color(0xFF23262B);
  static const Color textFieldHintColor = Color(0xFF777777);

  static const Color titleColor = Color(0xFF1ED760);
  static const Color whiteTextColor = Colors.white;
  static const Color greyTextColor = Color(0xFF595959);
  static const Color cardContainer = Color.fromARGB(255, 114, 114, 114) ;

  ThemeData getTheme() => ThemeData(
    useMaterial3: true,
    colorSchemeSeed: const Color(0xFF2862F5)
  );

}