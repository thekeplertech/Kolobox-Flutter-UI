import 'dart:math';

import 'package:flutter/material.dart';
import 'package:kolobox_new_app/core/colors/color_list.dart';

class RangeCustomPainter extends CustomPainter {
  RangeCustomPainter({
    this.backColor = ColorList.greyLight8Color,
    this.selectedColor = ColorList.redDark2Color,
    this.duration = 90,
    this.progress = 0,
  });

  int progress, duration;
  final Color backColor, selectedColor;

  @override
  void paint(Canvas canvas, Size size) {
    Paint backPaint = Paint()
      ..color = backColor
      ..strokeWidth = 3
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;

    Paint selectedPaint = Paint()
      ..color = selectedColor
      ..strokeWidth = 3
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;

    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2;

    canvas.drawCircle(center, radius, backPaint);

    final rect = Rect.fromCircle(center: center, radius: radius);
    const startAngle = 0.0;
    final sweepAngle =
        (6.30 * progress) / duration; //6.2 , 6.2*duration/progress
    const useCenter = false;

    canvas.drawArc(rect, startAngle, sweepAngle, useCenter, selectedPaint);
  }

  double getXCoordinates(Offset center, double radius, double degree) =>
      center.dx + radius * cos((degree - 90) * pi / 180);

  double getYCoordinates(Offset center, double radius, double degree) =>
      center.dy + radius * sin((degree - 90) * pi / 180);

  @override
  bool shouldRepaint(RangeCustomPainter oldDelegate) => false;
}
