import 'package:flutter/material.dart';
import 'package:pmsn2024b/settings/theme_settings.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeNotifier extends ValueNotifier<ThemeData> {
  static const String keyTheme = 'selectedTheme';
  static const String keyFont = 'selectedFont';
  String _currentFont = 'Roboto';
  String get currentFont => _currentFont;
  String _currentTheme = 'light';
  String get currentTheme => _currentTheme;

  ThemeNotifier() : super(ThemeSettings.lightTheme()) {
    _loadThemeFromPrefs();
  }

  Future<void> _loadThemeFromPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    _currentTheme = prefs.getString(keyTheme) ?? 'light';
    _currentFont = prefs.getString(keyFont) ?? 'Roboto';
    // _currentFont = selectedFont;
    if (_currentTheme == 'dark') {
      value = ThemeSettings.darkTheme();
    } else if (_currentTheme == 'custom') {
      value = ThemeSettings.customTheme();
    } else {
      value = ThemeSettings.lightTheme();
    }
    _updateFont();
  }

  Future<void> setTheme(String themeName) async {
    final prefs = await SharedPreferences.getInstance();
    ThemeData newTheme;
    _currentTheme = themeName;

    if (themeName == 'dark') {
      newTheme = ThemeSettings.darkTheme();
      // await prefs.setString(keyTheme, 'dark');
    } else if (themeName == 'custom') {
      newTheme = ThemeSettings.customTheme();
      // await prefs.setString(keyTheme, 'custom');
    } else {
      newTheme = ThemeSettings.lightTheme();
      // await prefs.setString(keyTheme, 'light');
    }
    await prefs.setString(keyTheme, themeName);

    // Conserva el tipo de letra actual
    value = newTheme.copyWith(
      textTheme: newTheme.textTheme.copyWith(
        bodySmall: TextStyle(fontFamily: _currentFont),
        bodyMedium: TextStyle(fontFamily: _currentFont),
        bodyLarge: TextStyle(fontFamily: _currentFont),
        titleSmall: TextStyle(fontFamily: _currentFont),
        titleMedium: TextStyle(fontFamily: _currentFont),
        titleLarge: TextStyle(fontFamily: _currentFont),
        labelSmall: TextStyle(fontFamily: _currentFont),
        labelLarge: TextStyle(fontFamily: _currentFont),
        labelMedium: TextStyle(fontFamily: _currentFont),
      ),
    );
    notifyListeners();
  }

  // Cambiar la fuente global
  void setFont(String font) async {
    _currentFont = font;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(keyFont, font);
    _updateFont();
  }

  // Actualizar ThemeData con los nuevos valores de fuente y color
  void _updateFont() {
    value = value.copyWith(
      textTheme: value.textTheme.copyWith(
        bodySmall: TextStyle(fontFamily: _currentFont),
        bodyMedium: TextStyle(fontFamily: _currentFont),
        bodyLarge: TextStyle(fontFamily: _currentFont),
        titleSmall: TextStyle(fontFamily: _currentFont),
        titleMedium: TextStyle(fontFamily: _currentFont),
        titleLarge: TextStyle(fontFamily: _currentFont),
        labelSmall: TextStyle(fontFamily: _currentFont),
        labelLarge: TextStyle(fontFamily: _currentFont),
        labelMedium: TextStyle(fontFamily: _currentFont),
        // displaySmall: TextStyle(fontFamily: _currentFont),
        // displayMedium: TextStyle(fontFamily: _currentFont),
        // displayLarge: TextStyle(fontFamily: _currentFont),
        // headlineSmall: TextStyle(fontFamily: _currentFont),
        // headlineMedium: TextStyle(fontFamily: _currentFont),
        // headlineLarge: TextStyle(fontFamily: _currentFont),
      ),
    );
    notifyListeners();
  }
}
