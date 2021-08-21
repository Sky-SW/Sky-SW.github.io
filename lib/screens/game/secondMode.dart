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
class SecondModeScreen extends StatelessWidget {
  const SecondModeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      extendBodyBehindAppBar: true,
      appBar: DrinkeepAppBar(),
      body: SecondModeGame(),
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
List secondModeContent = [];

// screen widget content
class SecondModeGame extends StatefulWidget {
  const SecondModeGame({Key? key}) : super(key: key);

  @override
  _SecondModeGameState createState() => _SecondModeGameState();
}

class _SecondModeGameState extends State<SecondModeGame> {
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
    /// GAME : All players play
    /// TARGET : One player target
    /// ALL : All player questioned
    /// VERITY : One player imposed one verity another player
    /// TIME : Impose the temp new rule
    /// DEAD : Finished drink
    /// VOTE : Players vote to choose a looser or winner
    /// NAME IT : All players find name
    ///

    //  For validate  this  mode we need 40 content minimum

    // list second data content
    List secondModeContentRecovery = [
      {
        "title": "TARGET",
        "text": player_1() +
            " raconte un dossier sur " +
            player_2() +
            " ou prends " +
            littleRandomGulp(),
      },
      {
        "title": "TARGET",
        "text": "La dernière personne à avoir bu doit reprendre la même chose",
      },
      {
        "title": "TARGET",
        "text": player_1() +
            " choisi la personne de ton choix et distribue " +
            littleRandomGulp(),
      },
      {
        "title": "TARGET",
        "text": "Si " +
            player_1() +
            " a déjà bu au tour précédent il distribue " +
            bigRandomGulp(),
      },
      {
        "title": "TARGET",
        "text": player_1() +
            " tu prendras les gorgées de la personne du prochain tour",
      },
      {
        "title": "ALL",
        "text":
            "Si l'un(e) de vous a déjà embrassé(e) une autre personne du groupe elle prend " +
                littleRandomGulp(),
      },
      {
        "title": "VOTE",
        "text": "Votez pour la personne la plus " +
            randomSecondModeGuest() +
            ", elle prendra " +
            bigRandomGulp(),
      },
      {
        "title": "VERITY",
        "text": player_1() +
            " raconte ton plus beau souvenir de " +
            player_2() +
            "\nPour te remercier il/elle prend " +
            littleRandomGulp(),
      },
      {
        "title": "GAME",
        "text": "L'un après l'autre trouvez un synonyme de \"" +
            randomSynonymous() +
            "\", le/la perdant(e) prend " +
            littleRandomGulp() +
            ".\n" +
            player_1() +
            ", tu commences",
      },
      {
        "title": "VERITY",
        "text": player_1() +
            " dis ce que tu pensais de " +
            player_2() +
            " lors de votre première rencontre ou prends " +
            bigRandomGulp(),
      },
      {
        "title": "VERITY",
        "text": player_1() +
            " dis à tout le monde la chose la plus honteuse que tu es faite ou prends " +
            littleRandomGulp(),
      },
      {
        "title": "VERITY",
        "text": player_1() +
            " raconte nous ton pire mensonge ou prends " +
            littleRandomGulp(),
      },
      {
        "title": "VERITY",
        "text": player_1() +
            " raconte ton pire rendez-vous ou prend " +
            littleRandomGulp(),
      },
      {
        "title": "ALL",
        "text": "Tout le monde à le droit de boire " + littleRandomGulp(),
      },
      {
        "title": "ALL",
        "text":
            "Tous ceux qui ont déjà conduit en étant pas très sobre prennent " +
                bigRandomGulp(),
      },
      {
        "title": "ALL",
        "text": "Tous ceux qui ont déjà pris de la drogue prennent " +
            bigRandomGulp(),
      },
      {
        "title": "ALL",
        "text":
            "Tous ceux qui ont déjà menti à l'un(e) d'entre vous prennent " +
                littleRandomGulp(),
      },
      {
        "title": "DEAD",
        "text": player_1() + " fini le verre de " + player_2(),
      },
      {
        "title": "NAME IT",
        "text": "Vous devez nommer le plus de " +
            randomAlcool() +
            " que vous connaissez à tour de rôle !\nLe/la perdant(e) prend " +
            littleRandomGulp() +
            ".\n" +
            player_1() +
            ", tu commences !",
      },
      {
        "title": "VOTE",
        "text":
            "Désignez tous ensemble la personne ayant eu le plus d'ex qui devra prendre " +
                bigRandomGulp(),
      },
      {
        "title": "DEAD",
        "text": "Tout le monde fini son verre",
      },
      {
        "title": "NAME IT",
        "text":
            "Vous devez nommer le plus de marque de vêtements que vous connaissez à tour de rôle !\nLe/la perdant(e) prend " +
                littleRandomGulp() +
                ".\n" +
                player_1() +
                ", tu commences !",
      },
      {
        "title": "NAME IT",
        "text":
            "Vous devez nommer le plus de bar de votre ville que vous connaissez à tour de rôle !\nLe/la perdant(e) prend " +
                littleRandomGulp() +
                ".\n" +
                player_1() +
                ", tu commences !",
      },
      {
        "title": "GAME",
        "text": player_1() +
            " VS " +
            player_2() +
            "\n\nBras de fer chinois entre vous.\nLe perdant doit boire un verre fait par le vainqueur",
      },
      {
        "title": "TIME",
        "text": "Toutes les futures gorgées seront distribuées à " +
            player_1() +
            " pendant " +
            middleRandomTime(),
      },
      {
        "title": "VOTE",
        "text": "Votez tous pour savoir si " +
            player_1() +
            " à soif.\nSi les " +
            randomminorityOrMajority() +
            " l'emportent, il/elle prend " +
            littleRandomGulp(),
      },
      {
        "title": "DEAD",
        "text": "Toutes les personnes qui ont 2x le numéro \"" +
            randomNumberStart() +
            "\" dans leur téléphone, doivent prendre 1 cul sec",
      },
      {
        "title": "TIME",
        "text": player_1() +
            " tu échanges de prénom avec " +
            player_2() +
            " pendant " +
            middleRandomTime() +
            ".\nSi une personne se trompe elle prend " +
            littleRandomGulp(),
      },
      {
        "title": "GAME",
        "text":
            "Téléphone arabe !\n\nChacun votre tour ajoutez une suite à \"" +
                randomSecondModeGame() +
                "\"\nLa première personne qui se trompe prend " +
                bigRandomGulp() +
                ".\n" +
                player_1() +
                ", tu commences !",
      },
      {
        "title": "GAME",
        "text": player_1() +
            " pense à une personne du groupe et " +
            player_2() +
            " doit deviner qui c'est.\n3 questions max autorisées.\nSi il/elle trouve qui s'est tu prends " +
            bigRandomGulp() +
            ", sinon c'est pour toi",
      },
      {
        "title": "TIME",
        "text":
            player_1() + " double ses gorgées !\nPendant " + middleRandomTime(),
      },
      {
        "title": "GAME",
        "text": player_1() +
            " et " +
            player_2() +
            " font un \"je te tiens par la barbichette\".\nLe premier qui rigole prend " +
            littleRandomGulp(),
      },
      {
        "title": "DEAD",
        "text":
            "La personne à la droite de celle qui tien le portable donne 1 cul sec",
      },
      {
        "title": "TIME",
        "text": player_1() +
            " devient le détenteur du téléphone pendant " +
            middleRandomTime(),
      },
      {
        "title": "DEAD",
        "text": "Le détenteur du téléphone prend 1 cul sec",
      },
      {
        "title": "NAME IT",
        "text":
            "Vous devez nommer le plus de marque de voiture que vous connaissez à tour de rôle !\nLe/la perdant(e) prend " +
                littleRandomGulp() +
                ".\n" +
                player_1() +
                ", tu commences !",
      },
      {
        "title": "NAME IT",
        "text":
            "Vous devez nommer le plus de restaurant dans la ville que vous connaissez à tour de rôle !\nLe/la perdant(e) prend " +
                littleRandomGulp() +
                ".\n" +
                player_1() +
                ", tu commences !",
      },
      {
        "title": "VOTE",
        "text": "Votez pour le/la meilleur(e) " +
            randomAlcool() +
            ".\nS'il y aux moins 2 réponses identiques les autres prennent " +
            littleRandomGulp(),
      },
      {
        "title": "VOTE",
        "text": player_1() +
            " et " +
            player_2() +
            "\n\nMettez-vous d'accord sur 1 personne, elle devra faire le gage de votre choix ou prendre " +
            littleRandomGulp(),
      },
      {
        "title": "TIME",
        "text": "La personne la plus " +
            randomLittleOrBig() +
            " devient roi/reine !\nElle double le nombre de gorgées pendant " +
            middleRandomTime(),
      },
    ];

