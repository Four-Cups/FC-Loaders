import 'package:fc_loaders/src/constants/themes.dart';
import 'package:fc_loaders/src/tweens/bezier_tween.dart';
import 'package:flutter/material.dart';

class FCSunPlanet extends StatefulWidget {
  final Color sunColor;
  final Color planetColor;
  final Color spaceColor;
  final Duration duration;

  const FCSunPlanet({
    Key? key,
    this.sunColor = kPrimaryColor,
    this.planetColor = Colors.blue,
    this.spaceColor = Colors.black,
    this.duration = const Duration(milliseconds: 3000),
  }) : super(key: key);

  @override
  _FCSunPlanetState createState() => _FCSunPlanetState();
}

class _FCSunPlanetState extends State<FCSunPlanet>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation _planetAnimation;

  bool _isMiddle = false;
  bool _isStart = true;

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

    TweenSequence<Offset> _buildPlanetSequence() {
      return TweenSequence(
        <TweenSequenceItem<Offset>>[
          TweenSequenceItem<Offset>(
            tween: BezierTween(
              begin: const Offset(20, 60),
              control: const Offset(60, 60),
              end: const Offset(70, 30),
            ),
            weight: 1,
          ),
          TweenSequenceItem<Offset>(
            tween: BezierTween(
              begin: const Offset(70, 30),
              control: const Offset(30, 30),
              end: const Offset(20, 60),
            ),
            weight: 1,
          ),
        ],
      );
    }

    _planetAnimation = _buildPlanetSequence().animate(_controller);

    _controller.addListener(() {
      setState(() {
        if (_controller.value.toStringAsFixed(2) == '0.50') {
          _isMiddle = true;
          _isStart = false;
        }
        if (_controller.value.toStringAsFixed(2) == '0.10') {
          _isStart = true;
          _isMiddle = false;
        }
      });
    });

    _controller.repeat();
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
              borderRadius: BorderRadius.circular(20),
              color: widget.spaceColor,
            ),
          ),
          _isStart
              ? Container(
                  height: 30,
                  width: 30,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: widget.sunColor,
                  ),
                )
              : Container(
                  height: 30,
                  width: 30,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.transparent,
                  ),
                ),
          Positioned(
            top: _planetAnimation.value.dy,
            left: _planetAnimation.value.dx,
            child: Container(
              height: 10,
              width: 10,
              decoration: BoxDecoration(
                color: widget.planetColor,
                shape: BoxShape.circle,
              ),
            ),
          ),
          _isMiddle
              ? Container(
                  height: 30,
                  width: 30,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: widget.sunColor,
                  ),
                )
              : Container(
                  height: 30,
                  width: 30,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.transparent,
                  ),
                ),
        ],
      ),
    );
  }
}
