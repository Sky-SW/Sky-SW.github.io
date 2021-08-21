import 'package:Drinkeep/providers/playerGame.dart';
import 'package:Drinkeep/screens/categories.dart';
import 'package:Drinkeep/screens/welcome.dart';
import 'package:Drinkeep/widgets/background.dart';
import 'package:flutter/material.dart';
import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';

// player screen structure
class PlayerScreen extends StatelessWidget {
  const PlayerScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      extendBodyBehindAppBar: true,
      appBar: DrinkeepAppBar(),
      body: PlayerSection(),
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
                const WelcomeScreen(),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
              const begin = Offset(-1.0, 0.0);
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
class PlayerSection extends StatefulWidget {
  const PlayerSection({Key? key}) : super(key: key);

  @override
  State<PlayerSection> createState() => _PlayerSection();
}

class _PlayerSection extends State<PlayerSection> {
  // variables
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late bool darkmode;
  dynamic savedThemeMode;
  dynamic buttonColor;
  final playerName = TextEditingController();
  late FToast fToast;
  dynamic textColor;

  // initiate functions
  @override
  void initState() {
    super.initState();

    // set device orientation
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    // use toast
    fToast = FToast();
    fToast.init(context);

    // get current theme
    getCurrentTheme();
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
        buttonColor = const Color.fromRGBO(255, 21, 244, .5);
        textColor = const Color.fromRGBO(220, 247, 2, .5);
      });
    } else {
      setState(() {
        darkmode = false;
        buttonColor = const Color.fromRGBO(86, 40, 237, .5);
        textColor = const Color.fromRGBO(2, 147, 247, .5);
      });
    }
  }

  // toast setting
  void toast() {
    Widget toast = Container(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25.0),
        color: const Color.fromRGBO(255, 0, 0, .5),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(
            Icons.person_add_rounded,
            color: Colors.white,
          ),
          const SizedBox(
            width: 12.0,
          ),
          Text(
            "2 joueurs minimum",
            style: GoogleFonts.comfortaa(
              color: Colors.white,
              fontSize: 15,
            ),
          ),
        ],
      ),
    );

    // show toast
    fToast.showToast(
      // toast widget
      child: toast,
      // toast position
      gravity: ToastGravity.BOTTOM,
      // toast duration
      toastDuration: const Duration(seconds: 2),
    );
  }

  // widget content
  @override
  Widget build(BuildContext context) {
    return Background(
      child: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.only(
            top: 120,
            left: 30,
            right: 30,
            bottom: 20,
          ),
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.only(
                  bottom: 50,
                ),
                child: (playerList.length >= 2)
                    ? ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            primary: buttonColor,
                            shape: const CircleBorder(),
                            padding: const EdgeInsets.all(50)),
                        child: Text(
                          'JOUER',
                          style: GoogleFonts.balooChettan(
                            color: Colors.white,
                            fontSize: 20,
                            letterSpacing: 1.5,
                          ),
                        ),
                        onPressed: () {
                          Navigator.of(context).push(PageRouteBuilder(
                            pageBuilder:
                                (context, animation, secondaryAnimation) =>
                                    const CategoriesScreen(),
                            transitionsBuilder: (context, animation,
                                secondaryAnimation, child) {
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
                      )
                    : ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            primary: const Color.fromRGBO(192, 192, 192, .5),
                            shape: const CircleBorder(),
                            padding: const EdgeInsets.all(50)),
                        child: Text(
                          'JOUER',
                          style: GoogleFonts.balooChettan(
                            color: Colors.white,
                            fontSize: 20,
                            letterSpacing: 1.5,
                          ),
                        ),
                        onPressed: () => toast(),
                      ),
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
                          FocusScope.of(context).requestFocus(FocusNode());
                          bool integer = RegExp(r'^[0-9]+([\\,\\.][0-9]+)?$')
                              .hasMatch(value);
                          return integer ? "Numéro interdit" : null;
                        }
                      },
                      decoration: const InputDecoration(
                        hintText: 'Nom du joueur',
                        prefixIcon: Icon(Icons.account_circle_outlined),
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
              Container(
                padding: const EdgeInsets.fromLTRB(30, 50, 30, 20),
                // ignore: prefer_is_empty
                child: (playerList.length >= 1)
                    ? Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Joueurs",
                                textAlign: TextAlign.center,
                                style: GoogleFonts.balooChettan(
                                  color: Colors.grey,
                                  fontSize: 20,
                                ),
                              ),
                              Text(
                                "Retirer",
                                textAlign: TextAlign.center,
                                style: GoogleFonts.balooChettan(
                                  color: Colors.grey,
                                  fontSize: 20,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),
                          Column(
                            children: playerList.map((player) {
                              return SizedBox(
                                height: 50,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      player,
                                      style: GoogleFonts.comfortaa(
                                        color: Colors.grey,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w800,
                                      ),
                                    ),
                                    IconButton(
                                      onPressed: () {
                                        setState(() {
                                          playerList.remove(player);
                                        });
                                      },
                                      icon: const Icon(
                                        Icons.close,
                                        color: Colors.grey,
                                        size: 16,
                                      ),
                                    )
                                  ],
                                ),
                              );
                            }).toList(),
                          ),
                        ],
                      )
                    : Text(
                        "Attention, l'abus d'alcool est dangereux pour la santé",
                        textAlign: TextAlign.center,
                        style: GoogleFonts.comfortaa(
                          color: textColor,
                          fontSize: 16,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
