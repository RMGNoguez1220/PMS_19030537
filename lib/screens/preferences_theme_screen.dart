import 'package:flutter/material.dart';
import 'package:pmsn2024b/settings/colors_settings.dart';
import 'package:pmsn2024b/settings/theme_notifier.dart';
import 'package:pmsn2024b/settings/theme_settings.dart';

class PreferencesThemeScreen extends StatelessWidget {
  const PreferencesThemeScreen({super.key, required this.themeNotifier});
  final ThemeNotifier themeNotifier;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Temas"),
        backgroundColor: ColorsSettings.bottomColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Tema Claro
            Card(
              elevation: 3,
              child: ListTile(
                leading: const Icon(Icons.wb_sunny, color: Colors.amberAccent),
                title: const Text(
                  "Tema Claro",
                  style: TextStyle(fontSize: 18),
                ),
                trailing: Radio<String>(
                  value: 'light',
                  groupValue: themeNotifier.currentTheme,
                  onChanged: (value) {
                    if (value != null) {
                      themeNotifier.setTheme(value);
                    }
                  },
                ),
              ),
            ),
            const SizedBox(height: 20),
            // Tema Oscuro
            Card(
              elevation: 3,
              child: ListTile(
                leading: const Icon(Icons.nights_stay, color: Colors.blueGrey),
                title: const Text(
                  "Tema Oscuro",
                  style: TextStyle(fontSize: 18),
                ),
                trailing: Radio<String>(
                  value: 'dark',
                  groupValue: themeNotifier.currentTheme,
                  onChanged: (value) {
                    if (value != null) {
                      themeNotifier.setTheme(value);
                    }
                  },
                ),
              ),
            ),
            const SizedBox(height: 20),
            // Tema Personalizado
            Card(
              elevation: 3,
              child: ListTile(
                leading: const Icon(Icons.palette, color: Colors.purple),
                title: const Text(
                  "Tema Personalizado",
                  style: TextStyle(fontSize: 18),
                ),
                trailing: Radio<String>(
                  value: 'custom',
                  groupValue: themeNotifier.currentTheme,
                  onChanged: (value) {
                    if (value != null) {
                      themeNotifier.setTheme(value);
                    }
                  },
                ),
              ),
            ),
            const SizedBox(height: 20),
            // Opción para cambiar la fuente
            Card(
              elevation: 3,
              child: ListTile(
                leading: const Icon(Icons.font_download, color: Colors.blue),
                title: const Text("Fuente"),
                trailing: DropdownButton<String>(
                  value: themeNotifier.currentFont,
                  onChanged: (String? newValue) {
                    if (newValue != null) {
                      themeNotifier.setFont(newValue);
                    }
                  },
                  items: <String>['Roboto', 'Doto', 'Courier New', 'Edu']
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(
                        value,
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.onSurface,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
