import 'dart:math';
import 'package:flutter/material.dart';

class FCRotatingSquare extends StatefulWidget {
  final double loaderSize;
  final Duration duration;
  final Color loaderColor;

  const FCRotatingSquare({
    Key? key,
    this.duration = const Duration(milliseconds: 1000),
    this.loaderSize = 30,
    this.loaderColor = Colors.white,
  }) : super(key: key);

  @override
  _FCRotatingSquareState createState() => _FCRotatingSquareState();
}

class _FCRotatingSquareState extends State<FCRotatingSquare>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    )
      ..addListener(() {
        setState(() {});
      })
      ..repeat();

    _animation = Tween<double>(begin: 0, end: 2 * pi).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Transform.rotate(
        angle: _animation.value,
        child: Container(
          width: widget.loaderSize,
          height: widget.loaderSize,
          decoration: BoxDecoration(
            color: widget.loaderColor,
            borderRadius: BorderRadius.circular(widget.loaderSize * 0.2),
          ),
        ),
      ),
    );
  }
}
