import 'package:flutter/material.dart';

class FCRotatingThreeCircle extends StatefulWidget {
  final Duration duration;
  final List<Color> colorSet;
  final double circleHeight;
  final double circleWidth;

  const FCRotatingThreeCircle({
    Key? key,
    this.duration = const Duration(milliseconds: 1500),
    this.colorSet = const [
      Color(0xFFF4B400),
      Color(0xFFDB4437),
      Color(0xFF0F9D58),
    ],
    this.circleHeight = 15,
    this.circleWidth = 15,
  }) : super(key: key);

  @override
  _FCRotatingThreeCircleState createState() => _FCRotatingThreeCircleState();
}

class _FCRotatingThreeCircleState extends State<FCRotatingThreeCircle>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  late Animation<Offset> _positionSequence1;
  late Animation<Offset> _positionSequence2;
  late Animation<Offset> _positionSequence3;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: widget.duration,
      vsync: this,
    );

    CurvedAnimation _controllerAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.linear,
    );

    _positionSequence1 = TweenSequence<Offset>([
      TweenSequenceItem(
          tween: Tween<Offset>(
              begin: const Offset(-1, -1), end: const Offset(1, -1)),
          weight: 33.33),
      TweenSequenceItem(
          tween: Tween<Offset>(
              begin: const Offset(1, -1), end: const Offset(0, 1)),
          weight: 33.33),
      TweenSequenceItem(
          tween: Tween<Offset>(
              begin: const Offset(0, 1), end: const Offset(-1, -1)),
          weight: 33.33),
    ]).animate(_controllerAnimation);

    _positionSequence2 = TweenSequence<Offset>([
      TweenSequenceItem(
          tween: Tween<Offset>(
              begin: const Offset(1, -1), end: const Offset(0, 1)),
          weight: 33.33),
      TweenSequenceItem(
          tween: Tween<Offset>(
              begin: const Offset(0, 1), end: const Offset(-1, -1)),
          weight: 33.33),
      TweenSequenceItem(
          tween: Tween<Offset>(
              begin: const Offset(-1, -1), end: const Offset(1, -1)),
          weight: 33.33),
    ]).animate(_controllerAnimation);

    _positionSequence3 = TweenSequence<Offset>([
      TweenSequenceItem(
          tween: Tween<Offset>(
              begin: const Offset(0, 1), end: const Offset(-1, -1)),
          weight: 33.33),
      TweenSequenceItem(
          tween: Tween<Offset>(
              begin: const Offset(-1, -1), end: const Offset(1, -1)),
          weight: 33.33),
      TweenSequenceItem(
          tween: Tween<Offset>(
              begin: const Offset(1, -1), end: const Offset(0.0, 1)),
          weight: 33.33),
    ]).animate(_controllerAnimation);

    _controller.repeat();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        height: 100,
        width: 100,
        child: Stack(
          alignment: Alignment.center,
          children: [
            SlideTransition(
              position: _positionSequence1,
              child: buildCicle(
                width: widget.circleWidth,
                height: widget.circleHeight,
                color: widget.colorSet[0],
              ),
            ),
            SlideTransition(
              position: _positionSequence2,
              child: buildCicle(
                width: widget.circleWidth,
                height: widget.circleHeight,
                color: widget.colorSet[1],
              ),
            ),
            SlideTransition(
              position: _positionSequence3,
              child: buildCicle(
                width: widget.circleWidth,
                height: widget.circleHeight,
                color: widget.colorSet[2],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildCicle({
    height,
    width,
    color,
  }) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
      ),
    );
  }
}
