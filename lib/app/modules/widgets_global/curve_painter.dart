import 'package:book_app/app/utils/constant/constant_color.dart';
import 'package:flutter/material.dart';

class CurvePainter extends CustomPainter {
  final Color color;
  CurvePainter({this.color: ConstantColor.white});

  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint();
    paint.color = color;
    paint.style = PaintingStyle.fill;

    var path = Path();

    path.lineTo(0, size.height);
    path.quadraticBezierTo(
        size.width / 4, size.height - 20, size.width / 2, size.height - 10);
    path.quadraticBezierTo(
        3 / 4 * size.width, size.height, size.width, size.height - 15);
    path.lineTo(size.width, 0);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
