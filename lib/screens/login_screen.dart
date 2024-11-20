import 'package:flutter/material.dart';
import 'package:pmsn2024b/settings/colors_settings.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final conUser = TextEditingController();
  final conPwd = TextEditingController();
  bool isLoading = false;

  Future<void> _setOnboardingSeen() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('onboardingSeen', true);
  }

  Future<bool> _getOnboardingSeen() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool('onboardingSeen') ?? false;
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    TextFormField txtUser = TextFormField(
      keyboardType: TextInputType.emailAddress,
      controller: conUser,
      decoration: const InputDecoration(
        labelText: 'Correo',
        labelStyle: TextStyle(color: Colors.black),
        filled: true,
        fillColor: Color.fromARGB(255, 229, 236, 58),
        prefixIcon: Icon(Icons.person, color: Colors.black),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.red,
            width: 1.3,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Color.fromARGB(
                255, 100, 206, 108), // Color del borde cuando está enfocado
            width: 3.0, // Ancho del borde
          ),
        ),
      ),
    );

    final txtPwd = TextFormField(
      keyboardType: TextInputType.text,
      obscureText: true,
      controller: conPwd,
      decoration: const InputDecoration(
        labelText: 'Contraseña',
        labelStyle: TextStyle(color: Colors.black),
        filled: true,
        fillColor: Color.fromARGB(255, 229, 236, 58),
        prefixIcon: Icon(Icons.password, color: Colors.black),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.red,
            width: 1.3,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Color.fromARGB(
                255, 100, 206, 108), // Color del borde cuando está enfocado
            width: 3.0, // Ancho del borde
          ),
        ),
      ),
    );

    final ctnCredentials = Positioned(
      bottom: 105,
      child: Container(
        width: screenWidth * .9,
        // margin: EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
        ),
        child: ListView(
          shrinkWrap: true,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 5),
              child: txtUser,
            ),
            txtPwd
          ],
        ),
      ),
    );

    final btnLogin = Positioned(
      width: screenWidth * .6,
      height: screenHeight * .046,
      bottom: 60,
      child: ElevatedButton.icon(
        style: ElevatedButton.styleFrom(
            side: const BorderSide(color: Colors.black, width: 1.5),
            backgroundColor: ColorsSettings.btnLoginColor),
        onPressed: () async {
          isLoading = true;
          setState(() {});
          bool onboardingSeen = await _getOnboardingSeen();
          await Future.delayed(const Duration(milliseconds: 1000))
              .then((value) async => {
                    isLoading = false,
                    setState(() {}),
                    if (onboardingSeen)
                      {Navigator.pushReplacementNamed(context, "/home")}
                    else
                      {
                        await _setOnboardingSeen(),
                        Navigator.pushReplacementNamed(context, '/onboarding1')
                      }
                  });
        },
        icon: const Icon(
          Icons.login,
          color: Color.fromARGB(255, 229, 236, 58),
        ),
        label: const Text(
          ' Log in ',
          style: TextStyle(
            color: Color.fromARGB(255, 0, 0, 0),
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );

    final btnRegister = Positioned(
      width: screenWidth * .6,
      height: screenHeight * .046,
      bottom: 10,
      child: ElevatedButton.icon(
        style: ElevatedButton.styleFrom(
            side: const BorderSide(color: Colors.black, width: 1.5),
            backgroundColor: ColorsSettings.btnLoginColor),
        onPressed: () {
          isLoading = true;
          setState(() {});
          Future.delayed(const Duration(milliseconds: 500)).then((value) => {
                isLoading = false,
                setState(() {}),
                Navigator.pushNamed(context, "/register")
              });
        },
        icon: const Icon(
          Icons.app_registration,
          color: Color.fromARGB(255, 229, 236, 58),
        ),
        label: const Text(
          'Sign up',
          style: TextStyle(
            color: Color.fromARGB(255, 0, 0, 0),
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );

    final gifLoading = Positioned(
      bottom: 100,
      child: Image.asset(
        'assets/Loading.gif',
        height: screenHeight,
        width: screenWidth,
      ),
    );

    return Scaffold(
      body: Container(
        height: screenHeight,
        width: screenWidth,
        decoration: const BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.scaleDown,
            image: AssetImage("assets/misterchif.jpg"),
          ),
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Positioned(
              top: 30,
              child: Container(
                decoration: BoxDecoration(
                  color:
                      Colors.white.withOpacity(0.4), // Fondo semitransparente
                  borderRadius: BorderRadius.circular(15), // Bordes redondeados
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.3),
                      blurRadius: 10,
                      offset: const Offset(0, 50), // Sombra hacia abajo
                    ),
                  ],
                ),
                padding: const EdgeInsets.all(
                  10,
                ), // Espaciado interno alrededor de la imagen
                child: Image.asset(
                  'assets/halo-wide.png',
                  width: 300,
                ),
              ),
            ),
            ctnCredentials,
            btnLogin,
            btnRegister,
            isLoading ? gifLoading : Container(),
          ],
        ),
      ),
    );
  }
}
