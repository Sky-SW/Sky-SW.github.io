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
class ThirdModeScreen extends StatelessWidget {
  const ThirdModeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      extendBodyBehindAppBar: true,
      appBar: DrinkeepAppBar(),
      body: ThirdModeGame(),
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
List thirdModeContent = [];

// screen widget content
class ThirdModeGame extends StatefulWidget {
  const ThirdModeGame({Key? key}) : super(key: key);

  @override
  _ThirdModeGameState createState() => _ThirdModeGameState();
}

class _ThirdModeGameState extends State<ThirdModeGame> {
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
    /// DONE / NOT DONE : Player has already done or not done
    /// VOTE : All players vote
    /// VERITY : One player imposed one verity another player
    /// CHOICE : Player has choice between two options
    /// GAME : Game with two players
    /// DEAD : All player include
    /// HOT : Hot actions
    /// TIME : Impose the temp new rule
    ///

    //  For validate  this  mode we need 40 content minimum

    // list mode third data content
    List thirdModeContentRecovery = [
      {
        "title": "DONE / NOT DONE",
        "text": "Déjà trompé ?"
                "\n\nTous ceux qui ont " +
            randomGeneralDoneOrNotDone() +
            randomGulp(),
      },
      {
        "title": "DONE / NOT DONE",
        "text": "Coucher le premier soir ?"
                "\n\nTous ceux qui ont " +
            randomGeneralDoneOrNotDone() +
            randomGulp(),
      },
      {
        "title": "DONE / NOT DONE",
        "text": "Envoyer un nude ?"
                "\n\nTous ceux qui ont " +
            randomGeneralDoneOrNotDone() +
            randomGulp(),
      },
      {
        "title": "DONE / NOT DONE",
        "text": "Aller dans un sex shop"
                ".\n\nTous ceux qui ont " +
            randomGeneralDoneOrNotDone() +
            randomGulp(),
      },
      {
        "title": "DONE / NOT DONE",
        "text": "Fait un plan à plusieurs"
                ".\n\nTous ceux qui ont " +
            randomGeneralDoneOrNotDone() +
            randomGulp(),
      },
      {
        "title": "CHOICE",
        "text": player_1() +
            " tu à le choix entre " +
            randomThirdModeChoice() +
            " " +
            player_2() +
            " ou prendre " +
            littleRandomGulp(),
      },
      {
        "title": "CHOICE",
        "text": player_1() + " retire un vêtement ou prend " + bigRandomGulp(),
      },
      {
        "title": "CHOICE",
        "text":
            player_1() + " raconte ton pire coup ou bois " + bigRandomGulp(),
      },
      {
        "title": "CHOICE",
        "text": player_1() +
            " tu a le choix d'embrasser ton/ta crush de la soirée.\nEt de lui donner " +
            bigRandomGulp(),
      },
      {
        "title": "CHOICE",
        "text": player_1() +
            " tu as le choix entre faire un strip-tease pour " +
            player_2() +
            " ou prendre " +
            littleRandomGulp(),
      },
      {
        "title": "VERITY",
        "text": player_1() +
            "\n\nAs-tu déjà fais une anale ?\n" +
            bigRandomGulp() +
            " t'attendent",
      },
      {
        "title": "VERITY",
        "text": player_1() +
            "\n\nT'as position préférée ?\n" +
            littleRandomGulpWithWait(),
      },
      {
        "title": "VERITY",
        "text": player_1() +
            "\n\nLa partie la plus sensible de ton corps ?\n" +
            bigRandomGulp() +
            " t'attendent",
      },
      {
        "title": "VERITY",
        "text": player_1() +
            "\n\nCe qui pourrait te faire craquer à coup sur ce soir ?\n" +
            littleRandomGulpWithWait(),
      },
      {
        "title": "VERITY",
        "text": player_1() +
            "\n\nLe préliminaire que tu préfères ?\n" +
            bigRandomGulp() +
            " t'attendent",
      },
      {
        "title": "VOTE",
        "text": "Votez !\n\n" +
            randomThirdModeVoteOne() +
            " c'est trompé ?\n"
                "\nLes " +
            randomminorityOrMajority() +
            " prennent " +
            randomGulp(),
      },
      {
        "title": "VOTE",
        "text": "Votez !\n\nPlutôt s'amuser " +
            randomThirdModeVoteSecond() +
            " ?\n"
                "\nLes " +
            randomminorityOrMajority() +
            " prennent " +
            randomGulp(),
      },
      {
        "title": "VOTE",
        "text": "Votez !\n\nPour votre position préférée.\n"
                "\nLes " +
            randomminorityOrMajority() +
            " prennent " +
            randomGulp(),
      },
      {
        "title": "VOTE",
        "text": "Votez !\n\n" +
            randomThirdModeAsk() +
            " ?\n"
                "\nLes " +
            randomminorityOrMajority() +
            " prennent " +
            randomGulp(),
      },
      {
        "title": "VOTE",
        "text": "Votez !\n\nDes fantasmes déjà réalisés ?\n"
                "\nLes " +
            randomminorityOrMajority() +
            " prennent " +
            randomGulp(),
      },
      {
        "title": "GAME",
        "text": player_1() +
            "\n\nChoisi(e) la personne de ton choix et twerk lui dessus." +
            "\nSi les autres valident ta performance la personne que tu as choisie boit " +
            bigRandomGulp(),
      },
      {
        "title": "GAME",
        "text": "Vous choisissez 3 aliments et " +
            player_1() +
            " doit les manger sur le ventre de " +
            player_2() +
            ".\nEt les autres prennent " +
            bigRandomGulp(),
      },
      {
        "title": "GAME",
        "text": player_1() +
            " prend une pièce et donne-la à la personne de ta " +
            randomLeftOrRight() +
            ".\nLes autres mettez-vous d'accord sur une question de votre choix"
                ".\nLa personne lance la pièce, si ça tombe sur pile tu devras dire la vérité.\nSi c'est face tu prends " +
            bigRandomGulp(),
      },
      {
        "title": "GAME",
        "text": "Blind test musical !\n" +
            player_1() +
            " tu feras le DJ !\nLa personne qui trouve la musique a le droit de retirer 1 vêtement à la personne de son choix.\nLes autres vous prenez " +
            littleRandomGulp() +
            ".\nLe DJ est immunisé !",
      },
      {
        "title": "GAME",
        "text": player_1() +
            " raconte une anecdote sexuelle.\nLes autres à vous de choisir si il/elle dit la vérité (le choix doit être unanime).\nSi vous avez bien répondu les " +
            bigRandomGulp() +
            " seront pour il/elle, sinon c'est pour vous !",
      },
      {
        "title": "DEAD",
        "text":
            "Tout le monde retire 1 vêtement et le plus habillé prend 1 cul sec",
      },
      {
        "title": "DEAD",
        "text": "Tout le monde prend 1 cul sec",
      },
      {
        "title": "DEAD",
        "text": "Tout le monde finit son verre",
      },
      {
        "title": "DEAD",
        "text": "La personne la moins habillée prend 1 cul sec",
      },
      {
        "title": "DEAD",
        "text": player_1() +
            " fini le verre de " +
            player_2() +
            " et tu peux le/la mordre",
      },
      {
        "title": "HOT",
        "text": player_1() +
            " assis toi sur les genoux de ce celui/celle que tu veux et il/elle prendra " +
            littleRandomGulp() +
            ".\nPendant " +
            middleRandomTime(),
      },
      {
        "title": "HOT",
        "text": player_1() +
            " fait un suçon à la personne de ton choix.\nCelle-ci prendra " +
            littleRandomGulp(),
      },
      {
        "title": "HOT",
        "text": player_1() +
            " lèche la joue de la personne de ton choix.\nCelle-ci prendra " +
            bigRandomGulp(),
      },
      {
        "title": "HOT",
        "text": player_1() +
            " essaye de séduire " +
            player_2() +
            ".\nSi il/elle avoue que tu es un bon(ne) séducteur/séductrice tu distribues " +
            bigRandomGulp() +
            " sinon tu les prends.",
      },
      {
        "title": "HOT",
        "text": player_1() +
            " éteint les lumières et fait ce que tu veux sur les autres joueurs.\nMais tu prendras " +
            bigRandomGulp(),
      },
      {
        "title": "TIME",
        "text": player_1() +
            " et " +
            player_2() +
            " sont désormais ensemble.\nIls font toutes les choses à 2 pour tous ceux qui peuvent leur arriver pendant " +
            middleRandomTime(),
      },
      {
        "title": "TIME",
        "text": player_1() + " devient immunisé pendant " + middleRandomTime(),
      },
      {
        "title": "TIME",
        "text": "Tout sera doublé pendant " +
            middleRandomTime() +
            ".\n(vêtement/gorgées/cul sec/...)",
      },
      {
        "title": "TIME",
        "text": player_1() +
            " retire 1 vêtement pour chaque gorgée pendant " +
            middleRandomTime(),
      },
      {
        "title": "TIME",
        "text": player_1() +
            " doit raconter une anecdote sexuelle pendant " +
            middleRandomTime() +
            " à chaque fois.\nPour chaque oubli par tour il/elle prend " +
            littleRandomGulp(),
      },
    ];

