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
class FourModeScreen extends StatelessWidget {
  const FourModeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      extendBodyBehindAppBar: true,
      appBar: DrinkeepAppBar(),
      body: FourModeGame(),
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
List fourModeContent = [];

// screen widget content
class FourModeGame extends StatefulWidget {
  const FourModeGame({Key? key}) : super(key: key);

  @override
  _FourModeGameState createState() => _FourModeGameState();
}

class _FourModeGameState extends State<FourModeGame> {
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
    /// SHOT : Play with shot alcohol
    /// DEAD : Finished drink
    /// VOTE : All players vote to choose a looser or winner
    /// TIME : Impose the temp new rule
    /// ALL : All player questioned
    /// GAME : All players play
    /// TARGET : One player target
    /// VERITY : One player imposed one verity another player
    ///

    //  For validate  this  mode we need 40 content minimum

    // list mode four data content
    List fourModeContentRecovery = [
      {
        "title": "SHOT",
        "text": "Tous ceux qui ont déjà fini plus de " +
            bigRandom() +
            " verres, prennent 1 shot",
      },
      {
        "title": "SHOT",
        "text": "Tous ceux qui ont déjà bu 1 shot en reprennent 1",
      },
      {
        "title": "SHOT",
        "text": player_1() +
            " VS " +
            player_2() +
            "\nTchin de shot, celui qui en renverse le plus bois les 2",
      },
      {
        "title": "SHOT",
        "text": player_1() +
            " tu prépares autant de shot sur la table que d'alcool que vous avez puis numéroté les.\nChacun bois le shot ayant comme numéro le dernier de son numéro de téléphone (son 10e numéro).\nSi plusieurs d'entre vous ont le même, ce sera le numéro le plus fort qui le précède qui bois.",
      },
      {
        "title": "SHOT",
        "text":
            player_1() + " fait un shot pour " + player_2() + " qui le bois",
      },
      {
        "title": "TIME",
        "text": "On double absolument tout pendant " + middleRandomTime(),
      },
      {
        "title": "TIME",
        "text": player_1() +
            " est trop bourré(e), il/elle redistribue tout à la personne de son choix pendant " +
            middleRandomTime(),
      },
      {
        "title": "TIME",
        "text":
            "Faut se réveiller !\nDésormais pour chacun fin de verre 1 shot sera à boire en plus, pendant " +
                middleRandomTime(),
      },
      {
        "title": "TIME",
        "text": player_1() +
            " à l'air sobre, il/elle prend 1 gorgée dans un autre verre pendant " +
            middleRandomTime(),
      },
      {
        "title": "TIME",
        "text": player_1() +
            " devient " +
            randomHero() +
            ".\nToute personne se trompant prend 1 cul sec pendant " +
            middleRandomTime(),
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
        "text":
            "Et on repart tous de zéro, tout le monde remplit à nouveau son verre",
      },
      {
        "title": "DEAD",
        "text": player_1() + " distribue " + littleRandom() + " cul sec",
      },
      {
        "title": "DEAD",
        "text": player_1() +
            " VS " +
            player_2() +
            "\nCelui qui a le verre le moins rempli bois les 2.",
      },
      {
        "title": "VOTE",
        "text": "Votez tous pour le plus " +
            randomFourModeVote() +
            " d'entre vous.\nLes " +
            randomminorityOrMajority() +
            " prennent " +
            littleRandomGulp(),
      },
      {
        "title": "VOTE",
        "text":
            "Votez tous pour le plus alcoolique d'entre vous ! Il/Elle prendra " +
                bigRandomGulp(),
      },
      {
        "title": "VOTE",
        "text": "Votez pour le/la meilleur(e) " +
            randomAlcool() +
            ".\nLes " +
            randomminorityOrMajority() +
            " prennent " +
            littleRandomGulp(),
      },
      {
        "title": "VOTE",
        "text": player_1() +
            " et " +
            player_2() +
            "\n\nMettez-vous d'accord sur 1 personne, elle devra prendre " +
            littleRandomGulp(),
      },
      {
        "title": "VOTE",
        "text":
            "Chacun raconte une annecdote sur lui-même.\nVotez pour la meilleure qui distribuera " +
                bigRandomGulp(),
      },
      {
        "title": "ALL",
        "text": "Tout le monde à le droit de boire " + bigRandomGulp(),
      },
      {
        "title": "ALL",
        "text": "Tous ceux qui ont déjà conduit en chantant prennent " +
            littleRandomGulp(),
      },
      {
        "title": "ALL",
        "text": "Tous ceux qui aimes les " +
            randomFourModeAll() +
            " prennent " +
            littleRandomGulp(),
      },
      {
        "title": "ALL",
        "text":
            "Tous ceux qui ont déjà menti pour ne pas boire ce soir prennent " +
                bigRandomGulp(),
      },
      {
        "title": "ALL",
        "text": "Tous ceux qui ont un produit d'apple prennent " +
            littleRandomGulp(),
      },
      {
        "title": "GAME",
        "text": player_1() +
            " VS  " +
            player_2() +
            "\n\nPrenez un verre d'eau et remplissez le à ras bord.\nMettez-y chacun votre tour entre 1 à 3 pièces.\nLa personne qui fait déborder le verre à perdu et prend " +
            littleRandomGulp(),
      },
      {
        "title": "GAME",
        "text": player_1() +
            " choisit la personne de ton choix pour une action ou vérité.\nSi la personne choisie répond honnêtement ou réalise le gage tu prends " +
            littleRandomGulp() +
            ", sinon c'est pour elle.",
      },
      {
        "title": "GAME",
        "text": player_1() +
            " VS " +
            player_2() +
            "\n\nPile ou face !\nChoisissez chacun quelle partie de la pièce vous voulez.\nUne autre personne lance la pièce, en fonction du résultat celui dont la partie est sortie prend " +
            bigRandomGulp(),
      },
      {
        "title": "GAME",
        "text": "Blind test des bourrées !\n\n" +
            player_1() +
            " met une musique de ton choix (tu es immunisé), le premier qui trouve distribue " +
            bigRandomGulp(),
      },
      {
        "title": "GAME",
        "text": "Tout le monde ferme les yeux.\n" +
            player_1() +
            " prend 1 objet d'une personne présente.\nSi la personne trouve tu prends " +
            littleRandomGulp() +
            ", sinon c'est pour elle.",
      },
      {
        "title": "TARGET",
        "text": "La dernière personne à avoir bu doit reprendre la même chose",
      },
      {
        "title": "TARGET",
        "text": player_1() +
            " tu prendras les gorgées de la personne du prochain tour",
      },
      {
        "title": "TARGET",
        "text": player_1() +
            " raconte un dossier sur " +
            player_2() +
            " qui distribuera " +
            littleRandomGulp(),
      },
      {
        "title": "TARGET",
        "text": player_1() +
            " choisi la personne de ton choix et elle distribuera " +
            littleRandomGulp(),
      },
      {
        "title": "TARGET",
        "text": player_1() +
            " prépare 3 verres et les numérotes de 1 à 3.\n" +
            player_2() +
            " doit boire le numéro (a dire une fois les 3 verres faits) " +
            littleRandom(),
      },
      {
        "title": "VERITY",
        "text": player_1() +
            " combien de verre à tu finis ce soir ?\nSi tu te trompes tu prends " +
            littleRandomGulp(),
      },
      {
        "title": "VERITY",
        "text": player_1() +
            " quel est la chose la plus stupide que tu es faite ?\nTu distribueras " +
            littleRandomGulp(),
      },
      {
        "title": "VERITY",
        "text": player_1() +
            " quel est ton plus grand talent ?\nTu prends " +
            littleRandomGulp(),
      },
      {
        "title": "VERITY",
        "text": player_1() +
            " quel est le pire cadeau que tu es reçu ?\nTu distribueras " +
            littleRandomGulp(),
      },
      {
        "title": "VERITY",
        "text": "Chacun sort sa plus grosse insulte.\nLe perdant prend " +
            bigRandomGulp() +
            " (espèce de malpoli(e))",
      },
    ];

