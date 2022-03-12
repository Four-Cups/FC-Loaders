import 'package:flutter/material.dart';

class FCRotatingPlane extends StatefulWidget {
  final Color color;
  final double size;
  final Duration duration;
  final Curve rotateCurveX;
  final Curve rotateCurveY;

  const FCRotatingPlane({
    Key? key,
    this.size = 25.0,
    this.color = const Color(0xFFF6A42A),
    this.duration = const Duration(milliseconds: 1000),
    this.rotateCurveX = Curves.easeIn,
    this.rotateCurveY = Curves.easeOut,
  }) : super(key: key);

  @override
  _FCRotatingPlaneState createState() => _FCRotatingPlaneState();
}

class _FCRotatingPlaneState extends State<FCRotatingPlane>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _rotateXAnimation;
  late Animation<double> _rotateYAnimation;

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

    _rotateXAnimation = Tween<double>(begin: 0.0, end: 180).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Interval(
          0,
          0.5,
          curve: widget.rotateCurveX,
        ),
      ),
    );

    _rotateYAnimation = Tween<double>(begin: 0, end: 180).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Interval(
          0.5,
          1,
          curve: widget.rotateCurveY,
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (BuildContext context, _) {
        return Center(
          child: Transform(
            transform: Matrix4.identity()
              ..rotateX(
                ((0 - _rotateXAnimation.value) * 0.0174533),
              )
              ..rotateY((0 - _rotateYAnimation.value) * 0.0174533),
            alignment: FractionalOffset.center,
            child: SizedBox.fromSize(
              size: Size.square(widget.size),
              child: DecoratedBox(
                decoration: BoxDecoration(
                  color: widget.color,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
