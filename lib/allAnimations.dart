import 'dart:async';

import 'package:flutter/material.dart';

//Widgets animation
class ShowUp extends StatefulWidget {
  final Widget child;
  final int delay;
  final Offset direction;

  // ignore: use_key_in_widget_constructors
  const ShowUp({
    required this.child,
    required this.delay,
    required this.direction,
  });

  @override
  _ShowUpState createState() => _ShowUpState();
}
class _ShowUpState extends State<ShowUp> with TickerProviderStateMixin {
  late AnimationController _animController;
  late Animation<Offset> _animOffset;

  @override
  void initState() {
    super.initState();

    _animController =
        AnimationController(vsync: this, duration: const Duration(milliseconds: 500));
    final curve =
    CurvedAnimation(curve: Curves.decelerate, parent: _animController);
    _animOffset =
        Tween<Offset>(begin: widget.direction, end: Offset.zero)
            .animate(curve);

    // ignore: unnecessary_null_comparison
    if (widget.delay == null) {
      _animController.forward();
    } else {
      Timer(Duration(milliseconds: widget.delay), () {
        _animController.forward();
      });
    }
  }

  @override
  void dispose() {
    super.dispose();
    _animController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      child: SlideTransition(
        position: _animOffset,
        child: widget.child,
      ),
      opacity: _animController,
    );
  }
}