    // get current theme
    getCurrentTheme();

    // reset second mode array
    secondModeContent.clear();

    // reset end game array
    endGame.clear();

    // add data in secondModeContent list
    secondModeContent.addAll(secondModeContentRecovery);

    // get random data in array
    tempArray = secondModeContent[Random().nextInt(secondModeContent.length)];
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
      secondModeContent.remove(tempArray);

      // get a new random item in array
      tempArray = secondModeContent[Random().nextInt(secondModeContent.length)];

      // reject "TIME" after more 25 round
      if (tempArray['title'] == 'TIME' && endGame.length > 24) {
        // remove item in list
        secondModeContent.remove(tempArray);

        // get a new random item in array
        tempArray =
            secondModeContent[Random().nextInt(secondModeContent.length)];
      }

      // if have new action created
      for (var newAction in secondModeContent) {
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
  final secondContentNewData = TextEditingController();
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

      // list second data content
      List secondModeContentRecovery = [
        {
          "title": "TARGET",
          "text": player_1() +
              " raconte un dossier sur " +
              player_2() +
              " ou prends " +
              littleRandomGulp(),
        },
        {
          "title": "TARGET",
          "text":
              "La dernière personne à avoir bu doit reprendre la même chose",
        },
        {
          "title": "TARGET",
          "text": player_1() +
              " choisi la personne de ton choix et distribue " +
              littleRandomGulp(),
        },
        {
          "title": "TARGET",
          "text": "Si " +
              player_1() +
              " a déjà bu au tour précédent il distribue " +
              bigRandomGulp(),
        },
        {
          "title": "TARGET",
          "text": player_1() +
              " tu prendras les gorgées de la personne du prochain tour",
        },
        {
          "title": "ALL",
          "text":
              "Si l'un(e) de vous a déjà embrassé(e) une autre personne du groupe elle prend " +
                  littleRandomGulp(),
        },
        {
          "title": "VOTE",
          "text": "Votez pour la personne la plus " +
              randomSecondModeGuest() +
              ", elle prendra " +
              bigRandomGulp(),
        },
        {
          "title": "VERITY",
          "text": player_1() +
              " raconte ton plus beau souvenir de " +
              player_2() +
              "\nPour te remercier il/elle prend " +
              littleRandomGulp(),
        },
        {
          "title": "GAME",
          "text": "L'un après l'autre trouvez un synonyme de \"" +
              randomSynonymous() +
              "\", le/la perdant(e) prend " +
              littleRandomGulp() +
              ".\n" +
              player_1() +
              ", tu commences",
        },
        {
          "title": "VERITY",
          "text": player_1() +
              " dis ce que tu pensais de " +
              player_2() +
              " lors de votre première rencontre ou prends " +
              bigRandomGulp(),
        },
        {
          "title": "VERITY",
          "text": player_1() +
              " dis à tout le monde la chose la plus honteuse que tu es faite ou prends " +
              littleRandomGulp(),
        },
        {
          "title": "VERITY",
          "text": player_1() +
              " raconte nous ton pire mensonge ou prends " +
              littleRandomGulp(),
        },
        {
          "title": "VERITY",
          "text": player_1() +
              " raconte ton pire rendez-vous ou prend " +
              littleRandomGulp(),
        },
        {
          "title": "ALL",
          "text": "Tout le monde à le droit de boire " + littleRandomGulp(),
        },
        {
          "title": "ALL",
          "text":
              "Tous ceux qui ont déjà conduit en étant pas très sobre prennent " +
                  bigRandomGulp(),
        },
        {
          "title": "ALL",
          "text": "Tous ceux qui ont déjà pris de la drogue prennent " +
              bigRandomGulp(),
        },
        {
          "title": "ALL",
          "text":
              "Tous ceux qui ont déjà menti à l'un(e) d'entre vous prennent " +
                  littleRandomGulp(),
        },
        {
          "title": "DEAD",
          "text": player_1() + " fini le verre de " + player_2(),
        },
        {
          "title": "NAME IT",
          "text": "Vous devez nommer le plus de " +
              randomAlcool() +
              " que vous connaissez à tour de rôle !\nLe/la perdant(e) prend " +
              littleRandomGulp() +
              ".\n" +
              player_1() +
              ", tu commences !",
        },
        {
          "title": "VOTE",
          "text":
              "Désignez tous ensemble la personne ayant eu le plus d'ex qui devra prendre " +
                  bigRandomGulp(),
        },
        {
          "title": "DEAD",
          "text": "Tout le monde fini son verre",
        },
        {
          "title": "NAME IT",
          "text":
              "Vous devez nommer le plus de marque de vêtements que vous connaissez à tour de rôle !\nLe/la perdant(e) prend " +
                  littleRandomGulp() +
                  ".\n" +
                  player_1() +
                  ", tu commences !",
        },
        {
          "title": "NAME IT",
          "text":
              "Vous devez nommer le plus de bar de votre ville que vous connaissez à tour de rôle !\nLe/la perdant(e) prend " +
                  littleRandomGulp() +
                  ".\n" +
                  player_1() +
                  ", tu commences !",
        },
        {
          "title": "GAME",
          "text": player_1() +
              " VS " +
              player_2() +
              "\n\nBras de fer chinois entre vous.\nLe perdant doit boire un verre fait par le vainqueur",
        },
        {
          "title": "TIME",
          "text": "Toutes les futures gorgées seront distribuées à " +
              player_1() +
              " pendant " +
              middleRandomTime(),
        },
        {
          "title": "VOTE",
          "text": "Votez tous pour savoir si " +
              player_1() +
              " à soif.\nSi les " +
              randomminorityOrMajority() +
              " l'emportent, il/elle prend " +
              littleRandomGulp(),
        },
        {
          "title": "DEAD",
          "text": "Toutes les personnes qui ont 2x le numéro \"" +
              randomNumberStart() +
              "\" dans leur téléphone, doivent prendre 1 cul sec",
        },
        {
          "title": "TIME",
          "text": player_1() +
              " tu échanges de prénom avec " +
              player_2() +
              " pendant " +
              middleRandomTime() +
              ".\nSi une personne se trompe elle prend " +
              littleRandomGulp(),
        },
        {
          "title": "GAME",
          "text":
              "Téléphone arabe !\n\nChacun votre tour ajoutez une suite à \"" +
                  randomSecondModeGame() +
                  "\"\nLa première personne qui se trompe prend " +
                  bigRandomGulp() +
                  ".\n" +
                  player_1() +
                  ", tu commences !",
        },
        {
          "title": "GAME",
          "text": player_1() +
              " pense à une personne du groupe et " +
              player_2() +
              " doit deviner qui c'est.\n3 questions max autorisées.\nSi il/elle trouve qui s'est tu prends " +
              bigRandomGulp() +
              ", sinon c'est pour toi",
        },
        {
          "title": "TIME",
          "text": player_1() +
              " double ses gorgées !\nPendant " +
              middleRandomTime(),
        },
        {
          "title": "GAME",
          "text": player_1() +
              " et " +
              player_2() +
              " font un \"je te tiens par la barbichette\".\nLe premier qui rigole prend " +
              littleRandomGulp(),
        },
        {
          "title": "DEAD",
          "text":
              "La personne à la droite de celle qui tien le portable donne 1 cul sec",
        },
        {
          "title": "TIME",
          "text": player_1() +
              " devient le détenteur du téléphone pendant " +
              middleRandomTime(),
        },
        {
          "title": "DEAD",
          "text": "Le détenteur du téléphone prend 1 cul sec",
        },
        {
          "title": "NAME IT",
          "text":
              "Vous devez nommer le plus de marque de voiture que vous connaissez à tour de rôle !\nLe/la perdant(e) prend " +
                  littleRandomGulp() +
                  ".\n" +
                  player_1() +
                  ", tu commences !",
        },
        {
          "title": "NAME IT",
          "text":
              "Vous devez nommer le plus de restaurant dans la ville que vous connaissez à tour de rôle !\nLe/la perdant(e) prend " +
                  littleRandomGulp() +
                  ".\n" +
                  player_1() +
                  ", tu commences !",
        },
        {
          "title": "VOTE",
          "text": "Votez pour le/la meilleur(e) " +
              randomAlcool() +
              ".\nS'il y aux moins 2 réponses identiques les autres prennent " +
              littleRandomGulp(),
        },
        {
          "title": "VOTE",
          "text": player_1() +
              " et " +
              player_2() +
              "\n\nMettez-vous d'accord sur 1 personne, elle devra faire le gage de votre choix ou prendre " +
              littleRandomGulp(),
        },
        {
          "title": "TIME",
          "text": "La personne la plus " +
              randomLittleOrBig() +
              " devient roi/reine !\nElle double le nombre de gorgées pendant " +
              middleRandomTime(),
        },
      ];

      // foreach list
      List temp = [];

      // remove element already exist
      for (var element in secondModeContentRecovery) {
        if (!secondModeContent.contains(element)) {
          temp.add(element);
        }
      }

      // clear list
      secondModeContent.clear();

      // add new action in temp array
      secondModeContent.addAll(temp);
    });
  }

  // insert a new personnal action
  void addAction() {
    setState(() {
      // form validation
      if (_formKey.currentState!.validate()) {
        secondModeContent.add({
          "title": "NEW",
          "text": player_1() +
              ", " +
              secondContentNewData.text +
              randomGiveOrDone() +
              randomGulp(),
        });
      }
      // reset text field
      secondContentNewData.clear();
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
                                  controller: secondContentNewData,
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
