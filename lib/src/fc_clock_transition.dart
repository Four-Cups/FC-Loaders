import 'package:fc_loaders/src/enums/clock_animation_enum.dart';
import 'package:fc_loaders/src/painter/fc_clock_painter.dart';
import 'package:flutter/material.dart';

class FCClockTransition extends StatefulWidget {
  final ClockAnimateType type;
  final Color clockColor;
  final Color backgroundColor;
  final Duration duration;
  final double randomNoise;
  const FCClockTransition({
    Key? key,
    this.clockColor = Colors.white,
    this.backgroundColor = Colors.black,
    this.randomNoise = 10,
    this.duration = const Duration(milliseconds: 2000),
    this.type = ClockAnimateType.scale,
  }) : super(key: key);

  @override
  _FCClockTransitionState createState() => _FCClockTransitionState();
}

class _FCClockTransitionState extends State<FCClockTransition>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late AnimationController _scaleController;

  late Animation<double> _animation;
  late Animation<double> _scaleAnimation;
  late Animation<double> _translateAnimation;

  late bool _isTranslate;

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

    _scaleController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    )..repeat(reverse: true);

    _scaleAnimation =
        Tween<double>(begin: 0.5, end: 1).animate(_scaleController);

    _translateAnimation = Tween<double>(begin: -1, end: 1).animate(
      CurvedAnimation(
        parent: _scaleController,
        curve: Curves.easeInSine,
      ),
    );
    _isTranslate = (widget.type == ClockAnimateType.translation) ? true : false;
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
    _scaleController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        children: [
          Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              color: widget.backgroundColor,
              borderRadius: BorderRadius.circular(20),
            ),
          ),
          Positioned(
            left: 0,
            top: _isTranslate ? 20 * _translateAnimation.value : 0,
            child: Transform.scale(
              scale: _isTranslate ? 1 : _scaleAnimation.value,
              child: SizedBox(
                width: 100,
                height: 100,
                child: CustomPaint(
                  painter: FCClockPainter(
                    animation: _animation,
                    clockColor: widget.clockColor,
                    randomNoise: widget.randomNoise,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
