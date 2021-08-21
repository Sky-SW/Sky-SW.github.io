import 'package:Drinkeep/providers/playerGame.dart';
import 'package:Drinkeep/screens/game/firstMode.dart';
import 'package:Drinkeep/screens/game/fiveMode.dart';
import 'package:Drinkeep/screens/game/fourMode.dart';
import 'package:Drinkeep/screens/game/sixMode.dart';
import 'package:Drinkeep/screens/player.dart';
import 'package:Drinkeep/widgets/background.dart';
import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:Drinkeep/screens/game/secondMode.dart';
import 'package:Drinkeep/screens/game/thirdMode.dart';

// screen view
class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      extendBodyBehindAppBar: true,
      appBar: DrinkeepAppBar(),
      body: Categories(),
      bottomNavigationBar: BottomCategories(),
    );
  }
}

// app bar
class DrinkeepAppBar extends StatelessWidget implements PreferredSizeWidget {
  const DrinkeepAppBar({Key? key}) : super(key: key);

  // resize height app bar
  @override
  Size get preferredSize => const Size.fromHeight(65);

  // app bar widget
  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      leading: IconButton(
        icon: const Icon(
          Icons.arrow_back,
          color: Colors.grey,
          size: 25,
        ),
        onPressed: () {
          Navigator.of(context).push(PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) =>
                const PlayerScreen(),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
              const begin = Offset(-1, 0.0);
              const end = Offset.zero;
              const curve = Curves.ease;

              var tween =
                  Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
              return SlideTransition(
                position: animation.drive(tween),
                child: child,
              );
            },
          ));
        },
      ),
      backgroundColor: Colors.white.withOpacity(0),
    );
  }
}

// screen widget content
class Categories extends StatefulWidget {
  const Categories({Key? key}) : super(key: key);

