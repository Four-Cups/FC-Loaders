import 'package:fc_loaders/src/tweens/bezier_tween.dart';
import 'package:flutter/material.dart';

class FCCurvedBallBounce extends StatefulWidget {
  final Duration duration;
  final Color loaderBallColor;
  const FCCurvedBallBounce({
    Key? key,
    this.duration = const Duration(milliseconds: 700),
    this.loaderBallColor = Colors.white,
  }) : super(key: key);

  @override
  _FCCurvedBallBounceState createState() => _FCCurvedBallBounceState();
}

class _FCCurvedBallBounceState extends State<FCCurvedBallBounce>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation _motionTween;

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

    _motionTween = BezierTween(
      begin: const Offset(30, 60),
      control: const Offset(40, 0),
      end: const Offset(60, 60),
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.linear,
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
    return Center(
      child: Stack(
        children: [
          Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.black,
            ),
          ),
          Positioned(
            left: _motionTween.value.dx,
            top: _motionTween.value.dy,
            child: Container(
              height: 10,
              width: 10,
              decoration: BoxDecoration(
                color: widget.loaderBallColor,
                borderRadius: BorderRadius.circular(5),
              ),
            ),
          ),
          Positioned(
            left: _motionTween.value.dx,
            bottom: _motionTween.value.dy - 40,
            child: Container(
              height: 10,
              width: 10,
              decoration: BoxDecoration(
                color: widget.loaderBallColor.withOpacity(.4),
                borderRadius: BorderRadius.circular(5),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
