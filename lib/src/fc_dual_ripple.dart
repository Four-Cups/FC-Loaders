import 'package:fc_loaders/src/painter/fc_dual_ripple_painter.dart';
import 'package:flutter/material.dart';

class FCDualRipple extends StatefulWidget {
  final Color backgroundColor;
  final Color loaderColor;
  final Duration duration;
  final Curve curve1;
  final Curve curve2;

  const FCDualRipple({
    Key? key,
    this.backgroundColor = Colors.black,
    this.loaderColor = Colors.white,
    this.duration = const Duration(milliseconds: 700),
    this.curve1 = Curves.easeIn,
    this.curve2 = Curves.easeIn,
  }) : super(key: key);

  @override
  _FCDualRippleState createState() => _FCDualRippleState();
}

class _FCDualRippleState extends State<FCDualRipple>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation1;
  late Animation<double> _animation2;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: widget.duration,
    )
      ..addListener(() {
        setState(() {});
      })
      ..repeat(reverse: true);

    _animation1 = Tween<double>(begin: 1, end: 5).animate(
      CurvedAnimation(
        parent: _controller,
        curve: widget.curve1,
      ),
    );
    _animation2 = Tween<double>(begin: 5, end: 1).animate(
      CurvedAnimation(
        parent: _controller,
        curve: widget.curve2,
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
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
              painter: FCDualRipplePainter(
                _animation1,
                widget.loaderColor,
              ),
            ),
          ),
          SizedBox(
            width: 50,
            height: 50,
            child: CustomPaint(
              painter: FCDualRipplePainter(
                _animation2,
                widget.loaderColor.withOpacity(.4),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