  @override
  _CategoriesState createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {
  // variables
  late bool darkmode;
  dynamic savedThemeMode;
  dynamic buttonColor;

  // initiate functions
  @override
  void initState() {
    super.initState();

    // set device orientation
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    // get current theme
    getCurrentTheme();
  }

  // current theme setting
  Future getCurrentTheme() async {
    // get current theme
    savedThemeMode = await AdaptiveTheme.getThemeMode();

    // verify theme selected
    if (savedThemeMode.toString() == 'AdaptiveThemeMode.dark') {
      setState(() {
        darkmode = true;
        buttonColor = const Color.fromRGBO(255, 21, 244, .5);
      });
    } else {
      setState(() {
        darkmode = false;
        buttonColor = const Color.fromRGBO(86, 40, 237, .5);
      });
    }
  }

// screen content
  @override
  Widget build(BuildContext context) {
    return Background(
      child: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.only(
            top: 100,
          ),
          child: Container(
            margin: const EdgeInsets.only(
              left: 42,
              right: 42,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).push(PageRouteBuilder(
                      pageBuilder: (context, animation, secondaryAnimation) =>
                          const FirstModeScreen(),
                      transitionsBuilder:
                          (context, animation, secondaryAnimation, child) {
                        const begin = Offset(1.0, 0.0);
                        const end = Offset.zero;
                        const curve = Curves.ease;

                        var tween = Tween(begin: begin, end: end)
                            .chain(CurveTween(curve: curve));
                        return SlideTransition(
                          position: animation.drive(tween),
                          child: child,
                        );
                      },
                    ));
                  },
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.only(left: 0, right: 0),
                    primary: buttonColor,
                  ),
                  child: ListTile(
                    leading: Container(
                      width: 50,
                      alignment: Alignment.center,
                      margin: const EdgeInsets.only(right: 20),
                      child: const Icon(
                        Icons.local_bar_rounded,
                        size: 70,
                        color: Colors.white,
                      ),
                    ),
                    title: const Text(
                      'Apero soft',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: const Text(
                      'Un apéro entre amis ? \nCe mode de jeu est parfait pour apprendre à mieux se connaître !',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).push(PageRouteBuilder(
                      pageBuilder: (context, animation, secondaryAnimation) =>
                          const SecondModeScreen(),
                      transitionsBuilder:
                          (context, animation, secondaryAnimation, child) {
                        const begin = Offset(1.0, 0.0);
                        const end = Offset.zero;
                        const curve = Curves.ease;

                        var tween = Tween(begin: begin, end: end)
                            .chain(CurveTween(curve: curve));
                        return SlideTransition(
                          position: animation.drive(tween),
                          child: child,
                        );
                      },
                    ));
                  },
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.only(left: 0, right: 0),
                    primary: buttonColor,
                  ),
                  child: ListTile(
                    leading: Container(
                      width: 50,
                      alignment: Alignment.center,
                      margin: const EdgeInsets.only(right: 20),
                      child: const Icon(
                        Icons.sentiment_very_satisfied_rounded,
                        size: 70,
                        color: Colors.white,
                      ),
                    ),
                    title: const Text(
                      'Les attaqués',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: const Text(
                      'Plus de secret ? \nCe mode de jeu est parfait pour les amis qui se connaissent déjà !',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).push(PageRouteBuilder(
                      pageBuilder: (context, animation, secondaryAnimation) =>
                          const ThirdModeScreen(),
                      transitionsBuilder:
                          (context, animation, secondaryAnimation, child) {
                        const begin = Offset(1.0, 0.0);
                        const end = Offset.zero;
                        const curve = Curves.ease;

                        var tween = Tween(begin: begin, end: end)
                            .chain(CurveTween(curve: curve));
                        return SlideTransition(
                          position: animation.drive(tween),
                          child: child,
                        );
                      },
                    ));
                  },
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.only(left: 0, right: 0),
                    primary: buttonColor,
                  ),
                  child: ListTile(
                    leading: Container(
                      width: 50,
                      alignment: Alignment.center,
                      margin: const EdgeInsets.only(right: 20),
                      child: const Icon(
                        Icons.local_fire_department,
                        size: 70,
                        color: Colors.white,
                      ),
                    ),
                    title: const Text(
                      'En chaleur',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: const Text(
                      'Tu t\'enflammes ?\nCe mode de jeu est parfait pour ne pas rester seul ce soir ou cette nuit !',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).push(PageRouteBuilder(
                      pageBuilder: (context, animation, secondaryAnimation) =>
                          const FourModeScreen(),
                      transitionsBuilder:
                          (context, animation, secondaryAnimation, child) {
                        const begin = Offset(1.0, 0.0);
                        const end = Offset.zero;
                        const curve = Curves.ease;

                        var tween = Tween(begin: begin, end: end)
                            .chain(CurveTween(curve: curve));
                        return SlideTransition(
                          position: animation.drive(tween),
                          child: child,
                        );
                      },
                    ));
                  },
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.only(left: 0, right: 0),
                    primary: buttonColor,
                  ),
                  child: ListTile(
                    leading: Container(
                      width: 50,
                      alignment: Alignment.center,
                      margin: const EdgeInsets.only(right: 20),
                      child: const Icon(
                        Icons.trending_down,
                        size: 70,
                        color: Colors.white,
                      ),
                    ),
                    title: const Text(
                      'Mort subite',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: const Text(
                      'Encore soif ?\nCe mode de jeu est parfait pour ceux qui souhaitent se coucher !',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).push(PageRouteBuilder(
                      pageBuilder: (context, animation, secondaryAnimation) =>
                          const FiveModeScreen(),
                      transitionsBuilder:
                          (context, animation, secondaryAnimation, child) {
                        const begin = Offset(1.0, 0.0);
                        const end = Offset.zero;
                        const curve = Curves.ease;

                        var tween = Tween(begin: begin, end: end)
                            .chain(CurveTween(curve: curve));
                        return SlideTransition(
                          position: animation.drive(tween),
                          child: child,
                        );
                      },
                    ));
                  },
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.only(left: 0, right: 0),
                    primary: buttonColor,
                  ),
                  child: ListTile(
                    leading: Container(
                      width: 50,
                      alignment: Alignment.center,
                      margin: const EdgeInsets.only(right: 20),
                      child: const Icon(
                        Icons.theater_comedy,
                        size: 70,
                        color: Colors.white,
                      ),
                    ),
                    title: const Text(
                      'Fait / Pas fait',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: const Text(
                      'Envie d\'en savoir plus ? \nCe mode de jeu est parfait pour découvrir les petits secrets inavoués!',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).push(PageRouteBuilder(
                      pageBuilder: (context, animation, secondaryAnimation) =>
                          const SixModeScreen(),
                      transitionsBuilder:
                          (context, animation, secondaryAnimation, child) {
                        const begin = Offset(1.0, 0.0);
                        const end = Offset.zero;
                        const curve = Curves.ease;

                        var tween = Tween(begin: begin, end: end)
                            .chain(CurveTween(curve: curve));
                        return SlideTransition(
                          position: animation.drive(tween),
                          child: child,
                        );
                      },
                    ));
                  },
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.only(left: 0, right: 0),
                    primary: buttonColor,
                  ),
                  child: ListTile(
                    leading: Container(
                      width: 50,
                      alignment: Alignment.center,
                      margin: const EdgeInsets.only(right: 20),
                      child: const Icon(
                        Icons.contact_support,
                        size: 70,
                        color: Colors.white,
                      ),
                    ),
                    title: const Text(
                      'Tu trinques',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: const Text(
                      'Besoin de trancher ? \nCe mode de jeu est parfait pour désigner une personne au hasard !',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// show players on bottom screen
class BottomCategories extends StatefulWidget {
  const BottomCategories({Key? key}) : super(key: key);

  @override
  _BottomCategoriesState createState() => _BottomCategoriesState();
}

class _BottomCategoriesState extends State<BottomCategories> {
  // variables
  late bool darkmode;
  dynamic savedThemeMode;
  late String imgAdress;
  dynamic buttonColor;

  // initial state function
  @override
  void initState() {
    super.initState();
    getCurrentTheme();
  }

  // function for get theme used and set necessary variables
  Future getCurrentTheme() async {
    // get current theme
    savedThemeMode = await AdaptiveTheme.getThemeMode();

    // verify theme selected
    if (savedThemeMode.toString() == 'AdaptiveThemeMode.dark') {
      setState(() {
        darkmode = true;
        imgAdress = 'assets/iconApp/drinkeep_dark.png';
        buttonColor = const Color.fromRGBO(255, 21, 244, .5);
      });
    } else {
      setState(() {
        darkmode = false;
        imgAdress = 'assets/iconApp/drinkeep_light.png';
        buttonColor = const Color.fromRGBO(86, 40, 237, .5);
      });
    }
  }

  // widget content
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: buttonColor,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      padding: const EdgeInsets.only(
        top: 20,
        bottom: 25,
      ),
      margin: const EdgeInsets.only(
        top: 10,
      ),
      child: Text(
        playerList.length.toString() + ' Joueurs',
        textAlign: TextAlign.center,
        style: GoogleFonts.comfortaa(
          color: Colors.white,
          fontSize: 16,
          fontWeight: FontWeight.w900,
        ),
      ),
    );
  }
}
