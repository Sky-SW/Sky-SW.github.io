// ignore_for_file: file_names
import 'dart:math';
import 'package:Drinkeep/providers/endGame.dart';
import 'package:Drinkeep/providers/playerGame.dart';
import 'package:Drinkeep/providers/randomGame.dart';
import 'package:Drinkeep/screens/categories.dart';
import 'package:Drinkeep/screens/game/endGame.dart';
import 'package:Drinkeep/widgets/animation.dart';
import 'package:Drinkeep/widgets/background.dart';
import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

// screen view
class FiveModeScreen extends StatelessWidget {
  const FiveModeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      extendBodyBehindAppBar: true,
      appBar: DrinkeepAppBar(),
      body: FiveModeGame(),
      bottomNavigationBar: BottomButton(),
    );
  }
}

// app bar
class DrinkeepAppBar extends StatefulWidget implements PreferredSizeWidget {
  const DrinkeepAppBar({Key? key}) : super(key: key);

  // resize height app bar
  @override
  Size get preferredSize => const Size.fromHeight(65);

  @override
  _DrinkeepAppBarState createState() => _DrinkeepAppBarState();
}

class _DrinkeepAppBarState extends State<DrinkeepAppBar> {
  // variables
  late bool darkmode;
  dynamic savedThemeMode;
  dynamic imgAdress;

  // initial state function
  @override
  void initState() {
    super.initState();
    // get current theme
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
        imgAdress = 'assets/img/dark_help.jpg';
      });
    } else {
      setState(() {
        darkmode = false;
        imgAdress = 'assets/img/light_help.jpg';
      });
    }
  }

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
                const CategoriesScreen(),
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
      actions: [
        IconButton(
          onPressed: () {
            showBarModalBottomSheet(
                context: context, builder: (context) => Image.asset(imgAdress));
          },
          tooltip: 'Afficher l\'aide',
          splashRadius: 1,
          icon: const Icon(
            Icons.contact_support_rounded,
            color: Colors.grey,
            size: 25,
          ),
        )
      ],
      backgroundColor: Colors.white.withOpacity(0),
    );
  }
}

// global variable
List fiveModeContent = [];

// screen widget content
class FiveModeGame extends StatefulWidget {
  const FiveModeGame({Key? key}) : super(key: key);

  @override
  _FiveModeGameState createState() => _FiveModeGameState();
}

class _FiveModeGameState extends State<FiveModeGame> {
  // variables
  late bool darkmode;
  dynamic savedThemeMode;
  dynamic color;
  dynamic textColor;
  // ignore: prefer_typing_uninitialized_variables
  var tempArray;

  // initiate functions
  @override
  void initState() {
    super.initState();

    // set device orientation
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);

    /// THEMES
    ///
    /// DONE / NOT DONE : All players play
    ///

