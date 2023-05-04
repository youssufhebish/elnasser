import 'package:flutter/material.dart';

class WaveTwo extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint0 = Paint()
      ..color = Colors.white.withOpacity(.05)
      ..style = PaintingStyle.fill
      ..strokeWidth = 1;

    Path path0 = Path();
    path0.moveTo(0, size.height * 0.2824286);
    path0.cubicTo(
        size.width * 0.5417583,
        size.height * 0.2862143,
        size.width * 0.4601833,
        size.height * 0.7836429,
        size.width * 0.6689083,
        size.height * 0.7844143);
    path0.cubicTo(
        size.width * 0.8709583,
        size.height * 0.7828143,
        size.width * 0.9171667,
        size.height * 0.2111571,
        size.width,
        size.height * 0.2180429);
    path0.quadraticBezierTo(size.width, size.height * 0.1635321, size.width, 0);
    path0.lineTo(size.width * 0.0005167, 0);
    path0.lineTo(0, size.height * 0.2135714);
    path0.lineTo(0, size.height * 0.2121143);
    path0.quadraticBezierTo(
        0, size.height * 0.2296929, 0, size.height * 0.2824286);
    path0.close();

    canvas.drawPath(path0, paint0);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
