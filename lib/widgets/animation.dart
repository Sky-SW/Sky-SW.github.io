import 'package:flutter/material.dart';
import 'dart:async';

// Stateful widget to create a new animation
class DelayedAnimation extends StatefulWidget {
  // variables
  final Widget child;
  final int delay;

  // required for use this function
  // ignore: use_key_in_widget_constructors
  const DelayedAnimation({required this.delay, required this.child});

  @override
  _DelayedAnimationState createState() => _DelayedAnimationState();
}

class _DelayedAnimationState extends State<DelayedAnimation>
    with SingleTickerProviderStateMixin {
  // variables
  late AnimationController _controller;
  late Animation<Offset> _animOffset;

  // content
  @override
  void initState() {
    // use just one each screens
    super.initState();

    // animation controller setting
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );

    // curve animation / effect
    final curve = CurvedAnimation(
      parent: _controller,
      curve: Curves.decelerate,
    );

    // where animation start
    _animOffset = Tween<Offset>(
      begin: const Offset(0.0, -0.35),
      end: Offset.zero,
    ).animate(curve);

    // animation usage
    Timer(Duration(milliseconds: widget.delay), () {
      _controller.forward();
    });
  }

  // widget content
  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _controller,
      child: SlideTransition(
        position: _animOffset,
        child: widget.child,
      ),
    );
  }
}
