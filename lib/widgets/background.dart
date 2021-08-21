import 'package:animated_background/animated_background.dart';
import 'package:flutter/material.dart';

// Stateful widget to insert animation background
class Background extends StatefulWidget {
  // variables
  final Widget child;

  // required for use this function
  // ignore: use_key_in_widget_constructors
  const Background({required this.child});

  @override
  _BackgroundState createState() => _BackgroundState();
}

class _BackgroundState extends State<Background> with TickerProviderStateMixin {
  @override
  // widget content
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedBackground(
        behaviour: BubblesBehaviour(),
        vsync: this,
        child: widget.child,
      ),
    );
  }
}
