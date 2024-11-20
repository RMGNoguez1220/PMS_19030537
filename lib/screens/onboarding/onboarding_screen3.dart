import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:pmsn2024b/settings/colors_settings.dart';
import 'package:pmsn2024b/settings/theme_notifier.dart';

class OnboardingScreen3 extends StatelessWidget {
  const OnboardingScreen3({super.key, required this.themeNotifier});
  final ThemeNotifier themeNotifier;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: ColorsSettings.bottomColor,
        title: Text(
          "Configuración tema",
          style: TextStyle(
            color: Theme.of(context).colorScheme.onSurface,
          ),
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Lottie.asset(
                'assets/lotties/ejotepopcorns.json',
                width: 150,
                height: 150,
                fit: BoxFit.fill,
              ),
              const SizedBox(height: 20),
              Text(
                "Selecciona un tema que prefieras...",
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onSurface,
                  fontSize: 20,
                  fontWeight: FontWeight.bold
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              _buildButton(
                context,
                label: "Tema claro",
                onPressed: () {
                  themeNotifier.setTheme('light');
                },
                buttonColor: ColorsSettings.navColor,
                screenWidth: screenWidth,
                icon: Icons.wb_sunny,
              ),
              _buildButton(
                context,
                label: "Tema oscuro",
                onPressed: () {
                  themeNotifier.setTheme('dark');
                },
                buttonColor: Colors.grey,
                screenWidth: screenWidth,
                icon: Icons.nights_stay,
              ),
              _buildButton(
                context,
                label: "Tema personalizado",
                onPressed: () {
                  themeNotifier.setTheme('custom');
                },
                buttonColor: Colors.green,
                screenWidth: screenWidth,
                icon: Icons.palette,
              ),
              const SizedBox(height: 20),
              // Opción para cambiar la fuente
              Card(
                elevation: 3,
                margin: const EdgeInsets.only(left: 40, right: 40),
                child: ListTile(
                  leading: Icon(Icons.font_download_outlined,
                      color: ColorsSettings.btnLoginColor),
                  title: Text(
                    "Fuente",
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.onSurface,
                      fontSize: 14,
                    ),
                  ),
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
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              _buildButton(context, label: "Entrar a la app...", onPressed: () {
                Navigator.pushReplacementNamed(context, '/home');
              },
                  buttonColor: ColorsSettings.bottomColor,
                  screenWidth: screenWidth,
                  icon: Icons.login),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildButton(
    BuildContext context, {
    required String label,
    required VoidCallback onPressed,
    required double screenWidth,
    required Color? buttonColor,
    required IconData? icon, // Ícono proporcionado
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: SizedBox(
        width: screenWidth * 0.8, // Ajusta al 80% del ancho de la pantalla
        height: 50, // Altura fija para todos los botones
        child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            backgroundColor: buttonColor,
          ),
          child: Row(
            mainAxisAlignment:
                MainAxisAlignment.start, // Alineación a la izquierda
            children: [
              Icon(
                icon, // Ícono del botón
                color: Theme.of(context).colorScheme.onSurface,
              ),
              const SizedBox(width: 10), // Espaciado entre el ícono y el texto
              Text(
                label,
                style: TextStyle(
                  fontSize: 18,
                  color: Theme.of(context).colorScheme.onSurface,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