    // list five mode data content
    List fiveModeContentRecovery = [
      {
        "title": "DONE / NOT DONE",
        "text": "Conduire bourré(e)"
                ".\n\nTous ceux " +
            randomGeneralDoneOrNotDone() +
            randomGulp(),
      },
      {
        "title": "DONE / NOT DONE",
        "text": "Espionner son/sa voisin(e)"
                ".\n\nTous ceux " +
            randomGeneralDoneOrNotDone() +
            randomGulp(),
      },
      {
        "title": "DONE / NOT DONE",
        "text": "Coucher avec quelqu'un déjà en couple"
                ".\n\nTous ceux " +
            randomGeneralDoneOrNotDone() +
            randomGulp(),
      },
      {
        "title": "DONE / NOT DONE",
        "text": "Coucher ailleurs que dans un lit"
                ".\n\nTous ceux " +
            randomGeneralDoneOrNotDone() +
            randomGulp(),
      },
      {
        "title": "DONE / NOT DONE",
        "text": "Mentir au cours de ce jeu"
                ".\n\nTous ceux " +
            randomGeneralDoneOrNotDone() +
            randomGulp(),
      },
      {
        "title": "DONE / NOT DONE",
        "text": "Chanter sous la douche"
                ".\n\nTous ceux " +
            randomGeneralDoneOrNotDone() +
            randomGulp(),
      },
      {
        "title": "DONE / NOT DONE",
        "text": "Confondre un homme et une femme"
                ".\n\nTous ceux " +
            randomGeneralDoneOrNotDone() +
            randomGulp(),
      },
      {
        "title": "DONE / NOT DONE",
        "text": "Se pisser dessus"
                ".\n\nTous ceux " +
            randomGeneralDoneOrNotDone() +
            randomGulp(),
      },
      {
        "title": "DONE / NOT DONE",
        "text": "Tomber en publique"
                ".\n\nTous ceux " +
            randomGeneralDoneOrNotDone() +
            randomGulp(),
      },
      {
        "title": "DONE / NOT DONE",
        "text": "Envoyer un message personnel à la mauvaise personne"
                ".\n\nTous ceux " +
            randomGeneralDoneOrNotDone() +
            randomGulp(),
      },
      {
        "title": "DONE / NOT DONE",
        "text": "Mentir au travail pour être en repos"
                ".\n\nTous ceux " +
            randomGeneralDoneOrNotDone() +
            randomGulp(),
      },
      {
        "title": "DONE / NOT DONE",
        "text": "Regretter de jouer à ce jeu"
                ".\n\nTous ceux " +
            randomGeneralDoneOrNotDone() +
            randomGulp(),
      },
      {
        "title": "DONE / NOT DONE",
        "text": "Se faire arreter"
                ".\n\nTous ceux " +
            randomGeneralDoneOrNotDone() +
            randomGulp(),
      },
      {
        "title": "DONE / NOT DONE",
        "text": "Consommer de la drogue"
                ".\n\nTous ceux " +
            randomGeneralDoneOrNotDone() +
            randomGulp(),
      },
      {
        "title": "DONE / NOT DONE",
        "text": "Recaler d'une boite de nuit"
                ".\n\nTous ceux " +
            randomGeneralDoneOrNotDone() +
            randomGulp(),
      },
      {
        "title": "DONE / NOT DONE",
        "text": "Espionner sur les réseaux"
                ".\n\nTous ceux " +
            randomGeneralDoneOrNotDone() +
            randomGulp(),
      },
      {
        "title": "DONE / NOT DONE",
        "text": "Poser un lapin à un rendez-vous"
                ".\n\nTous ceux " +
            randomGeneralDoneOrNotDone() +
            randomGulp(),
      },
      {
        "title": "DONE / NOT DONE",
        "text": "Envoyer un sexto"
                ".\n\nTous ceux " +
            randomGeneralDoneOrNotDone() +
            randomGulp(),
      },
      {
        "title": "DONE / NOT DONE",
        "text": "Boire de l'alcool"
                ".\n\nTous ceux " +
            randomGeneralDoneOrNotDone() +
            randomGulp(),
      },
      {
        "title": "DONE / NOT DONE",
        "text": "Pleurer devant un film"
                ".\n\nTous ceux " +
            randomGeneralDoneOrNotDone() +
            randomGulp(),
      },
      {
        "title": "DONE / NOT DONE",
        "text": player_1() +
            "\n\nAs-tu déjà volé un objet ?"
                "\nSi tu " +
            randomDoneOrNotDone() +
            randomGulp(),
      },
      {
        "title": "DONE / NOT DONE",
        "text": player_1() +
            "\n\nAs-tu déjà eu un accident ?"
                "\nSi tu " +
            randomDoneOrNotDone() +
            randomGulp(),
      },
      {
        "title": "DONE / NOT DONE",
        "text": player_1() +
            "\n\nÀ tu déjà étais infidèle ?"
                "\nSi tu " +
            randomDoneOrNotDone() +
            randomGulp(),
      },
      {
        "title": "DONE / NOT DONE",
        "text": player_1() +
            "\n\nAs-tu déjà regardé du porno ?"
                "\nSi tu " +
            randomDoneOrNotDone() +
            randomGulp(),
      },
      {
        "title": "DONE / NOT DONE",
        "text": player_1() +
            "\n\nAs-tu déjà fait un strip-tease"
                "\nSi tu " +
            randomDoneOrNotDone() +
            randomGulp(),
      },
      {
        "title": "DONE / NOT DONE",
        "text": player_1() +
            "\n\nAs-tu déjà eu besoin de t'épiler l'anus ?"
                "\nSi tu " +
            randomDoneOrNotDone() +
            randomGulp(),
      },
      {
        "title": "DONE / NOT DONE",
        "text": player_1() +
            "\n\nÀ tu déjà envoyer une photo de toi photoshopé ?"
                "\nSi tu " +
            randomDoneOrNotDone() +
            randomGulp(),
      },
      {
        "title": "DONE / NOT DONE",
        "text": player_1() +
            "\n\nAs-tu déjà dansé en pleine rue ?"
                "\nSi tu " +
            randomDoneOrNotDone() +
            randomGulp(),
      },
      {
        "title": "DONE / NOT DONE",
        "text": player_1() +
            "\n\nAs-tu déjà raté un train ?"
                "\nSi tu " +
            randomDoneOrNotDone() +
            randomGulp(),
      },
      {
        "title": "DONE / NOT DONE",
        "text": player_1() +
            "\n\nÀ tu déjà fais la bouche cul-de-poule ?"
                "\nSi tu " +
            randomDoneOrNotDone() +
            randomGulp(),
      },
      {
        "title": "DONE / NOT DONE",
        "text": player_1() +
            "\n\nAs-tu déjà eu un réveil à côté d'un(e) inconnu(e) ?"
                "\nSi tu " +
            randomDoneOrNotDone() +
            randomGulp(),
      },
      {
        "title": "DONE / NOT DONE",
        "text": player_1() +
            "\n\nAs-tu déjà eu une contravention ?"
                "\nSi tu " +
            randomDoneOrNotDone() +
            randomGulp(),
      },
      {
        "title": "DONE / NOT DONE",
        "text": player_1() +
            "\n\nAs-tu déjà oublié de porter un sous-vêtement ?"
                "\nSi tu " +
            randomDoneOrNotDone() +
            randomGulp(),
      },
      {
        "title": "DONE / NOT DONE",
        "text": player_1() +
            "\n\nAs-tu déjà regardé les émissions de téléréalité  ?"
                "\nSi tu " +
            randomDoneOrNotDone() +
            randomGulp(),
      },
      {
        "title": "DONE / NOT DONE",
        "text": player_1() +
            "\n\nÀ tu déjà été en colles/permanence ?"
                "\nSi tu " +
            randomDoneOrNotDone() +
            randomGulp(),
      },
      {
        "title": "DONE / NOT DONE",
        "text": player_1() +
            "\n\nÀ tu déjà été viré ?"
                "\nSi tu " +
            randomDoneOrNotDone() +
            randomGulp(),
      },
      {
        "title": "DONE / NOT DONE",
        "text": player_1() +
            "\n\nÀ tu déjà repasser ton permis ?"
                "\nSi tu " +
            randomDoneOrNotDone() +
            randomGulp(),
      },
      {
        "title": "DONE / NOT DONE",
        "text": player_1() +
            "\n\nÀ tu déjà fuis à un rencard ?"
                "\nSi tu " +
            randomDoneOrNotDone() +
            randomGulp(),
      },
      {
        "title": "DONE / NOT DONE",
        "text": player_1() +
            "\n\nAs-tu déjà fait du sport ?"
                "\nSi tu " +
            randomDoneOrNotDone() +
            randomGulp(),
      },
      {
        "title": "DONE / NOT DONE",
        "text": player_1() +
            "\n\nÀ tu déjà frapper un(e) ami(e) ?"
                "\nSi tu " +
            randomDoneOrNotDone() +
            randomGulp(),
      },
    ];

