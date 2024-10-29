import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:pmsn2024b/firebase_options.dart';
import 'package:pmsn2024b/provider/test_provider.dart';
import 'package:pmsn2024b/screens/detail_popular_screen.dart';
import 'package:pmsn2024b/screens/home_screen.dart';
import 'package:pmsn2024b/screens/login_screen.dart';
import 'package:pmsn2024b/screens/movies_screen.dart';
import 'package:pmsn2024b/screens/popular_screen.dart';
import 'package:pmsn2024b/screens/profile_screen.dart';
import 'package:pmsn2024b/screens/register_screen.dart';
import 'package:pmsn2024b/settings/global_values.dart';
import 'package:pmsn2024b/settings/theme_settings.dart';
import 'package:provider/provider.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp( const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: GlobalValues.banThemeDark,
        builder: (context, value, widget) {
          return ChangeNotifierProvider(
            create: (context) => TestProvider(),
            child: MaterialApp(
              theme: value
                  ? ThemeSettings.darkTheme()
                  : ThemeSettings.lightTheme(context),
              title: 'Material App',
              home: const LoginScreen(),
              routes: {
                "/login": (context) => const LoginScreen(),
                "/register": (context) => const RegisterScreen(),
                "/profile": (context) => const ProfileScreen(),
                "/home": (context) => const HomeScreen(),
                "/db": (context) => const MoviesScreen(),
                "/popular": (context) => const PopularScreen(),
                "/detail": (context) => const DetailPopularScreen()
              },
              debugShowCheckedModeBanner: false,
            ),
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