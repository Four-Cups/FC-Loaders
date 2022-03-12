import 'dart:math';

import 'package:fc_loaders/src/constants/themes.dart';
import 'package:flutter/material.dart';

class FCRotatingMorph extends StatefulWidget {
  final Color loaderColor;
  final Duration duration;
  final double loaderSize;

  const FCRotatingMorph({
    Key? key,
    this.loaderColor = kPrimaryColor,
    this.duration = const Duration(milliseconds: 700),
    this.loaderSize = 20,
  }) : super(key: key);

  @override
  _FCRotatingMorphState createState() => _FCRotatingMorphState();
}

class _FCRotatingMorphState extends State<FCRotatingMorph>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _borderRadiusAnimation;
  late Animation<double> _scaleAnimation;
  late Animation<double> _rotateAnimation;

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: widget.duration,
      vsync: this,
    )
      ..addListener(() {
        setState(() {});
      })
      ..repeat(reverse: true);

    _borderRadiusAnimation =
        Tween<double>(begin: 0, end: 1).animate(_controller);
    _scaleAnimation =
        Tween<double>(begin: widget.loaderSize * 2, end: widget.loaderSize)
            .animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInExpo,
      ),
    );
    _rotateAnimation =
        Tween<double>(begin: 0, end: 2 * pi).animate(_controller);
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Transform.rotate(
        angle: _rotateAnimation.value,
        child: Container(
          width: _scaleAnimation.value,
          height: _scaleAnimation.value,
          decoration: BoxDecoration(
            color: widget.loaderColor,
            borderRadius: BorderRadius.circular(
              _borderRadiusAnimation.value * widget.loaderSize,
            ),
          ),
        ),
      ),
    );
  }
}
