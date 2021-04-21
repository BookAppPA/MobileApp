import 'dart:io';
import 'package:book_app/app/utils/constant/constant_color.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomCircularProgress extends StatelessWidget {
  final Color color;
  final double radius;
  CustomCircularProgress({
    this.color: ConstantColor.background,
    this.radius: 10,
  });

  @override
  Widget build(BuildContext context) {
    if (Platform.isAndroid) {
      return Center(
        child: SizedBox(
          width: radius * 2,
          height: radius * 2,
          child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(color),
            ),
        ),
      );
    } else {
      return CupertinoActivityIndicator(radius: radius);
    }
  }
}
