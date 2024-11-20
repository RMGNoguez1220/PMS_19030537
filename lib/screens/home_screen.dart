import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_expandable_fab/flutter_expandable_fab.dart';
import 'package:pmsn2024b/game.dart';
import 'package:pmsn2024b/gameCard.dart';
import 'package:pmsn2024b/provider/test_provider.dart';
import 'package:pmsn2024b/screens/profile_screen.dart';
import 'package:pmsn2024b/settings/colors_settings.dart';
import 'package:provider/provider.dart';
import 'package:pmsn2024b/settings/theme_notifier.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key, required this.themeNotifier});
  final ThemeNotifier themeNotifier;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  final ThemeNotifier themeNotifier = ThemeNotifier();
  late PageController pageController;
  double pageOffset = 0;
  late AnimationController controller;
  late Animation animation;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 800));
    animation = CurvedAnimation(parent: controller, curve: Curves.easeOutBack);
    pageController = PageController(viewportFraction: .8);
    pageController.addListener(() {
      setState(() {
        pageOffset = pageController.page!;
      });
    });
  }

  @override
  void dispose() {
    controller.dispose();
    pageController.dispose();
    super.dispose();
  }

  int index = 0;
  final _key = GlobalKey<ExpandableFabState>();

  @override
  Widget build(BuildContext context) {
    final testProvider = Provider.of<TestProvider>(context);
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Animate(
          effects: const [
            ShimmerEffect(colors: [
              Color.fromARGB(255, 255, 255, 255),
              Color.fromARGB(255, 92, 121, 76)
            ], duration: Duration(seconds: 5))
          ],
          child: Text(
            'BIENVENIDO',
            style: TextStyle(
                color: Theme.of(context).colorScheme.onSurface,
                fontWeight: FontWeight.bold),
          ),
        ),
        leading: Builder(builder: (context) {
          return AnimatedBuilder(
              animation: animation,
              builder: (context, snapshot) {
                return Transform.translate(
                  offset: const Offset(0, 0),
                  child: IconButton(
                    icon: const Icon(
                      Icons.menu,
                      color: Colors.white,
                    ),
                    tooltip: 'Menu',
                    onPressed: () {
                      Scaffold.of(context).openDrawer();
                    },
                  ),
                );
              });
        }),
        backgroundColor: ColorsSettings.bottomColor,
        actions: [
          GestureDetector(
            onTap: () {},
            child: MouseRegion(
              cursor: SystemMouseCursors.click,
              child: AnimatedBuilder(
                animation: animation,
                builder: (context, snapshot) {
                  return Transform.translate(
                    offset: Offset(200.0 * (1 - animation.value), 0),
                    child: Image.asset(
                      'assets/game_icon.png',
                      color: Colors.white,
                    ),
                  );
                },
              ),
            ),
          ),
        ],
        centerTitle: true,
      ),
      body: Builder(
        builder: (context) {
          switch (index) {
            case 1:
              return const ProfileScreen();
            default:
              return SafeArea(
                child: Stack(
                  children: <Widget>[
                    buildLogo(size),
                    buildPager(size),
                    buildPageIndecator()
                  ],
                ),
              );
          }
        },
      ),
      // endDrawer: Drawer(),
      drawer: myDrawer(testProvider),
      bottomNavigationBar: ConvexAppBar(
        backgroundColor: ColorsSettings.bottomColor,
        items: const [
          TabItem(icon: Icons.home, title: 'Home'),
          TabItem(icon: Icons.person, title: 'Profile'),
          TabItem(icon: Icons.exit_to_app, title: 'Exit'),
        ],
        onTap: (int i) => setState(() {
          //print(i);
          if (i == 2) {
            // El índice 2 corresponde a la opción "Exit"
            Navigator.pushReplacementNamed(context, '/login');
          } else {
            setState(() {
              index = i;
            });
          }
        }),
      ),
      floatingActionButtonLocation: ExpandableFab.location,
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 35),
        child: ExpandableFab(
          // openButtonBuilder: RotateFloatingActionButtonBuilder(),
          type: ExpandableFabType.up,
          distance: 50,
          pos: ExpandableFabPos.left,
          children: [
            FloatingActionButton.small(
              heroTag: "btn1",
              backgroundColor: ColorsSettings.yellowColor,
              onPressed: () {
                widget.themeNotifier.setTheme('light');
              },
              child: Icon(Icons.wb_sunny, color: ColorsSettings.navColor),
            ),
            FloatingActionButton.small(
              heroTag: "btn2",
              backgroundColor: Colors.grey,
              onPressed: () {
                widget.themeNotifier.setTheme('dark');
              },
              child:
                  const Icon(Icons.dark_mode_rounded, color: Colors.blueGrey),
            ),
            FloatingActionButton.small(
              heroTag: "btn3",
              onPressed: () {
                widget.themeNotifier.setTheme('custom');
              },
              child:
                  Icon(Icons.color_lens, color: ColorsSettings.btnLoginColor),
            )
          ],
        ),
      ),
    );
  }

  Widget buildLogo(Size size) {
    return Positioned(
      top: 10,
      right: size.width / 2 - 25,
      child: AnimatedBuilder(
          animation: animation,
          builder: (context, snapshot) {
            return Transform(
              transform: Matrix4.identity()
                ..translate(0.0, size.height / 2 * (1 - animation.value))
                ..scale(1 + (1 - animation.value)),
              origin: const Offset(25, 25),
              child: InkWell(
                onTap: () => controller.isCompleted
                    ? controller.reverse()
                    : controller.forward(),
                child: Image.asset(
                  'assets/superintendente.png',
                  width: 50,
                  height: 50,
                ),
              ),
            );
          }),
    );
  }

  Widget buildPager(Size size) {
    return Container(
      margin: const EdgeInsets.only(top: 70),
      height: size.height - 50,
      child: AnimatedBuilder(
          animation: animation,
          builder: (context, snapshot) {
            return Transform.translate(
              offset: Offset(400.0 * (1 - animation.value), 0),
              child: PageView.builder(
                controller: pageController,
                itemCount: getGames().length,
                itemBuilder: (context, index) =>
                    gameCard(getGames()[index], pageOffset, index),
              ),
            );
          }),
    );
  }

  List<Game> getGames() {
    List<Game> list = [];
    list.add(Game(
        'Halo ',
        '1',
        'assets/AnilloBackground.jpg',
        'assets/anillo.png',
        'assets/banshee.png',
        'assets/anillo.png',
        'assets/MasterChief.png',
        'Es un supersoldado, conocido por su armadura Mjolnir y su lucha contra alienígenas para proteger a la humanidad.',
        Colors.blueGrey,
        Colors.blueGrey));
    list.add(Game(
        'Gears ',
        '2',
        'assets/GearsBackground.jpg',
        'assets/gear.png',
        'assets/LancerRetro.png',
        'assets/gear.png',
        'assets/MarcusFenix.png',
        'Es un soldado rudo y veterano que lidera la lucha contra los Locust, una raza alienígena que amenaza a la humanidad.',
        Colors.red,
        const Color.fromARGB(255, 175, 28, 28)));
    return list;
  }

  Widget buildPageIndecator() {
    return AnimatedBuilder(
        animation: controller,
        builder: (context, snapshot) {
          return Positioned(
            bottom: 20,
            left: 4,
            child: Opacity(
              opacity: controller.value,
              child: Row(
                children: List.generate(
                    getGames().length, (index) => buildContainer(index)),
              ),
            ),
          );
        });
  }

  Widget buildContainer(int index) {
    double animate = pageOffset - index;
    double size = 10;
    animate = animate.abs();
    Color? color = Colors.grey;
    if (animate <= 1 && animate >= 0) {
      size = 10 + 10 * (1 - animate);
      color = ColorTween(begin: Colors.grey, end: ColorsSettings.bottomColor)
          .transform((1 - animate));
    }

    return Container(
      margin: const EdgeInsets.all(4),
      height: size,
      width: size,
      decoration:
          BoxDecoration(color: color, borderRadius: BorderRadius.circular(20)),
    );
  }

  Widget myDrawer(TestProvider testProvider) {
    return Drawer(
      child: ListView(
        children: [
          Container(
            color: ColorsSettings.bottomColor,
            height: 40,
            child: Stack(
              children: [
                Positioned(
                  top: 0,
                  right: 0,
                  child: IconButton(
                    icon: const Icon(Icons.close, color: Colors.white),
                    onPressed: () {
                      Navigator.of(context).pop(); // Cierra el Drawer
                    },
                  ),
                ),
                const Center(
                  child: Text(
                    'Menu',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                    ),
                  ),
                ),
              ],
            ),
          ),
          UserAccountsDrawerHeader(
            currentAccountPicture: const CircleAvatar(
              backgroundImage: NetworkImage(
                  'https://media.licdn.com/dms/image/D5603AQEvFY-0hKRnJQ/profile-displayphoto-shrink_200_200/0/1666403772623?e=2147483647&v=beta&t=TQe6lICPdQYZ5ZsfBEtnnTREGE3eQ-Zo5DBXPEfBm5A'),
            ),
            accountName: Text(
              testProvider.name,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            accountEmail: Text(
              '19030537@itcelaya.edu.mx',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            decoration: BoxDecoration(color: ColorsSettings.navColor),
          ),
          ListTile(
            onTap: () {
              // Acción cuando se presiona el item
              Navigator.pushNamed(context, '/db');
            },
            title: const Text(
              'Movie List',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: const Text('DatabaseMovies'),
            leading: const Icon(Icons.movie),
            trailing: const Icon(Icons.chevron_right),
          ),
          ListTile(
            onTap: () => Navigator.pushNamed(context, '/popular'),
            title: const Text(
              'Popular Movies',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: const Text('API of movies'),
            leading: const Icon(Icons.movie),
            trailing: const Icon(Icons.chevron_right),
          ),
          ListTile(
            onTap: () => Navigator.pushNamed(context, '/moviesfirebase'),
            title: const Text(
              'Movies firebase',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: const Text('Firebase'),
            leading: const Icon(Icons.movie),
            trailing: const Icon(Icons.chevron_right),
          ),
          ListTile(
            onTap: () => Navigator.pushNamed(context, '/maps'),
            title: const Text(
              'Google Maps',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: const Text('Test google maps'),
            leading: const Icon(Icons.maps_home_work),
            trailing: const Icon(Icons.chevron_right),
          ),
          ListTile(
            onTap: () => Navigator.pushNamed(context, '/preferencestheme'),
            title: const Text(
              'Temas',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: const Text('Configuración temas'),
            leading: const Icon(Icons.color_lens),
            trailing: const Icon(Icons.chevron_right),
          ),
        ],
      ),
    );
  }
}
