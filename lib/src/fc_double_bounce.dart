import 'package:fc_loaders/src/constants/themes.dart';
import 'package:flutter/material.dart';

class FCDoubleBounce extends StatefulWidget {
  final Color loaderColor;
  final Duration duration;
  final double loaderSize;
  final Curve loaderCurve;

  const FCDoubleBounce({
    Key? key,
    this.loaderColor = kPrimaryColor,
    this.duration = const Duration(milliseconds: 2000),
    this.loaderSize = 50,
    this.loaderCurve = Curves.easeInOutSine,
  }) : super(key: key);

  @override
  _FCDoubleBounceState createState() => _FCDoubleBounceState();
}

class _FCDoubleBounceState extends State<FCDoubleBounce>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation _animation;

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

    _animation = Tween<double>(begin: -1, end: 1).animate(
      CurvedAnimation(
        parent: _controller,
        curve: widget.loaderCurve,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        children: List.generate(2, (index) {
          return Transform.scale(
            scale: (1.0 - index - _animation.value.abs()).abs(),
            child: SizedBox.fromSize(
              size: Size.square(widget.loaderSize),
              child: DecoratedBox(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: widget.loaderColor.withOpacity(0.6),
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}
