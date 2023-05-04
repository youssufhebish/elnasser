import 'package:flutter/material.dart';

//Copy this CustomPainter code to the Bottom of the File
class circle extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Path path_0 = Path();
    path_0.moveTo(size.width * 0.5000000, size.height * 0.01562500);
    path_0.cubicTo(
        size.width * 0.2324219,
        size.height * 0.01562500,
        size.width * 0.01562500,
        size.height * 0.2324219,
        size.width * 0.01562500,
        size.height * 0.5000000);
    path_0.cubicTo(
        size.width * 0.01562500,
        size.height * 0.7675781,
        size.width * 0.2324219,
        size.height * 0.9843750,
        size.width * 0.5000000,
        size.height * 0.9843750);
    path_0.cubicTo(
        size.width * 0.7675781,
        size.height * 0.9843750,
        size.width * 0.9843750,
        size.height * 0.7675781,
        size.width * 0.9843750,
        size.height * 0.5000000);
    path_0.cubicTo(
        size.width * 0.9843750,
        size.height * 0.2324219,
        size.width * 0.7675781,
        size.height * 0.01562500,
        size.width * 0.5000000,
        size.height * 0.01562500);
    path_0.close();

    Paint paint_0_fill = Paint()..style = PaintingStyle.fill;
    paint_0_fill.color = Colors.white10;
    canvas.drawPath(path_0, paint_0_fill);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
