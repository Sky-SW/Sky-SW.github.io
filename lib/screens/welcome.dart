import 'package:Drinkeep/widgets/animation.dart';
import 'package:Drinkeep/widgets/background.dart';
import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:Drinkeep/screens/player.dart';

// stateful widget creation
class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  State<WelcomeScreen> createState() => _WelcomeScreen();
}

class _WelcomeScreen extends State<WelcomeScreen>
    with TickerProviderStateMixin {
  // variables
  late bool darkmode;
  dynamic savedThemeMode;
  dynamic imgAdress;
  dynamic buttonColor;
  late final AnimationController _controller = AnimationController(
    duration: const Duration(seconds: 2),
    vsync: this,
  )..forward();
  late final Animation<double> _animation = CurvedAnimation(
    parent: _controller,
    curve: Curves.easeIn,
  );

  // initial state function
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
    return Background(
      child: FadeTransition(
        opacity: _animation,
        child: Container(
          margin: const EdgeInsets.only(
            top: 150,
            left: 30,
            right: 30,
            bottom: 20,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              DelayedAnimation(
                delay: 500,
                child: SizedBox(
                  height: 170,
                  child:
                      // ignore: unnecessary_null_comparison
                      imgAdress != null ? Image.asset(imgAdress) : Container(),
                ),
              ),
              Column(
                children: [
                  DelayedAnimation(
                    delay: 1500,
                    child: Text(
                      "Drinkeep",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.balooChettan(
                        color: Colors.grey,
                        fontSize: 30,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  DelayedAnimation(
                    delay: 2500,
                    child: Container(
                      margin: const EdgeInsets.only(
                        top: 10,
                      ),
                      child: Text(
                        "Se connaître un peu mieux autour d'un verre ou dix entre amis !",
                        textAlign: TextAlign.center,
                        style: GoogleFonts.comfortaa(
                          color: Colors.grey,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Column(
                children: [
                  DelayedAnimation(
                    delay: 3500,
                    child: Column(
                      children: [
                        SwitchListTile(
                          title: const Text('Mode Sombre'),
                          activeColor: const Color.fromRGBO(255, 21, 244, 0.5),
                          secondary: const Icon(Icons.nightlight_round),
                          value: darkmode,
                          onChanged: (bool value) {
                            if (value == true) {
                              AdaptiveTheme.of(context).setDark();
                              imgAdress = 'assets/iconApp/drinkeep_dark.png';
                              buttonColor =
                                  const Color.fromRGBO(255, 21, 244, .5);
                            } else {
                              AdaptiveTheme.of(context).setLight();
                              imgAdress = 'assets/iconApp/drinkeep_light.png';
                              buttonColor =
                                  const Color.fromRGBO(86, 40, 237, .5);
                            }
                            setState(() {
                              darkmode = value;
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                  DelayedAnimation(
                    delay: 4500,
                    child: Container(
                      margin: const EdgeInsets.only(
                        top: 30,
                      ),
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: buttonColor,
                          shape: const StadiumBorder(),
                          padding: const EdgeInsets.all(13),
                        ),
                        child: Text(
                          'COMMENCER',
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
                                    const PlayerScreen(),
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
