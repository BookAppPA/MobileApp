import 'package:book_app/app/utils/constant/constant_color.dart';
import 'package:flutter/material.dart';

class CurvePainter extends CustomPainter {

  final Color color;
  CurvePainter({this.color: ConstantColor.white});

  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint();
    paint.color = color;
    paint.style = PaintingStyle.fill; // Change this to fill

    var path = Path();

    /*path.moveTo(0, size.height * 0.32);
    path.quadraticBezierTo(
        size.width / 2, size.height / 2 - 10, size.width, size.height * 0.32);
    path.lineTo(size.width, 0);
    path.lineTo(0, 0);*/
    path.moveTo(0, size.height / 2);
    path.quadraticBezierTo(size.width / 3, -((size.height / 2)) + 100, size.width, size.height / 2);
    path.quadraticBezierTo(size.width * 0.6, -((size.height / 2)) + 100, size.width, size.height / 2);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}