    // get current theme
    getCurrentTheme();

    // reset four mode array
    fourModeContent.clear();

    // reset end game array
    endGame.clear();

    // add data in fourModeContent list
    fourModeContent.addAll(fourModeContentRecovery);

    // get random data in array
    tempArray = fourModeContent[Random().nextInt(fourModeContent.length)];
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
      fourModeContent.remove(tempArray);

      // get a new random item in array
      tempArray = fourModeContent[Random().nextInt(fourModeContent.length)];

      // reject "TIME" after more 25 round
      if (tempArray['title'] == 'TIME' && endGame.length > 24) {
        // remove item in list
        fourModeContent.remove(tempArray);

        // get a new random item in array
        tempArray = fourModeContent[Random().nextInt(fourModeContent.length)];
      }

      // if have new action created
      for (var newAction in fourModeContent) {
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
  final fourContentNewData = TextEditingController();
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

      // list mode four data content
      List fourModeContentRecovery = [
        {
          "title": "SHOT",
          "text": "Tous ceux qui ont déjà fini plus de " +
              bigRandom() +
              " verres, prennent 1 shot",
        },
        {
          "title": "SHOT",
          "text": "Tous ceux qui ont déjà bu 1 shot en reprennent 1",
        },
        {
          "title": "SHOT",
          "text": player_1() +
              " VS " +
              player_2() +
              "\nTchin de shot, celui qui en renverse le plus bois les 2",
        },
        {
          "title": "SHOT",
          "text": player_1() +
              " tu prépares autant de shot sur la table que d'alcool que vous avez puis numéroté les.\nChacun bois le shot ayant comme numéro le dernier de son numéro de téléphone (son 10e numéro).\nSi plusieurs d'entre vous ont le même, ce sera le numéro le plus fort qui le précède qui bois.",
        },
        {
          "title": "SHOT",
          "text":
              player_1() + " fait un shot pour " + player_2() + " qui le bois",
        },
        {
          "title": "TIME",
          "text": "On double absolument tout pendant " + middleRandomTime(),
        },
        {
          "title": "TIME",
          "text": player_1() +
              " est trop bourré(e), il/elle redistribue tout à la personne de son choix pendant " +
              middleRandomTime(),
        },
        {
          "title": "TIME",
          "text":
              "Faut se réveiller !\nDésormais pour chacun fin de verre 1 shot sera à boire en plus, pendant " +
                  middleRandomTime(),
        },
        {
          "title": "TIME",
          "text": player_1() +
              " à l'air sobre, il/elle prend 1 gorgée dans un autre verre pendant " +
              middleRandomTime(),
        },
        {
          "title": "TIME",
          "text": player_1() +
              " devient " +
              randomHero() +
              ".\nToute personne se trompant prend 1 cul sec pendant " +
              middleRandomTime(),
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
          "text":
              "Et on repart tous de zéro, tout le monde remplit à nouveau son verre",
        },
        {
          "title": "DEAD",
          "text": player_1() + " distribue " + littleRandom() + " cul sec",
        },
        {
          "title": "DEAD",
          "text": player_1() +
              " VS " +
              player_2() +
              "\nCelui qui a le verre le moins rempli bois les 2.",
        },
        {
          "title": "VOTE",
          "text": "Votez tous pour le plus " +
              randomFourModeVote() +
              " d'entre vous.\nLes " +
              randomminorityOrMajority() +
              " prennent " +
              littleRandomGulp(),
        },
        {
          "title": "VOTE",
          "text":
              "Votez tous pour le plus alcoolique d'entre vous ! Il/Elle prendra " +
                  bigRandomGulp(),
        },
        {
          "title": "VOTE",
          "text": "Votez pour le/la meilleur(e) " +
              randomAlcool() +
              ".\nLes " +
              randomminorityOrMajority() +
              " prennent " +
              littleRandomGulp(),
        },
        {
          "title": "VOTE",
          "text": player_1() +
              " et " +
              player_2() +
              "\n\nMettez-vous d'accord sur 1 personne, elle devra prendre " +
              littleRandomGulp(),
        },
        {
          "title": "VOTE",
          "text":
              "Chacun raconte une annecdote sur lui-même.\nVotez pour la meilleure qui distribuera " +
                  bigRandomGulp(),
        },
        {
          "title": "ALL",
          "text": "Tout le monde à le droit de boire " + bigRandomGulp(),
        },
        {
          "title": "ALL",
          "text": "Tous ceux qui ont déjà conduit en chantant prennent " +
              littleRandomGulp(),
        },
        {
          "title": "ALL",
          "text": "Tous ceux qui aimes les " +
              randomFourModeAll() +
              " prennent " +
              littleRandomGulp(),
        },
        {
          "title": "ALL",
          "text":
              "Tous ceux qui ont déjà menti pour ne pas boire ce soir prennent " +
                  bigRandomGulp(),
        },
        {
          "title": "ALL",
          "text": "Tous ceux qui ont un produit d'apple prennent " +
              littleRandomGulp(),
        },
        {
          "title": "GAME",
          "text": player_1() +
              " VS  " +
              player_2() +
              "\n\nPrenez un verre d'eau et remplissez le à ras bord.\nMettez-y chacun votre tour entre 1 à 3 pièces.\nLa personne qui fait déborder le verre à perdu et prend " +
              littleRandomGulp(),
        },
        {
          "title": "GAME",
          "text": player_1() +
              " choisit la personne de ton choix pour une action ou vérité.\nSi la personne choisie répond honnêtement ou réalise le gage tu prends " +
              littleRandomGulp() +
              ", sinon c'est pour elle.",
        },
        {
          "title": "GAME",
          "text": player_1() +
              " VS " +
              player_2() +
              "\n\nPile ou face !\nChoisissez chacun quelle partie de la pièce vous voulez.\nUne autre personne lance la pièce, en fonction du résultat celui dont la partie est sortie prend " +
              bigRandomGulp(),
        },
        {
          "title": "GAME",
          "text": "Blind test des bourrées !\n\n" +
              player_1() +
              " met une musique de ton choix (tu es immunisé), le premier qui trouve distribue " +
              bigRandomGulp(),
        },
        {
          "title": "GAME",
          "text": "Tout le monde ferme les yeux.\n" +
              player_1() +
              " prend 1 objet d'une personne présente.\nSi la personne trouve tu prends " +
              littleRandomGulp() +
              ", sinon c'est pour elle.",
        },
        {
          "title": "TARGET",
          "text":
              "La dernière personne à avoir bu doit reprendre la même chose",
        },
        {
          "title": "TARGET",
          "text": player_1() +
              " tu prendras les gorgées de la personne du prochain tour",
        },
        {
          "title": "TARGET",
          "text": player_1() +
              " raconte un dossier sur " +
              player_2() +
              " qui distribuera " +
              littleRandomGulp(),
        },
        {
          "title": "TARGET",
          "text": player_1() +
              " choisi la personne de ton choix et elle distribuera " +
              littleRandomGulp(),
        },
        {
          "title": "TARGET",
          "text": player_1() +
              " prépare 3 verres et les numérotes de 1 à 3.\n" +
              player_2() +
              " doit boire le numéro (a dire une fois les 3 verres faits) " +
              littleRandom(),
        },
        {
          "title": "VERITY",
          "text": player_1() +
              " combien de verre à tu finis ce soir ?\nSi tu te trompes tu prends " +
              littleRandomGulp(),
        },
        {
          "title": "VERITY",
          "text": player_1() +
              " quel est la chose la plus stupide que tu es faite ?\nTu distribueras " +
              littleRandomGulp(),
        },
        {
          "title": "VERITY",
          "text": player_1() +
              " quel est ton plus grand talent ?\nTu prends " +
              littleRandomGulp(),
        },
        {
          "title": "VERITY",
          "text": player_1() +
              " quel est le pire cadeau que tu es reçu ?\nTu distribueras " +
              littleRandomGulp(),
        },
        {
          "title": "VERITY",
          "text": "Chacun sort sa plus grosse insulte.\nLe perdant prend " +
              bigRandomGulp() +
              " (espèce de malpoli(e))",
        },
      ];

      // foreach list
      List temp = [];

      // remove element already exist
      for (var element in fourModeContentRecovery) {
        if (!fourModeContent.contains(element)) {
          temp.add(element);
        }
      }

      // clear list
      fourModeContent.clear();

      // add new action in temp array
      fourModeContent.addAll(temp);
    });
  }

  // insert a new personnal action
  void addAction() {
    setState(() {
      // form validation
      if (_formKey.currentState!.validate()) {
        fourModeContent.add({
          "title": "NEW",
          "text": player_1() +
              ", " +
              fourContentNewData.text +
              randomGiveOrDone() +
              randomGulp(),
        });
      }
      // reset text field
      fourContentNewData.clear();
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
                                  controller: fourContentNewData,
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