    // get current theme
    getCurrentTheme();

    // reset five mode array
    fiveModeContent.clear();

    // reset end game array
    endGame.clear();

    // add data in fiveModeContent list
    fiveModeContent.addAll(fiveModeContentRecovery);

    // get random data in array
    tempArray = fiveModeContent[Random().nextInt(fiveModeContent.length)];
  }

  // when leave this screen
  @override
  void dispose() {
    super.dispose();
    // stop the orientation landscape
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
  }

  // change data screen
  void changeData() {
    setState(() {
      // add element in end game array
      endGame.add(tempArray);

      // remove item in list
      fiveModeContent.remove(tempArray);

      // get a new random item in array
      tempArray = fiveModeContent[Random().nextInt(fiveModeContent.length)];

      // reject "TIME" after more 25 round
      if (tempArray['title'] == 'TIME' && endGame.length > 24) {
        // remove item in list
        fiveModeContent.remove(tempArray);

        // get a new random item in array
        tempArray = fiveModeContent[Random().nextInt(fiveModeContent.length)];
      }

      // if have new action created
      for (var newAction in fiveModeContent) {
        if (endGame.length >= 30 && newAction['title'] != 'NEW') {
          // change screen
          Navigator.of(context).push(PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) =>
                const EndGame(),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
              const begin = Offset(1.0, 0.0);
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
        } else if (newAction['title'] == 'NEW' && endGame.length >= 25) {
          tempArray = newAction;
        }
      }
    });
  }

  // current theme setting
  Future getCurrentTheme() async {
    // get current theme
    savedThemeMode = await AdaptiveTheme.getThemeMode();

    // verify theme selected
    if (savedThemeMode.toString() == 'AdaptiveThemeMode.dark') {
      setState(() {
        darkmode = true;
        color = const Color.fromRGBO(255, 21, 244, 1);
        textColor = Colors.white;
      });
    } else {
      setState(() {
        darkmode = false;
        color = const Color.fromRGBO(86, 40, 237, 1);
        textColor = Colors.black;
      });
    }
  }

  // screen widget
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () => changeData(),
      child: Background(
        child: Container(
          height: MediaQuery.of(context).size.height,
          alignment: Alignment.center,
          margin: const EdgeInsets.only(
            left: 30,
            right: 30,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                children: [
                  DelayedAnimation(
                    delay: 500,
                    child: TextButton(
                      onPressed: () => changeData(),
                      style: ButtonStyle(
                        overlayColor:
                            MaterialStateProperty.all(Colors.transparent),
                      ),
                      child: Text(
                        tempArray['title'],
                        textAlign: TextAlign.center,
                        style: GoogleFonts.balooChettan(
                          color: color,
                          fontSize: 50,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  DelayedAnimation(
                    delay: 500,
                    child: TextButton(
                      onPressed: () => changeData(),
                      style: ButtonStyle(
                        overlayColor:
                            MaterialStateProperty.all(Colors.transparent),
                      ),
                      child: Text(
                        tempArray['text'],
                        textAlign: TextAlign.center,
                        style: GoogleFonts.comfortaa(
                          color: textColor,
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class BottomButton extends StatefulWidget {
  const BottomButton({Key? key}) : super(key: key);

  @override
  _BottomButtonState createState() => _BottomButtonState();
}

class _BottomButtonState extends State<BottomButton> {
  // variables
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final playerName = TextEditingController();
  final fiveContentNewData = TextEditingController();
  late bool darkmode;
  dynamic savedThemeMode;
  dynamic buttonColor;

  // initiate functions
  @override
  void initState() {
    super.initState();
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

  // insert player in dynamic list function
  void addPlayer() {
    // auto refresh
    setState(() {
      // form validation
      if (_formKey.currentState!.validate()) {
        playerList.add(playerName.text);
      }
      // reset text field
      playerName.clear();

      // list five mode data content
      List fiveModeContentRecovery = [
        {
          "title": "DONE / NOT DONE",
          "text": "Conduire bourré(e)"
                  ".\n\nTous ceux " +
              randomGeneralDoneOrNotDone() +
              randomGulp(),
        },
        {
          "title": "DONE / NOT DONE",
          "text": "Espionner son/sa voisin(e)"
                  ".\n\nTous ceux " +
              randomGeneralDoneOrNotDone() +
              randomGulp(),
        },
        {
          "title": "DONE / NOT DONE",
          "text": "Coucher avec quelqu'un déjà en couple"
                  ".\n\nTous ceux " +
              randomGeneralDoneOrNotDone() +
              randomGulp(),
        },
        {
          "title": "DONE / NOT DONE",
          "text": "Coucher ailleurs que dans un lit"
                  ".\n\nTous ceux " +
              randomGeneralDoneOrNotDone() +
              randomGulp(),
        },
        {
          "title": "DONE / NOT DONE",
          "text": "Mentir au cours de ce jeu"
                  ".\n\nTous ceux " +
              randomGeneralDoneOrNotDone() +
              randomGulp(),
        },
        {
          "title": "DONE / NOT DONE",
          "text": "Chanter sous la douche"
                  ".\n\nTous ceux " +
              randomGeneralDoneOrNotDone() +
              randomGulp(),
        },
        {
          "title": "DONE / NOT DONE",
          "text": "Confondre un homme et une femme"
                  ".\n\nTous ceux " +
              randomGeneralDoneOrNotDone() +
              randomGulp(),
        },
        {
          "title": "DONE / NOT DONE",
          "text": "Se pisser dessus"
                  ".\n\nTous ceux " +
              randomGeneralDoneOrNotDone() +
              randomGulp(),
        },
        {
          "title": "DONE / NOT DONE",
          "text": "Tomber en publique"
                  ".\n\nTous ceux " +
              randomGeneralDoneOrNotDone() +
              randomGulp(),
        },
        {
          "title": "DONE / NOT DONE",
          "text": "Envoyer un message personnel à la mauvaise personne"
                  ".\n\nTous ceux " +
              randomGeneralDoneOrNotDone() +
              randomGulp(),
        },
        {
          "title": "DONE / NOT DONE",
          "text": "Mentir au travail pour être en repos"
                  ".\n\nTous ceux " +
              randomGeneralDoneOrNotDone() +
              randomGulp(),
        },
        {
          "title": "DONE / NOT DONE",
          "text": "Regretter de jouer à ce jeu"
                  ".\n\nTous ceux " +
              randomGeneralDoneOrNotDone() +
              randomGulp(),
        },
        {
          "title": "DONE / NOT DONE",
          "text": "Se faire arreter"
                  ".\n\nTous ceux " +
              randomGeneralDoneOrNotDone() +
              randomGulp(),
        },
        {
          "title": "DONE / NOT DONE",
          "text": "Consommer de la drogue"
                  ".\n\nTous ceux " +
              randomGeneralDoneOrNotDone() +
              randomGulp(),
        },
        {
          "title": "DONE / NOT DONE",
          "text": "Recaler d'une boite de nuit"
                  ".\n\nTous ceux " +
              randomGeneralDoneOrNotDone() +
              randomGulp(),
        },
        {
          "title": "DONE / NOT DONE",
          "text": "Espionner sur les réseaux"
                  ".\n\nTous ceux " +
              randomGeneralDoneOrNotDone() +
              randomGulp(),
        },
        {
          "title": "DONE / NOT DONE",
          "text": "Poser un lapin à un rendez-vous"
                  ".\n\nTous ceux " +
              randomGeneralDoneOrNotDone() +
              randomGulp(),
        },
        {
          "title": "DONE / NOT DONE",
          "text": "Envoyer un sexto"
                  ".\n\nTous ceux " +
              randomGeneralDoneOrNotDone() +
              randomGulp(),
        },
        {
          "title": "DONE / NOT DONE",
          "text": "Boire de l'alcool"
                  ".\n\nTous ceux " +
              randomGeneralDoneOrNotDone() +
              randomGulp(),
        },
        {
          "title": "DONE / NOT DONE",
          "text": "Pleurer devant un film"
                  ".\n\nTous ceux " +
              randomGeneralDoneOrNotDone() +
              randomGulp(),
        },
        {
          "title": "DONE / NOT DONE",
          "text": player_1() +
              "\n\nAs-tu déjà volé un objet ?"
                  "\nSi tu " +
              randomDoneOrNotDone() +
              randomGulp(),
        },
        {
          "title": "DONE / NOT DONE",
          "text": player_1() +
              "\n\nAs-tu déjà eu un accident ?"
                  "\nSi tu " +
              randomDoneOrNotDone() +
              randomGulp(),
        },
        {
          "title": "DONE / NOT DONE",
          "text": player_1() +
              "\n\nÀ tu déjà étais infidèle ?"
                  "\nSi tu " +
              randomDoneOrNotDone() +
              randomGulp(),
        },
        {
          "title": "DONE / NOT DONE",
          "text": player_1() +
              "\n\nAs-tu déjà regardé du porno ?"
                  "\nSi tu " +
              randomDoneOrNotDone() +
              randomGulp(),
        },
        {
          "title": "DONE / NOT DONE",
          "text": player_1() +
              "\n\nAs-tu déjà fait un strip-tease"
                  "\nSi tu " +
              randomDoneOrNotDone() +
              randomGulp(),
        },
        {
          "title": "DONE / NOT DONE",
          "text": player_1() +
              "\n\nAs-tu déjà eu besoin de t'épiler l'anus ?"
                  "\nSi tu " +
              randomDoneOrNotDone() +
              randomGulp(),
        },
        {
          "title": "DONE / NOT DONE",
          "text": player_1() +
              "\n\nÀ tu déjà envoyer une photo de toi photoshopé ?"
                  "\nSi tu " +
              randomDoneOrNotDone() +
              randomGulp(),
        },
        {
          "title": "DONE / NOT DONE",
          "text": player_1() +
              "\n\nAs-tu déjà dansé en pleine rue ?"
                  "\nSi tu " +
              randomDoneOrNotDone() +
              randomGulp(),
        },
        {
          "title": "DONE / NOT DONE",
          "text": player_1() +
              "\n\nAs-tu déjà raté un train ?"
                  "\nSi tu " +
              randomDoneOrNotDone() +
              randomGulp(),
        },
        {
          "title": "DONE / NOT DONE",
          "text": player_1() +
              "\n\nÀ tu déjà fais la bouche cul-de-poule ?"
                  "\nSi tu " +
              randomDoneOrNotDone() +
              randomGulp(),
        },
        {
          "title": "DONE / NOT DONE",
          "text": player_1() +
              "\n\nAs-tu déjà eu un réveil à côté d'un(e) inconnu(e) ?"
                  "\nSi tu " +
              randomDoneOrNotDone() +
              randomGulp(),
        },
        {
          "title": "DONE / NOT DONE",
          "text": player_1() +
              "\n\nAs-tu déjà eu une contravention ?"
                  "\nSi tu " +
              randomDoneOrNotDone() +
              randomGulp(),
        },
        {
          "title": "DONE / NOT DONE",
          "text": player_1() +
              "\n\nAs-tu déjà oublié de porter un sous-vêtement ?"
                  "\nSi tu " +
              randomDoneOrNotDone() +
              randomGulp(),
        },
        {
          "title": "DONE / NOT DONE",
          "text": player_1() +
              "\n\nAs-tu déjà regardé les émissions de téléréalité  ?"
                  "\nSi tu " +
              randomDoneOrNotDone() +
              randomGulp(),
        },
        {
          "title": "DONE / NOT DONE",
          "text": player_1() +
              "\n\nÀ tu déjà été en colles/permanence ?"
                  "\nSi tu " +
              randomDoneOrNotDone() +
              randomGulp(),
        },
        {
          "title": "DONE / NOT DONE",
          "text": player_1() +
              "\n\nÀ tu déjà été viré ?"
                  "\nSi tu " +
              randomDoneOrNotDone() +
              randomGulp(),
        },
        {
          "title": "DONE / NOT DONE",
          "text": player_1() +
              "\n\nÀ tu déjà repasser ton permis ?"
                  "\nSi tu " +
              randomDoneOrNotDone() +
              randomGulp(),
        },
        {
          "title": "DONE / NOT DONE",
          "text": player_1() +
              "\n\nÀ tu déjà fuis à un rencard ?"
                  "\nSi tu " +
              randomDoneOrNotDone() +
              randomGulp(),
        },
        {
          "title": "DONE / NOT DONE",
          "text": player_1() +
              "\n\nAs-tu déjà fait du sport ?"
                  "\nSi tu " +
              randomDoneOrNotDone() +
              randomGulp(),
        },
        {
          "title": "DONE / NOT DONE",
          "text": player_1() +
              "\n\nÀ tu déjà frapper un(e) ami(e) ?"
                  "\nSi tu " +
              randomDoneOrNotDone() +
              randomGulp(),
        },
      ];

      // foreach list
      List temp = [];

      // remove element already exist
      for (var element in fiveModeContentRecovery) {
        if (!fiveModeContent.contains(element)) {
          temp.add(element);
        }
      }

      // clear list
      fiveModeContent.clear();

      // add new action in temp array
      fiveModeContent.addAll(temp);
    });
  }

  // insert a new personnal action
  void addAction() {
    setState(() {
      // form validation
      if (_formKey.currentState!.validate()) {
        fiveModeContent.add({
          "title": "NEW",
          "text": player_1() +
              "\n\n " +
              fiveContentNewData.text +
              " ?" +
              "\nSi tu " +
              randomDoneOrNotDone() +
              randomGulp(),
        });
      }
      // reset text field
      fiveContentNewData.clear();
    });
  }

  // widget content
  @override
  Widget build(BuildContext context) {
    return DelayedAnimation(
      delay: 1000,
      child: Container(
        padding: const EdgeInsets.only(
          bottom: 10,
          left: 30,
          right: 30,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              tooltip: 'Ajouter une action',
              splashRadius: 1,
              icon: const Icon(
                Icons.add_task_rounded,
                size: 30,
              ),
              onPressed: () {
                showBarModalBottomSheet(
                  context: context,
                  builder: (context) => Background(
                    child: Container(
                      padding: const EdgeInsets.only(right: 50, left: 50),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Center(
                            child: Text(
                              'Ajouter une action',
                              style: GoogleFonts.balooChettan(
                                fontSize: 20,
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Column(
                            children: [
                              const Icon(
                                Icons.help_outline_outlined,
                                size: 30,
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Text(
                                "Veuillez entrer \nvotre action personnalisée.\n'[Nom aléatoire], votre action.[Si tu as fait/pas fait] [tu prends] [gorgée aléatoire]'",
                                textAlign: TextAlign.center,
                                style: GoogleFonts.comfortaa(
                                  fontSize: 15,
                                ),
                              ),
                              const SizedBox(
                                height: 100,
                              ),
                            ],
                          ),
                          Form(
                            key: _formKey,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                TextFormField(
                                  controller: fiveContentNewData,
                                  maxLength: 50,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'La valeur ne peut être vide';
                                    } else if (value.isNotEmpty) {
                                      if (playerList.contains(value)) {
                                        return 'Personne déjà existante';
                                      }
                                      bool integer =
                                          RegExp(r'^[0-9]+([\\,\\.][0-9]+)?$')
                                              .hasMatch(value);
                                      return integer ? "Numéro interdit" : null;
                                    }
                                  },
                                  decoration: const InputDecoration(
                                    hintText: 'Action',
                                    prefixIcon: Icon(Icons.article_rounded),
                                    contentPadding: EdgeInsets.all(20.0),
                                  ),
                                ),
                                Container(
                                  margin: const EdgeInsets.only(
                                    top: 30,
                                  ),
                                  width: double.infinity,
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      shape: const StadiumBorder(),
                                      padding: const EdgeInsets.all(13),
                                      primary: buttonColor,
                                    ),
                                    onPressed: () => addAction(),
                                    child: Text(
                                      'Ajouter',
                                      style: GoogleFonts.balooChettan(
                                        color: Colors.white,
                                        fontSize: 20,
                                        letterSpacing: 1.5,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
            IconButton(
              tooltip: 'Ajouter une personne',
              splashRadius: 1,
              icon: const Icon(
                Icons.add_reaction_rounded,
                size: 30,
              ),
              onPressed: () {
                showBarModalBottomSheet(
                  context: context,
                  builder: (context) => Background(
                    child: Container(
                      padding: const EdgeInsets.only(right: 50, left: 50),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Center(
                            child: Text(
                              'Ajouter une personne',
                              style: GoogleFonts.balooChettan(
                                fontSize: 20,
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Form(
                            key: _formKey,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                TextFormField(
                                  controller: playerName,
                                  maxLength: 15,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'La valeur ne peut être vide';
                                    } else if (value.isNotEmpty) {
                                      bool integer =
                                          RegExp(r'^[0-9]+([\\,\\.][0-9]+)?$')
                                              .hasMatch(value);
                                      return integer ? "Numéro interdit" : null;
                                    }
                                  },
                                  decoration: const InputDecoration(
                                    hintText: 'Nom du joueur',
                                    prefixIcon:
                                        Icon(Icons.account_circle_outlined),
                                    contentPadding: EdgeInsets.all(20.0),
                                  ),
                                ),
                                Container(
                                  margin: const EdgeInsets.only(
                                    top: 30,
                                  ),
                                  width: double.infinity,
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      shape: const StadiumBorder(),
                                      padding: const EdgeInsets.all(13),
                                      primary: buttonColor,
                                    ),
                                    onPressed: () => addPlayer(),
                                    child: Text(
                                      'Ajouter',
                                      style: GoogleFonts.balooChettan(
                                        color: Colors.white,
                                        fontSize: 20,
                                        letterSpacing: 1.5,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
