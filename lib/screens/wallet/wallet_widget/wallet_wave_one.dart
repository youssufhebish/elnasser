import 'package:flutter/material.dart';

class WaveOne extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint0 = Paint()
      ..color = Colors.white.withOpacity(.05)
      ..style = PaintingStyle.fill
      ..strokeWidth = 1;

    Path path0 = Path();
    path0.moveTo(size.width * 0.0002417, size.height * 0.6446429);
    path0.quadraticBezierTo(size.width * 0.2591000, size.height * 0.8398000,
        size.width * 0.4998833, size.height * 0.5004000);
    path0.quadraticBezierTo(size.width * 0.8197417, size.height * -0.0150571,
        size.width, size.height * 0.2180429);
    path0.lineTo(size.width, 0);
    path0.lineTo(size.width * 0.0005167, 0);
    path0.lineTo(size.width * 0.0003167, size.height * 0.6455000);

    canvas.drawPath(path0, paint0);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

// child: CustomPaint(
// size: Size(WIDTH,(WIDTH*0.5833333333333334).toDouble()), //You can Replace [WIDTH] with your desired width for Custom Paint and height will be calculated automatically
// painter: RPSCustomPainter(),
// ),
