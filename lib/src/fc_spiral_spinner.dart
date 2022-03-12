import 'package:flutter/material.dart';

class FCSpiralSpinner extends StatefulWidget {
  final Duration duration;
  const FCSpiralSpinner({
    Key? key,
    this.duration = const Duration(milliseconds: 4500),
  }) : super(key: key);

  @override
  _FCSpiralSpinnerState createState() => _FCSpiralSpinnerState();
}

class _FCSpiralSpinnerState extends State<FCSpiralSpinner>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: widget.duration,
      vsync: this,
    )..repeat();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: RotationTransition(
        turns: _controller,
        child: Container(
          width: 50,
          height: 50,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            image: DecorationImage(
              image: AssetImage('spiral_loader.png'),
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }
}
