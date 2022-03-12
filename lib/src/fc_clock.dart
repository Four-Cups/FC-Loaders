import 'package:fc_loaders/src/painter/fc_clock_painter.dart';
import 'package:flutter/material.dart';

class FCClock extends StatefulWidget {
  final Duration duration;
  final Color backgroundColor;
  final Color clockColor;
  final double randomNoise;
  const FCClock({
    Key? key,
    this.duration = const Duration(milliseconds: 3000),
    this.backgroundColor = Colors.black,
    this.clockColor = Colors.white,
    this.randomNoise = 10,
  }) : super(key: key);

  @override
  _FCClockState createState() => _FCClockState();
}

class _FCClockState extends State<FCClock> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

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
      ..repeat();

    _animation = Tween<double>(begin: 0, end: 60).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 100,
        height: 100,
        decoration: BoxDecoration(
          color: widget.backgroundColor,
          borderRadius: BorderRadius.circular(20),
        ),
        child: CustomPaint(
          painter: FCClockPainter(
            animation: _animation,
            clockColor: widget.clockColor,
            randomNoise: widget.randomNoise,
          ),
        ),
      ),
    );
  }
}
