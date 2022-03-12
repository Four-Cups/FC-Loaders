// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';

class FCBallBounce extends StatefulWidget {
  final Color loaderBallColor;
  final Duration duration;
  const FCBallBounce({
    Key? key,
    this.loaderBallColor = Colors.white,
    this.duration = const Duration(milliseconds: 400),
  }) : super(key: key);

  @override
  _FCBallBounceState createState() => _FCBallBounceState();
}

class _FCBallBounceState extends State<FCBallBounce>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _animation1;
  late Animation<Offset> _animation2;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: widget.duration,
      vsync: this,
    )..repeat(reverse: true);

    _animation1 = Tween<Offset>(
      begin: const Offset(0, 0),
      end: const Offset(0, 5),
    ).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInSine),
    );

    _animation2 = Tween<Offset>(
      begin: const Offset(0, 10),
      end: const Offset(0, 5),
    ).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInSine),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  SlideTransition _buildBall({
    animation,
    double opacity = 1,
    double ball_width = 10.0,
    double ball_height = 10.0,
    Color ball_color = Colors.amber,
  }) {
    return SlideTransition(
      position: animation,
      child: Container(
        width: ball_width,
        height: ball_height,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(ball_height / 2),
          color: ball_color.withOpacity(opacity),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ClipRRect(
        child: Container(
          width: 100,
          height: 100,
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25),
            color: Colors.black,
          ),
          child: Column(
            children: [
              _buildBall(
                animation: _animation1,
                ball_color: widget.loaderBallColor,
              ),
              _buildBall(
                animation: _animation2,
                ball_color: widget.loaderBallColor,
                opacity: .4,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
