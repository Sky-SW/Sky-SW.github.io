import 'package:Drinkeep/screens/welcome.dart';
import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// laucnh application
void main() {
  // set device orientation
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  // laucnh application
  runApp(const Drinkeep());
}

// stateless widget
class Drinkeep extends StatelessWidget {
  const Drinkeep({Key? key}) : super(key: key);

  // This widget is for root of your application.
  @override
  Widget build(BuildContext context) {
    return AdaptiveTheme(
      // define theme setting
      light: ThemeData(
        brightness: Brightness.light,
        primarySwatch: Colors.indigo,
      ),
      dark: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.purple,
      ),
      initial: AdaptiveThemeMode.light,
      builder: (theme, darkTheme) => MaterialApp(
        // hide debug banner
        debugShowCheckedModeBanner: false,
        // theme mode
        theme: theme,
        darkTheme: darkTheme,
        // application title
        title: 'Drinkeep',
        // Screen entry
        home: const WelcomeScreen(),
      ),
    );
  }
}
