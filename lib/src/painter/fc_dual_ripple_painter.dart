import 'package:flutter/material.dart';

class FCDualRipplePainter extends CustomPainter {
  final Animation<double> animation;
  final Color _ringColor;

  FCDualRipplePainter(this.animation, this._ringColor);
  @override
  void paint(Canvas canvas, Size size) {
    Offset center = Offset(size.width / 2, size.height / 2);

    Paint circle1 = Paint()
      ..color = _ringColor
      ..isAntiAlias = true
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    canvas.drawCircle(
      center,
      5 * animation.value,
      circle1,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
