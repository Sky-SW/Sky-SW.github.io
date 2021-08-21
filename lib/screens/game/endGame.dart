// ignore_for_file: file_names
import 'package:Drinkeep/screens/categories.dart';
import 'package:Drinkeep/widgets/animation.dart';
import 'package:Drinkeep/widgets/background.dart';
import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

// screen view
class EndGame extends StatelessWidget {
  const EndGame({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const EndGameContent();
  }
}

// screen content
class EndGameContent extends StatefulWidget {
  const EndGameContent({Key? key}) : super(key: key);

  @override
  _EndGameContentState createState() => _EndGameContentState();
}

class _EndGameContentState extends State<EndGameContent> {
  // variables
  late bool darkmode;
  dynamic savedThemeMode;
  dynamic color;
  dynamic textColor;

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

    // get current theme
    getCurrentTheme();
  }

  // when leave this screen
  @override
  void dispose() {
    // stop the orientation landscape
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    super.dispose();
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
    return Scaffold(
      body: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {
          Navigator.of(context).push(PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) =>
                const CategoriesScreen(),
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
        child: Background(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              DelayedAnimation(
                delay: 500,
                child: TextButton(
                  onPressed: () {
                    Navigator.of(context).push(PageRouteBuilder(
                      pageBuilder: (context, animation, secondaryAnimation) =>
                          const CategoriesScreen(),
                      transitionsBuilder:
                          (context, animation, secondaryAnimation, child) {
                        const begin = Offset(-1.0, 0.0);
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
                  style: ButtonStyle(
                    overlayColor: MaterialStateProperty.all(Colors.transparent),
                  ),
                  child: Text(
                    'Partie\nTerminée !',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.balooChettan(
                      color: color,
                      fontSize: 50,
                    ),
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
