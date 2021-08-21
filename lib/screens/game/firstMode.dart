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
class FirstModeScreen extends StatelessWidget {
  const FirstModeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      extendBodyBehindAppBar: true,
      appBar: DrinkeepAppBar(),
      body: FirstModeGame(),
      bottomNavigationBar: BottomButton(),
    );
  }
}

// global variable
List firstModeContent = [];

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

// screen widget content
class FirstModeGame extends StatefulWidget {
  const FirstModeGame({Key? key}) : super(key: key);

  @override
  _FirstModeGameState createState() => _FirstModeGameState();
}

class _FirstModeGameState extends State<FirstModeGame> {
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
    /// VOTE : All players vote to choose a looser or winner
    /// DEAD : Finished drink
    /// SOFT : One or more players get a drink
    /// SHOOT : One or more players give a drink
    /// TRY : One or more players try a condition
    /// TIME : Impose the temp new rule
    /// CHOICE : Imposes  one  choices on the players
    /// GAME : All players play
    ///

    //  For validate  this  mode we need 40 content minimum

    // list first data content
    List firstModeContentRecovery = [
      {
        "title": "TIME",
        "text":
            "Toutes les futures gorgées seront distribuées à la droite de la personne ciblée pendant " +
                middleRandomTime(),
      },
      {
        "title": "TRY",
        "text": player_1() +
            " et " +
            player_2() +
            " font un concours de blague\nLe/La perdant(e) prend " +
            littleRandomGulp(),
      },
      {
        "title": "CHOICE",
        "text": player_1() +
            " tu as le choix entre imiter ou dessiner un personnage.\nSi une personne trouve elle est immunisée et tu distribues " +
            littleRandomGulp() +
            " pour les perdants",
      },
      {
        "title": "TRY",
        "text": player_1() +
            " tu dois raconter une blague.\nSi 1 personne minimum rit tu es immunisé, sinon tu prends " +
            littleRandomGulp(),
      },
      {
        "title": "GAME",
        "text": player_1() +
            " vs " +
            player_2() +
            "\n\nL'un après l'autre citez un film qui a fait le buzz.\nLa personne la plus " +
            randomYoungOrOld() +
            " commence.\nLe/La perdant(e) prend " +
            littleRandomGulp(),
      },
      {
        "title": "CHOICE",
        "text": player_1() +
            " tu as le choix entre distribuer " +
            littleRandomGulp() +
            " à la personne à ta droite ou à ta gauche",
      },
      {
        "title": "GAME",
        "text": player_1() +
            " fais un \"pierre, feuilles, ciseaux\" en 3 points contre " +
            player_2() +
            "\nLe/La perdant(e) prend " +
            bigRandomGulp(),
      },
      {
        "title": "DEAD",
        "text": player_1() + " et " + player_2() + " finissent leurs verres",
      },
      {
        "title": "SOFT",
        "text": player_1() +
            " doit deviner le numéro (compris entre 0 et 10) avec 3 essais max.\nS'il/elle réussit il/elle distribue " +
            littleRandomGulp() +
            ", sinon il/elle les prends.\n\nNuméro : " +
            randomNumberStart(),
      },
      {
        "title": "VOTE",
        "text": "Désignez tous ensemble la personne la plus " +
            randomLittleOrBig() +
            " qui devra prendre " +
            littleRandomGulp(),
      },
      {
        "title": "DEAD",
        "text": "Tout le monde fini son verre",
      },
      {
        "title": "SHOOT",
        "text": "Tous/Toutes les " +
            randomHairColor() +
            " donnent " +
            littleRandomGulp(),
      },
      {
        "title": "SHOOT",
        "text": player_1() + " tu distribues " + littleRandomGulp(),
      },
      {
        "title": "VOTE",
        "text": "Plutôt " +
            randomFirstModeChoice() +
            " ?\n\nVotez-tous en même temps, les " +
            randomminorityOrMajority() +
            " prennent " +
            littleRandomGulp(),
      },
      {
        "title": "SOFT",
        "text": player_1() +
            " tu prends " +
            littleRandomGulp() +
            " pour le plaisir",
      },
      {
        "title": "SOFT",
        "text": "Tous ceux qui portent un vêtement " +
            randomColor() +
            " prennent " +
            littleRandomGulp(),
      },
      {
        "title": "CHOICE",
        "text": player_1() +
            " tu as le choix entre te faire dessiner dessus par " +
            player_2() +
            ",\nou prendre " +
            littleRandomGulp(),
      },
      {
        "title": "DEAD",
        "text": player_1() + " tu dois boire le reste de ton verre cul sec",
      },
      {
        "title": "CHOICE",
        "text": player_1() +
            " tu as le choix entre faire une danse ou chanter a capella.\nSi tu fais l'unanimité tu distribues " +
            bigRandomGulp(),
      },
      {
        "title": "VOTE",
        "text":
            "Chacun raconte un dossier sur lui-même.\nLe meilleur distribue " +
                littleRandomGulp(),
      },
      {
        "title": "TIME",
        "text":
            "Désormais vous changez de prénom avec la personne à votre gauche.\nSi vous vous trompez vous prenez " +
                littleRandomGulp() +
                ".\nPendant " +
                middleRandomTime(),
      },
      {
        "title": "TRY",
        "text": player_1() +
            " fais ton meilleur moonwalk.\nSi les autres valident tu distribues " +
            littleRandomGulp(),
      },
      {
        "title": "VOTE",
        "text":
            "Vous devez élire un(e) délégué(e) parmis vous.\nVotez tous en même temps.\nLes " +
                randomminorityOrMajority() +
                " prennent " +
                littleRandomGulp(),
      },
      {
        "title": "SHOOT",
        "text": "Toutes les personnes qui font entre " +
            randomSize() +
            " donnent " +
            littleRandomGulp() +
            " chacune",
      },
      {
        "title": "CHOICE",
        "text": "La dernière personne à avoir mangé fast-food fait " +
            bigRandom() +
            " pompes ou prend " +
            littleRandomGulp(),
      },
      {
        "title": "GAME",
        "text": "\"" +
            randomChoice() +
            "\"\n\nComplétez cette phrase.\nLa première personne n'ayant plus d'idée prend " +
            littleRandomGulp() +
            ".\n" +
            player_1() +
            ", tu commences !",
      },
      {
        "title": "GAME",
        "text": "Concours de blague !\nLa meilleure donne " +
            bigRandomGulp() +
            ".\n" +
            player_1() +
            ", tu commences !",
      },
      {
        "title": "TIME",
        "text":
            "On double les gorgées uniquement !\nPendant " + middleRandomTime(),
      },
      {
        "title": "SHOOT",
        "text": "La personne la plus tatouée distribue " + bigRandomGulp(),
      },
      {
        "title": "SOFT",
        "text": "Si tu as plus de " +
            randomOld() +
            " tu prend " +
            littleRandomGulp(),
      },
      {
        "title": "GAME",
        "text": "La dernière personne à toucher à son verre prend " +
            littleRandomGulp(),
      },
      {
        "title": "DEAD",
        "text": "La personne qui tien le portable donne 1 cul sec",
      },
      {
        "title": "SOFT",
        "text": "Tous ceux qui ont la même marque de téléphone que " +
            player_1() +
            " prennent " +
            littleRandomGulp(),
      },
      {
        "title": "TIME",
        "text": player_1() +
            " devient maintenant " +
            randomHero() +
            ".\nToute personne se trompant de nom prend " +
            littleRandomGulp() +
            " pendant " +
            middleRandomTime(),
      },
      {
        "title": "VOTE",
        "text": "Votez pour la personne la plus drôle de la soirée.\nLes " +
            randomminorityOrMajority() +
            " distribuent " +
            littleRandomGulp(),
      },
      {
        "title": "TIME",
        "text": "La personne la plus " +
            randomYoungOrOld() +
            " devient roi/reine !\nElle double le nombre de gorgées qu'elle donne pendant " +
            middleRandomTime(),
      },
      {
        "title": "DEAD",
        "text": player_1() + " distribue 1 cul sec",
      },
      {
        "title": "TRY",
        "text": player_1() +
            " fait sa meilleure grimace.\nSi les autres valident tu distribues " +
            littleRandomGulp(),
      },
      {
        "title": "SHOOT",
        "text":
            "La(Les) personne(s) portant(s) le moins d'accessoires donne(nt) " +
                littleRandomGulp(),
      },
      {
        "title": "TRY",
        "text": "La personne qui tiens le portable doit donner l'âge de " +
            player_1() +
            "\nSi tu réussis tu distribues " +
            littleRandomGulp() +
            ", sinon tu les prends",
      },
    ];

