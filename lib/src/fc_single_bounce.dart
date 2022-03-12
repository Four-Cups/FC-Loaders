import 'package:fc_loaders/src/constants/themes.dart';
import 'package:flutter/material.dart';

class FCSingleBounce extends StatefulWidget {
  final bool isRipple;
  final Duration duration;
  final double size;
  final Color color;
  final Curve curve;
  final Curve rippleCurve;

  const FCSingleBounce({
    Key? key,
    this.isRipple = true,
    this.duration = const Duration(milliseconds: 700),
    this.size = 50,
    this.color = kPrimaryColor,
    this.curve = Curves.easeOut,
    this.rippleCurve = Curves.easeOut,
  }) : super(key: key);

  @override
  _FCSingleBounceState createState() => _FCSingleBounceState();
}

class _FCSingleBounceState extends State<FCSingleBounce>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  late Animation<double> _opacityAnimation;

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
      ..repeat(reverse: widget.isRipple ? false : true);

    _animation = Tween<double>(begin: 0.2, end: 1).animate(
      CurvedAnimation(
        parent: _controller,
        curve: widget.curve,
      ),
    );

    if (widget.isRipple) {
      _opacityAnimation = Tween<double>(begin: 1, end: 0).animate(
        CurvedAnimation(
          parent: _controller,
          curve: widget.rippleCurve,
        ),
      );
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Opacity(
        opacity: widget.isRipple ? _opacityAnimation.value : 1,
        child: ScaleTransition(
          scale: _animation,
          child: SizedBox.fromSize(
            size: Size.square(widget.size),
            child: DecoratedBox(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: widget.color,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
