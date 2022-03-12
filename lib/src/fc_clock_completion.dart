import 'package:fc_loaders/src/painter/fc_clock_completion_painter.dart';
import 'package:flutter/material.dart';

class FCClockCompletion extends StatefulWidget {
  final Color backgroundColor;
  final Color loaderColor;
  final Duration duration;
  final Curve curve;
  const FCClockCompletion({
    Key? key,
    this.backgroundColor = Colors.black,
    this.loaderColor = Colors.white,
    this.duration = const Duration(milliseconds: 2000),
    this.curve = Curves.linearToEaseOut,
  }) : super(key: key);

  @override
  _FCClockCompletionState createState() => _FCClockCompletionState();
}

class _FCClockCompletionState extends State<FCClockCompletion>
    with SingleTickerProviderStateMixin {
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
    _animation = Tween<double>(begin: 0, end: 2).animate(
      CurvedAnimation(
        parent: _controller,
        curve: widget.curve,
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
        alignment: Alignment.center,
        children: [
          Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              color: widget.backgroundColor,
              borderRadius: BorderRadius.circular(20),
            ),
          ),
          SizedBox(
            width: 50,
            height: 50,
            child: CustomPaint(
              painter: FCClockCompletionPainter(
                animation: _animation,
                loaderColor: widget.loaderColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