    // get current theme
    getCurrentTheme();

    // reset first mode array
    firstModeContent.clear();

    // reset end game array
    endGame.clear();

    // add data in firstModeContent list
    firstModeContent.addAll(firstModeContentRecovery);

    // get random data in array
    tempArray = firstModeContent[Random().nextInt(firstModeContent.length)];
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
      firstModeContent.remove(tempArray);

      // get a new random item in array
      tempArray = firstModeContent[Random().nextInt(firstModeContent.length)];

      // reject "TIME" after more 25 round
      if (tempArray['title'] == 'TIME' && endGame.length > 24) {
        // remove item in list
        firstModeContent.remove(tempArray);

        // get a new random item in array
        tempArray = firstModeContent[Random().nextInt(firstModeContent.length)];
      }

      // if have new action created
      for (var newAction in firstModeContent) {
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
  final firstContentNewData = TextEditingController();
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

      // list first data content
      List firstModeContentRecovery = [
        {
          "title": "TIME",
          "text":
              "Toutes les futures gorgées seront distribuées à la droite de la personne ciblée pendant " +
                  middleRandomTime(),
        },
        {
          "title": "TRY",
          "text": player_1() +
              " et " +
              player_2() +
              " font un concours de blague\nLe perdant prend " +
              littleRandomGulp(),
        },
        {
          "title": "CHOICE",
          "text": player_1() +
              " tu as le choix entre imiter ou dessiner un personnage.\nSi une personne trouve elle est immunisée et tu distribues " +
              littleRandomGulp() +
              " pour les perdants",
        },
        {
          "title": "TRY",
          "text": player_1() +
              " tu dois raconter une blague.\nSi 1 personne minimum rit tu es immunisé, sinon tu prends " +
              littleRandomGulp(),
        },
        {
          "title": "GAME",
          "text": player_1() +
              " vs " +
              player_2() +
              "\n\nL'un après l'autre citez un film qui a fait le buzz.\nLa personne la plus " +
              randomYoungOrOld() +
              " commence.\nLe perdant prend " +
              littleRandomGulp(),
        },
        {
          "title": "CHOICE",
          "text": player_1() +
              " tu as le choix entre distribuer " +
              littleRandomGulp() +
              " à la personne à ta droite ou à ta gauche",
        },
        {
          "title": "GAME",
          "text": player_1() +
              " fais un \"pierre, feuilles, ciseaux\" en 3 points contre " +
              player_2() +
              "\nLe perdant prend " +
              bigRandomGulp(),
        },
        {
          "title": "DEAD",
          "text": player_1() + " et " + player_2() + " finissent leurs verres",
        },
        {
          "title": "SOFT",
          "text": player_1() +
              " doit deviner le numéro (compris entre 0 et 10) avec 3 essais max.\nS'il réussit il distribue " +
              littleRandomGulp() +
              ", sinon il les prend.\n\nNuméro : " +
              randomNumberStart(),
        },
        {
          "title": "VOTE",
          "text": "Désignez tous ensemble la personne la plus " +
              randomLittleOrBig() +
              " qui devra prendre " +
              littleRandomGulp(),
        },
        {
          "title": "DEAD",
          "text": "Tout le monde fini son verre",
        },
        {
          "title": "SHOOT",
          "text": "Tous/Toutes les " +
              randomHairColor() +
              " donnent " +
              littleRandomGulp(),
        },
        {
          "title": "SHOOT",
          "text": player_1() + " tu distribues " + littleRandomGulp(),
        },
        {
          "title": "VOTE",
          "text": "Plutôt " +
              randomFirstModeChoice() +
              " ?\n\nVotez-tous en même temps, les " +
              randomminorityOrMajority() +
              " prennent " +
              littleRandomGulp(),
        },
        {
          "title": "SOFT",
          "text": player_1() +
              " tu prends " +
              littleRandomGulp() +
              " pour le plaisir",
        },
        {
          "title": "SOFT",
          "text": "Tous ceux qui portent un vêtement " +
              randomColor() +
              " prennent " +
              littleRandomGulp(),
        },
        {
          "title": "CHOICE",
          "text": player_1() +
              " tu as le choix entre te faire dessiner dessus par " +
              player_2() +
              ",\nou prendre " +
              littleRandomGulp(),
        },
        {
          "title": "DEAD",
          "text": player_1() + " tu dois boire le reste de ton verre cul sec",
        },
        {
          "title": "CHOICE",
          "text": player_1() +
              " tu as le choix entre faire une danse ou chanter a capella.\nSi tu fais l'unanimité tu distribues " +
              bigRandomGulp(),
        },
        {
          "title": "VOTE",
          "text":
              "Chacun raconte un dossier sur lui-même.\nLe meilleur distribue " +
                  littleRandomGulp(),
        },
        {
          "title": "TIME",
          "text":
              "Désormais vous changez de prénom avec la personne à votre gauche.\nSi vous vous trompez vous prenez " +
                  littleRandomGulp() +
                  ".\nPendant " +
                  middleRandomTime(),
        },
        {
          "title": "TRY",
          "text": player_1() +
              " fais ton meilleur moonwalk.\nSi les autres valident tu distribues " +
              littleRandomGulp(),
        },
        {
          "title": "VOTE",
          "text":
              "Vous devez élire un(e) délégué(e) parmis vous.\nVotez tous en même temps.\nLes " +
                  randomminorityOrMajority() +
                  " prennent " +
                  littleRandomGulp(),
        },
        {
          "title": "SHOOT",
          "text": "Toutes les personnes qui font entre " +
              randomSize() +
              " donnent " +
              littleRandomGulp() +
              " chacune",
        },
        {
          "title": "CHOICE",
          "text": "La dernière personne à avoir mangé fast-food fait " +
              bigRandom() +
              " pompes ou prend " +
              littleRandomGulp(),
        },
        {
          "title": "GAME",
          "text": "\"" +
              randomChoice() +
              "\"\n\nComplétez cette phrase.\nLa première personne n'ayant plus d'idée prend " +
              littleRandomGulp() +
              ".\n" +
              player_1() +
              ", tu commences !",
        },
        {
          "title": "GAME",
          "text": "Concours de blague !\nLa meilleure donne " +
              bigRandomGulp() +
              ".\n" +
              player_1() +
              ", tu commences !",
        },
        {
          "title": "TIME",
          "text": "On double les gorgées uniquement !\nPendant " +
              middleRandomTime(),
        },
        {
          "title": "SHOOT",
          "text": "La personne la plus tatouée distribue " + bigRandomGulp(),
        },
        {
          "title": "SOFT",
          "text": "Si tu as plus de " +
              randomOld() +
              " tu prend " +
              littleRandomGulp(),
        },
        {
          "title": "GAME",
          "text": "La dernière personne à toucher à son verre prend " +
              littleRandomGulp(),
        },
        {
          "title": "DEAD",
          "text": "La personne qui tien le portable donne 1 cul sec",
        },
        {
          "title": "SOFT",
          "text": "Tous ceux qui ont la même marque de téléphone que " +
              player_1() +
              " prennent " +
              littleRandomGulp(),
        },
        {
          "title": "TIME",
          "text": player_1() +
              " devient maintenant " +
              randomHero() +
              ".\nToute personne se trompant de nom prend " +
              littleRandomGulp() +
              " pendant " +
              middleRandomTime(),
        },
        {
          "title": "VOTE",
          "text": "Votez pour la personne la plus drôle de la soirée.\nLes " +
              randomminorityOrMajority() +
              " distribuent " +
              littleRandomGulp(),
        },
        {
          "title": "TIME",
          "text": "La personne la plus " +
              randomYoungOrOld() +
              " devient roi/reine !\nElle double le nombre de gorgées qu'elle donne pendant " +
              middleRandomTime(),
        },
        {
          "title": "DEAD",
          "text": player_1() + " distribue 1 cul sec",
        },
        {
          "title": "TRY",
          "text": player_1() +
              " fait sa meilleure grimace.\nSi les autres valident tu distribues " +
              littleRandomGulp(),
        },
        {
          "title": "SHOOT",
          "text":
              "La(Les) personne(s) portant(s) le moins d'accessoires donne(nt) " +
                  littleRandomGulp(),
        },
        {
          "title": "TRY",
          "text": "La personne qui tiens le portable doit donner l'âge de " +
              player_1() +
              "\nSi tu réussis tu distribues " +
              littleRandomGulp() +
              ", sinon tu les prends",
        },
      ];

      // foreach list
      List temp = [];

      // remove element already exist
      for (var element in firstModeContentRecovery) {
        if (!firstModeContent.contains(element)) {
          temp.add(element);
        }
      }

      // clear list
      firstModeContent.clear();

      // add new action in temp array
      firstModeContent.addAll(temp);
    });
  }

  // insert a new personnal action
  void addAction() {
    setState(() {
      // form validation
      if (_formKey.currentState!.validate()) {
        firstModeContent.add({
          "title": "NEW",
          "text": player_1() +
              ", " +
              firstContentNewData.text +
              randomGiveOrDone() +
              randomGulp(),
        });
      }
      // reset text field
      firstContentNewData.clear();
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
                                  controller: firstContentNewData,
                                  maxLength: 50,
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
