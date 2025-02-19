import 'package:flutter/material.dart';
import 'dart:math';

class MyPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    // Center of the canvas
    final center = Offset(size.width / 2, size.height / 2);

    // Draw the gray background (base circle)
    canvas.drawCircle(
      center,
      85,
      Paint()
        ..style = PaintingStyle.stroke
        ..color = Colors.black12
        ..strokeWidth = 30,
    );

    // Save the current state of the canvas
    canvas.saveLayer(
      Rect.fromCenter(center: center, width: 200, height: 200),
      Paint(),
    );

    // Draw the light green progress (partial arc)
    canvas.drawArc(
      Rect.fromCenter(center: center, width: 170, height: 170),
      0, // Start angle in radians
      200 * pi / 180, // Sweep angle in radians
      false,
      Paint()
        ..style = PaintingStyle.stroke
        ..strokeCap = StrokeCap.round
        ..color = Colors.green[100]!
        ..strokeWidth = 30,
    );

    // Draw the dark green full circle with blending
    canvas.drawArc(
      Rect.fromCenter(center: center, width: 155, height: 155),
      0, // Start angle in radians
      2 * pi, // Full circle in radians
      false,
      Paint()
        ..style = PaintingStyle.stroke
        ..strokeCap = StrokeCap.round
        ..color = Colors.green
        ..strokeWidth = 15
        ..blendMode = BlendMode.srcIn,
    );

    // Restore the canvas to remove the layer effect
    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
