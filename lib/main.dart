import 'package:flutter/material.dart';
import 'package:pmsn2024b/screens/home_screen.dart';
import 'package:pmsn2024b/screens/login_screen.dart';
import 'package:pmsn2024b/settings/global_values.dart';
import 'package:pmsn2024b/settings/theme_settings.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: GlobalValues.banThemeDark,
        builder: (context, value, widget) {
          return MaterialApp(
            theme: value ? ThemeSettings.darkTheme() : ThemeSettings.lightTheme(context),
            title: 'Material App',
            home: LoginScreen(),
            routes: {"/home": (context) => HomeScreen()},
            debugShowCheckedModeBanner: false,
          );
        });
  }
}

//*-*-Clase pasada-*-*
// import 'package:flutter/material.dart';

// void main() => runApp(MyApp());

// class MyApp extends StatefulWidget {
//   MyApp({super.key}); 
//   @override
//   State<MyApp> createState() => _MyAppState();
// }

// class _MyAppState extends State<MyApp> {
//  //<-- Parámetro nombrado
//   int contador = 0;

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         appBar: AppBar(
//           backgroundColor: Colors.blueGrey,
//           title: Text(
//             'Mi primer App',
//             style: TextStyle(color: Colors.indigo),
//           ),
//         ),
//         body: Container(
//           width: MediaQuery.of(context).size.width,
//           color: Colors.grey,
//           child: Center(
//             child: Text(
//               'Contador de Clicks: $contador',
//               textAlign: TextAlign.center,
//             ),
//           ),
//         ),
//         floatingActionButton: FloatingActionButton(
//             child: Icon(Icons.ads_click_sharp),
//             onPressed: () {
//               contador++;
//               setState(() {
                
//               });
//               print(contador);
//             }),
//       ),
//     );
//   }
// }
//*-*-Clase pasada-*-*

//--IOS
// import 'package:flutter/cupertino.dart';

// void main() => runApp(const MyApp());

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return const CupertinoApp(
//       title: 'Cupertino App',
//       home: CupertinoPageScaffold(
//         navigationBar: CupertinoNavigationBar(
//           middle: Text('Cupertino App Bar'),
//         ),
//         child: Center(
//           child: Text('Hello World'),
//         ),
//       ),
//     );
//   }
// }