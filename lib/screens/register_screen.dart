import 'package:flutter/material.dart';
import 'package:pmsn2024b/firebase/email_auth.dart';
import 'package:pmsn2024b/settings/colors_settings.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final conName = TextEditingController();
  final conUser = TextEditingController();
  final conPwd = TextEditingController();
  bool isLoading = false;
  EmailAuth auth = EmailAuth();

  @override
  Widget build(BuildContext context) {
    TextFormField txtName = TextFormField(
      keyboardType: TextInputType.name,
      controller: conName,
      decoration: const InputDecoration(
        labelText: 'Nombre completo',
        filled: true,
        fillColor: Color.fromARGB(255, 229, 236, 58),
        prefixIcon: Icon(Icons.short_text),
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

    final txtUser = TextFormField(
      keyboardType: TextInputType.emailAddress,
      controller: conUser,
      decoration: const InputDecoration(
        filled: true,
        labelText: 'Correo',
        fillColor: Color.fromARGB(255, 229, 236, 58),
        prefixIcon: Icon(Icons.person_outline),
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
        labelText: 'Contraseña',
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
      bottom: 110,
      child: Container(
        width: MediaQuery.of(context).size.width * .9,
        // margin: EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
        child: ListView(
          shrinkWrap: true,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 5),
              child: txtName,
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 5),
              child: txtUser,
            ),
            txtPwd
          ],
        ),
      ),
    );

    final btnRegister = Positioned(
      width: MediaQuery.of(context).size.width * .6,
      height: MediaQuery.of(context).size.height * .046,
      bottom: 60,
      child: ElevatedButton.icon(
        style: ElevatedButton.styleFrom(
            backgroundColor: ColorsSettings.btnLoginColor),
        onPressed: () {
          isLoading = true;
          auth.createUser(conName.text, conUser.text, conPwd.text).then(
            (value) {
              value
                  ? setState(() {
                      isLoading = false;
                    })
                  : isLoading;
              Navigator.pushNamed(context, "/login");
            },
          );
        },
        icon: const Icon(
          Icons.app_registration,
          color: Color.fromARGB(255, 229, 236, 58),
        ),
        label: const Text(
          'Registrar',
          style: TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
        ),
      ),
    );

    final btnCancel = Positioned(
      width: MediaQuery.of(context).size.width * .6,
      height: MediaQuery.of(context).size.height * .046,
      bottom: 10, // Lo colocamos un poco más abajo que el de registrarse
      child: ElevatedButton.icon(
        style: ElevatedButton.styleFrom(
            backgroundColor: ColorsSettings.btnLoginColor),
        onPressed: () {
          // Regresa a la pantalla de login
          Navigator.pushNamed(context, "/login");
        },
        icon: const Icon(
          Icons.keyboard_return,
          color: Color.fromARGB(255, 229, 236, 58),
        ),
        label: const Text(
          'Cancelar',
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
            const Positioned(
              top: 30,
              child: Text(
                '¡Bievenido!',
                style: TextStyle(fontSize: 60, fontWeight: FontWeight.bold),
              ),
            ),
            ctnCredentials,
            btnRegister,
            btnCancel,
            isLoading ? gifLoading : Container(),
          ],
        ),
      ),
    );
  }
}
