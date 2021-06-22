import 'package:book_app/app/utils/constant/constant_image.dart';
import 'package:flutter/material.dart';

class SplashScreenPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          height: 100,
          width: 100,
          child: Image.asset(
            ConstantImage.logo,
            fit: BoxFit.contain,
          ),
        ),
      ),
    );
  }
}
