import 'package:elnasser/constants/color_constant.dart';
import 'package:elnasser/models/colors_colors_value.dart';
import 'package:flutter/material.dart';

class RPSCustomPainter extends CustomPainter {
  RPSCustomPainter({required this.colorsInitialValue});

  ColorsInitialValue colorsInitialValue;
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint0 = Paint()
      ..color = ColorsConstant.getColorBackground5(colorsInitialValue)
      ..style = PaintingStyle.fill
      ..strokeWidth = 9.56;

    Path path0 = Path();
    path0.moveTo(0, size.height * 0.0021500);
    path0.lineTo(size.width * 0.0010000, size.height);
    path0.lineTo(size.width * 0.8010400, size.height * 0.9973000);
    path0.lineTo(size.width, size.height * 0.4990000);
    path0.lineTo(size.width * 0.8000000, size.height * 0.0050000);
    path0.lineTo(0, size.height * 0.0021500);
    path0.close();

    canvas.drawPath(path0, paint0);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
