import 'package:flutter/material.dart';
import 'package:pmsn2024b/settings/colors_settings.dart';

class ThemeSettings {
  static ThemeData lightTheme() {
    //final theme = ThemeData.light();
    return ThemeData.light().copyWith(scaffoldBackgroundColor: Colors.white);
  }

  static ThemeData darkTheme() {
    //final theme = ThemeData.dark();
    return ThemeData.dark().copyWith(
      scaffoldBackgroundColor: Colors.black,
    );
  }

  static ThemeData customTheme() {
    return ThemeData(
      primaryColor: Colors.grey,
      brightness: Brightness.light,
      appBarTheme: const AppBarTheme(
        color: Colors.grey,
      ),
      scaffoldBackgroundColor: ColorsSettings.btnLoginColor,
    );
  }
}
