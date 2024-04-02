import 'dart:math';

import 'package:flutter/material.dart';

import '../palette.dart';

class CameraBorderPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    const radius = 50.0;
    final height = size.height;
    final width = size.width;

    final paint = Paint()
      ..color = Palette.primaryColor
      ..strokeWidth = 8
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final path = Path()
      ..arcTo(
        Rect.fromCircle(
          center: const Offset(radius, radius),
          radius: radius,
        ),
        pi,
        pi / 2,
        true,
      )
      ..arcTo(
        Rect.fromCircle(
          center: Offset(width - radius, radius),
          radius: radius,
        ),
        0,
        -pi / 2,
        true,
      )
      ..arcTo(
        Rect.fromCircle(
          center: Offset(radius, height - radius),
          radius: radius,
        ),
        pi,
        -pi / 2,
        true,
      )
      ..arcTo(
        Rect.fromCircle(
          center: Offset(width - radius, height - radius),
          radius: radius,
        ),
        0,
        pi / 2,
        true,
      );
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CameraBorderPainter oldDelegate) => false;
}
