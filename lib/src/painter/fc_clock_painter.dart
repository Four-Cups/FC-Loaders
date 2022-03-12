import 'dart:math';

import 'package:flutter/material.dart';

class FCClockPainter extends CustomPainter {
  final Animation<double> animation;
  final double randomNoise;
  final Color clockColor;
  FCClockPainter({
    required this.animation,
    this.clockColor = Colors.white,
    this.randomNoise = 10,
  });
  @override
  void paint(Canvas canvas, Size size) {
    double centerX = size.width / 2;
    double centerY = size.height / 2;

    Offset center = Offset(centerX, centerY);

    Paint borderedCircle = Paint()
      ..color = clockColor
      ..isAntiAlias = true
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    canvas.drawCircle(center, centerX * 0.4, borderedCircle);

    // Clock Center Dot
    canvas.drawCircle(center, 2, Paint()..color = clockColor);

    // Hour Calculation
    double hourX = centerX +
        size.width *
            0.15 *
            cos((((animation.value + randomNoise) % 60) * 30 +
                    animation.value * 0.5) *
                pi /
                180);
    double hourY = centerY +
        size.width *
            0.15 *
            sin((((animation.value + randomNoise) % 60) * 30 +
                    animation.value * 0.5) *
                pi /
                180);

    // Minute Calculation
    double minuteX =
        centerX + size.width * 0.1 * cos((animation.value * 6) * pi / 180);
    double minuteY =
        centerY + size.width * 0.1 * sin((animation.value * 6) * pi / 180);

    canvas.drawLine(
      center,
      Offset(hourX, hourY),
      Paint()
        ..color = clockColor
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2,
    );
    canvas.drawLine(
      center,
      Offset(minuteX, minuteY),
      Paint()
        ..color = clockColor
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
