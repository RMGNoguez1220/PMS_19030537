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
      bottom: 90,
      child: Container(
        width: MediaQuery.of(context).size.width * .9,
        // margin: EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
        child: ListView(
          shrinkWrap: true,
          children: [txtUser, txtPwd],
        ),
      ),
    );

    final btnLogin = Positioned(
      width: MediaQuery.of(context).size.width * .9,
      bottom: 40,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
            backgroundColor: ColorsSettings.btnLoginColor),
        onPressed: () {
          isLoading = true;
          setState(() {});
          Future.delayed(const Duration(milliseconds: 3490)).then((value) => {
                isLoading = false,
                setState(() {}),
                Navigator.pushNamed(context, "/home")
              });
        },
        child: const Text(
          'Validar usuario...',
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
            fit: BoxFit.cover,
            image: AssetImage("assets/misterchif.jpg"),
          ),
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Positioned(
              top: 1,
              child: Image.asset('assets/halo-wide.png', width: 300),
            ),
            ctnCredentials,
            btnLogin,
            isLoading ? gifLoading : Container(),
          ],
        ),
      ),
    );
  }
}
