import 'package:book_app/app/utils/constant/constant_color.dart';
import 'package:flutter/material.dart';

class ButtonArround extends StatelessWidget {
  final VoidCallback onTap;
  final String text;
  final double width, height, borderRadius;
  final Color colorBackground, colorText;
  final bool isLoading;
  final TextStyle textStyle;

  ButtonArround({
    @required this.onTap,
    this.text: "",
    this.height: 50,
    this.width: 125,
    this.borderRadius: 30,
    this.colorBackground: ConstantColor.accent,
    this.colorText: ConstantColor.white,
    this.isLoading: false,
    this.textStyle
  }) : assert(onTap != null);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          color: colorBackground,
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        child: Center(
          child: isLoading
              ? CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                )
              : Text(
                  text,
                  style: textStyle ??
                      TextStyle(
                        fontFamily: 'SF Pro Display',
                        fontSize: 17,
                        color: colorText,
                        letterSpacing: 0.0425,
                        fontWeight: FontWeight.w800,
                      ),
                  textAlign: TextAlign.center,
                ),
        ),
      ),
    );
  }
}
