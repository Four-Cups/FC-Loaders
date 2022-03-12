import 'package:fc_loaders/src/enums/loading_4_colors_ball_size_enum.dart';
import 'package:flutter/material.dart';

class FCLoading4Colors extends StatefulWidget {
  final ColorBallType type;
  final List<Color> colorSet;
  final Duration duration;
  const FCLoading4Colors({
    Key? key,
    this.type = ColorBallType.large,
    this.colorSet = const [
      Color(0xFF44E4FF),
      Color(0xFFA4C662),
      Color(0xFFDC4549),
      Color(0xFFFBB73A),
    ],
    this.duration = const Duration(milliseconds: 1000),
  }) : super(key: key);

  @override
  _FCLoading4ColorsState createState() => _FCLoading4ColorsState();
}

class _FCLoading4ColorsState extends State<FCLoading4Colors>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _heightAnimation1;
  late Animation<Offset> _heightAnimation2;
  late Animation<Offset> _heightAnimation3;
  late Animation<Offset> _heightAnimation4;

  late double sbWidth;
  late double ballSize;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: widget.duration,
    )..repeat();

    _heightAnimation1 = ballAnimationSequence().animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0, 0.37, curve: Curves.slowMiddle),
      ),
    );

    _heightAnimation2 = ballAnimationSequence().animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.185, 0.555, curve: Curves.slowMiddle),
      ),
    );

    _heightAnimation3 = ballAnimationSequence().animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.37, 0.74, curve: Curves.slowMiddle),
      ),
    );
    _heightAnimation4 = ballAnimationSequence().animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.55, 1, curve: Curves.slowMiddle),
      ),
    );
    ballSize = 20;
    sbWidth = 160;
    if (widget.type == ColorBallType.small) {
      sbWidth = 120;
      ballSize = 10;
    }
  }

  TweenSequence<Offset> ballAnimationSequence() {
    return TweenSequence([
      TweenSequenceItem<Offset>(
        tween: Tween<Offset>(
          begin: const Offset(0, 0),
          end: const Offset(0, -1.5),
        ),
        weight: 50,
      ),
      TweenSequenceItem<Offset>(
        tween: Tween<Offset>(
          begin: const Offset(0, -1.5),
          end: const Offset(0, 0),
        ),
        weight: 50,
      ),
    ]);
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: sbWidth,
        height: 80,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ColorBall(
                ballColor: widget.colorSet[0],
                animation: _heightAnimation1,
                ballSize: ballSize,
              ),
              ColorBall(
                ballColor: widget.colorSet[1],
                animation: _heightAnimation2,
                ballSize: ballSize,
              ),
              ColorBall(
                ballColor: widget.colorSet[2],
                animation: _heightAnimation3,
                ballSize: ballSize,
              ),
              ColorBall(
                ballColor: widget.colorSet[3],
                animation: _heightAnimation4,
                ballSize: ballSize,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ColorBall extends StatelessWidget {
  final Color ballColor;
  final double? ballSize;
  final Animation<Offset> animation;

  const ColorBall({
    Key? key,
    required this.ballColor,
    required this.animation,
    this.ballSize,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: animation,
      child: Container(
        height: ballSize,
        width: ballSize,
        decoration: BoxDecoration(
          color: ballColor,
          shape: BoxShape.circle,
        ),
      ),
    );
  }
}
