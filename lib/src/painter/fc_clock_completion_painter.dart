import 'dart:math';
import 'package:flutter/material.dart';

class FCClockCompletionPainter extends CustomPainter {
  final Color loaderColor;

  late final Animation<double> animation;

  FCClockCompletionPainter({
    required this.animation,
    this.loaderColor = Colors.white,
  });
  @override
  void paint(Canvas canvas, Size size) {
    final strokeWidth = size.width * 0.08;
    final center = Offset(size.width / 2, size.height / 2);
    final radius = (size.width - strokeWidth) / 2;

    final foregroundPaint = Paint()
      ..isAntiAlias = true
      ..color = loaderColor;

    canvas.drawArc(
      Rect.fromCircle(
        center: center,
        radius: radius,
      ),
      -pi / 2,
      pi * animation.value,
      true,
      foregroundPaint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
