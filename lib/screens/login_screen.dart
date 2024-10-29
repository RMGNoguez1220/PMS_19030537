import 'package:flutter/material.dart';
import 'package:pmsn2024b/settings/colors_settings.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final conUser = TextEditingController();
  final conPwd = TextEditingController();
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    TextFormField txtUser = TextFormField(
      keyboardType: TextInputType.emailAddress,
      controller: conUser,
      decoration: const InputDecoration(
        labelText: 'Correo',
        filled: true,
        fillColor: Color.fromARGB(255, 229, 236, 58),
        prefixIcon: Icon(Icons.person),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10))),
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
        filled: true,
        fillColor: Color.fromARGB(255, 229, 236, 58),
        prefixIcon: Icon(Icons.password),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10))),
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
        width: MediaQuery.of(context).size.width * .9,
        // margin: EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
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
      width: MediaQuery.of(context).size.width * .6,
      height: MediaQuery.of(context).size.height * .046,
      bottom: 60,
      child: ElevatedButton.icon(
        style: ElevatedButton.styleFrom(
            backgroundColor: ColorsSettings.btnLoginColor),
        onPressed: () {
          isLoading = true;
          setState(() {});
          Future.delayed(const Duration(milliseconds: 1000)).then((value) => {
                isLoading = false,
                setState(() {}),
                Navigator.pushNamed(context, "/home")
              });
        },
        icon: const Icon(
          Icons.login,
          color: Color.fromARGB(255, 229, 236, 58),
        ),
        label: const Text(
          ' Log in    ',
          style: TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
        ),
      ),
    );

    final btnRegister = Positioned(
      width: MediaQuery.of(context).size.width * .6,
      height: MediaQuery.of(context).size.height * .046,
      bottom: 10,
      child: ElevatedButton.icon(
        style: ElevatedButton.styleFrom(
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
          style: TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
        ),
      ),
    );

    final gifLoading = Positioned(
      top: 40,
      child: Image.asset(
        'assets/Loading.gif',
        height: 200,
        width: 200,
      ),
    );

    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
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
              child: Image.asset('assets/halo-wide.png', width: 300),
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
