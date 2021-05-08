import 'package:book_app/app/utils/constant/constant_color.dart';
import 'package:flutter/material.dart';

class ButtonGradient extends StatelessWidget {

  final VoidCallback onTap;
  final double width, height, fontSize, borderRadius;
  final List<Color> gradientColors;
  final Color shadowColor, textColor;
  final String text;

  ButtonGradient({
    @required this.onTap,
    this.width: 100,
    this.height: 30,
    this.fontSize: 13,
    this.borderRadius: 10,
    this.gradientColors: const [Color(0xff5aaabd), Color(0xff00ff81)],
    this.shadowColor: const Color(0x805abd8c),
    this.textColor: ConstantColor.white,
    this.text: "",
  }) : assert(onTap != null);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(borderRadius),
          gradient: LinearGradient(
            begin: Alignment(-1.0, -1.0),
            end: Alignment(1.9, 1.67),
            colors: gradientColors,
            stops: [0.0, 1.0],
          ),
          boxShadow: [
            BoxShadow(
              color: shadowColor,
              offset: Offset(0, 5),
              blurRadius: 15,
            ),
          ],
        ),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
              fontFamily: 'SF Pro Text',
              fontSize: 13,
              color: textColor,
              letterSpacing: 0.2,
            ),
          ),
        ),
      ),
    );
  }
}