    // get current theme
    getCurrentTheme();

    // reset third mode array
    thirdModeContent.clear();

    // reset end game array
    endGame.clear();

    // add data in thirdModeContent list
    thirdModeContent.addAll(thirdModeContentRecovery);

    // get random data in array
    tempArray = thirdModeContent[Random().nextInt(thirdModeContent.length)];
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
      thirdModeContent.remove(tempArray);

      // get a new random item in array
      tempArray = thirdModeContent[Random().nextInt(thirdModeContent.length)];

      // reject "TIME" after more 25 round
      if (tempArray['title'] == 'TIME' && endGame.length > 24) {
        // remove item in list
        thirdModeContent.remove(tempArray);

        // get a new random item in array
        tempArray = thirdModeContent[Random().nextInt(thirdModeContent.length)];
      }

      // if have new action created
      for (var newAction in thirdModeContent) {
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
  final thirdContentNewData = TextEditingController();
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

      // list mode third data content
      List thirdModeContentRecovery = [
        {
          "title": "DONE / NOT DONE",
          "text": "Déjà trompé ?"
                  "\n\nTous ceux qui ont " +
              randomGeneralDoneOrNotDone() +
              randomGulp(),
        },
        {
          "title": "DONE / NOT DONE",
          "text": "Coucher le premier soir ?"
                  "\n\nTous ceux qui ont " +
              randomGeneralDoneOrNotDone() +
              randomGulp(),
        },
        {
          "title": "DONE / NOT DONE",
          "text": "Envoyer un nude ?"
                  "\n\nTous ceux qui ont " +
              randomGeneralDoneOrNotDone() +
              randomGulp(),
        },
        {
          "title": "DONE / NOT DONE",
          "text": "Aller dans un sex shop"
                  ".\n\nTous ceux qui ont " +
              randomGeneralDoneOrNotDone() +
              randomGulp(),
        },
        {
          "title": "DONE / NOT DONE",
          "text": "Fait un plan à plusieurs"
                  ".\n\nTous ceux qui ont " +
              randomGeneralDoneOrNotDone() +
              randomGulp(),
        },
        {
          "title": "CHOICE",
          "text": player_1() +
              " tu à le choix entre " +
              randomThirdModeChoice() +
              " " +
              player_2() +
              " ou prendre " +
              littleRandomGulp(),
        },
        {
          "title": "CHOICE",
          "text":
              player_1() + " retire un vêtement ou prend " + bigRandomGulp(),
        },
        {
          "title": "CHOICE",
          "text":
              player_1() + " raconte ton pire coup ou bois " + bigRandomGulp(),
        },
        {
          "title": "CHOICE",
          "text": player_1() +
              " tu a le choix d'embrasser ton/ta crush de la soirée.\nEt de lui donner " +
              bigRandomGulp(),
        },
        {
          "title": "CHOICE",
          "text": player_1() +
              " tu as le choix entre faire un strip-tease pour " +
              player_2() +
              " ou prendre " +
              littleRandomGulp(),
        },
        {
          "title": "VERITY",
          "text": player_1() +
              "\n\nAs-tu déjà fais une anale ?\n" +
              bigRandomGulp() +
              " t'attendent",
        },
        {
          "title": "VERITY",
          "text": player_1() +
              "\n\nT'as position préférée ?\n" +
              littleRandomGulpWithWait(),
        },
        {
          "title": "VERITY",
          "text": player_1() +
              "\n\nLa partie la plus sensible de ton corps ?\n" +
              bigRandomGulp() +
              " t'attendent",
        },
        {
          "title": "VERITY",
          "text": player_1() +
              "\n\nCe qui pourrait te faire craquer à coup sur ce soir ?\n" +
              littleRandomGulpWithWait(),
        },
        {
          "title": "VERITY",
          "text": player_1() +
              "\n\nLe préliminaire que tu préfères ?\n" +
              bigRandomGulp() +
              " t'attendent",
        },
        {
          "title": "VOTE",
          "text": "Votez !\n\n" +
              randomThirdModeVoteOne() +
              " c'est trompé ?\n"
                  "\nLes " +
              randomminorityOrMajority() +
              " prennent " +
              randomGulp(),
        },
        {
          "title": "VOTE",
          "text": "Votez !\n\nPlutôt s'amuser " +
              randomThirdModeVoteSecond() +
              " ?\n"
                  "\nLes " +
              randomminorityOrMajority() +
              " prennent " +
              randomGulp(),
        },
        {
          "title": "VOTE",
          "text": "Votez !\n\nPour votre position préférée.\n"
                  "\nLes " +
              randomminorityOrMajority() +
              " prennent " +
              randomGulp(),
        },
        {
          "title": "VOTE",
          "text": "Votez !\n\n" +
              randomThirdModeAsk() +
              " ?\n"
                  "\nLes " +
              randomminorityOrMajority() +
              " prennent " +
              randomGulp(),
        },
        {
          "title": "VOTE",
          "text": "Votez !\n\nDes fantasmes déjà réalisés ?\n"
                  "\nLes " +
              randomminorityOrMajority() +
              " prennent " +
              randomGulp(),
        },
        {
          "title": "GAME",
          "text": player_1() +
              "\n\nChoisi(e) la personne de ton choix et twerk lui dessus." +
              "\nSi les autres valident ta performance la personne que tu as choisie boit " +
              bigRandomGulp(),
        },
        {
          "title": "GAME",
          "text": "Vous choisissez 3 aliments et " +
              player_1() +
              " doit les manger sur le ventre de " +
              player_2() +
              ".\nEt les autres prennent " +
              bigRandomGulp(),
        },
        {
          "title": "GAME",
          "text": player_1() +
              " prend une pièce et donne-la à la personne de ta " +
              randomLeftOrRight() +
              ".\nLes autres mettez-vous d'accord sur une question de votre choix"
                  ".\nLa personne lance la pièce, si ça tombe sur 'pile' tu devras dire la vérité.\nSi c'est face tu prends " +
              bigRandomGulp(),
        },
        {
          "title": "GAME",
          "text": "Blind test musical !\n" +
              player_1() +
              " tu feras le DJ !\nLa personne qui trouve la musique a le droit de retirer 1 vêtement à la personne de son choix.\nLes autres vous prenez " +
              littleRandomGulp() +
              ".\nLe DJ est immunisé !",
        },
        {
          "title": "GAME",
          "text": player_1() +
              " raconte une anecdote sexuelle.\nLes autres à vous de choisir si il/elle dit la vérité (le choix doit être unanime).\nSi vous avez bien répondu les " +
              bigRandomGulp() +
              " seront pour il/elle, sinon c'est pour vous !",
        },
        {
          "title": "DEAD",
          "text":
              "Tout le monde retire 1 vêtement et le plus habillé prend 1 cul sec",
        },
        {
          "title": "DEAD",
          "text": "Tout le monde prend 1 cul sec",
        },
        {
          "title": "DEAD",
          "text": "Tout le monde finit son verre",
        },
        {
          "title": "DEAD",
          "text": "La personne la moins habillée prend 1 cul sec",
        },
        {
          "title": "DEAD",
          "text": player_1() +
              " fini le verre de " +
              player_2() +
              " et tu peux le/la mordre",
        },
        {
          "title": "HOT",
          "text": player_1() +
              " assis toi sur les genoux de ce celui/celle que tu veux et il/elle prendra " +
              littleRandomGulp() +
              ".\nPendant " +
              middleRandomTime(),
        },
        {
          "title": "HOT",
          "text": player_1() +
              " fait un suçon à la personne de ton choix.\nCelle-ci prendra " +
              littleRandomGulp(),
        },
        {
          "title": "HOT",
          "text": player_1() +
              " lèche la joue de la personne de ton choix.\nCelle-ci prendra " +
              bigRandomGulp(),
        },
        {
          "title": "HOT",
          "text": player_1() +
              " essaye de séduire " +
              player_2() +
              ".\nSi il/elle avoue que tu es un bon(ne) séducteur/séductrice tu distribues " +
              bigRandomGulp() +
              " sinon tu les prends.",
        },
        {
          "title": "HOT",
          "text": player_1() +
              " éteint les lumières et fait ce que tu veux sur les autres joueurs.\nMais tu prendras " +
              bigRandomGulp(),
        },
        {
          "title": "TIME",
          "text": player_1() +
              " et " +
              player_2() +
              " sont désormais ensemble.\nIls font toutes les choses à 2 pour tous ceux qui peuvent leur arriver pendant " +
              middleRandomTime(),
        },
        {
          "title": "TIME",
          "text":
              player_1() + " devient immunisé pendant " + middleRandomTime(),
        },
        {
          "title": "TIME",
          "text": "Tout sera doublé pendant " +
              middleRandomTime() +
              ".\n(vêtement/gorgées/cul sec/...)",
        },
        {
          "title": "TIME",
          "text": player_1() +
              " retire 1 vêtement pour chaque gorgée pendant " +
              middleRandomTime(),
        },
        {
          "title": "TIME",
          "text": player_1() +
              " doit raconter une anecdote sexuelle pendant " +
              middleRandomTime() +
              " à chaque fois.\nPour chaque oubli par tour il/elle prend " +
              littleRandomGulp(),
        },
      ];

      // foreach list
      List temp = [];

      // remove element already exist
      for (var element in thirdModeContentRecovery) {
        if (!thirdModeContent.contains(element)) {
          temp.add(element);
        }
      }

      // clear list
      thirdModeContent.clear();

      // add new action in temp array
      thirdModeContent.addAll(temp);
    });
  }

  // insert a new personnal action
  void addAction() {
    setState(() {
      // form validation
      if (_formKey.currentState!.validate()) {
        thirdModeContent.add({
          "title": "NEW",
          "text": player_1() +
              ", " +
              thirdContentNewData.text +
              randomGiveOrDone() +
              randomGulp(),
        });
      }
      // reset text field
      thirdContentNewData.clear();
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
                                "Veuillez entrer \nvotre action personnalisée.\n'[Nom aléatoire], votre action [ou tu prends/distribues] [gorgée aléatoire]'",
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
                                  controller: thirdContentNewData,
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
