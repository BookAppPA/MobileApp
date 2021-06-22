import 'package:flutter/material.dart';
//import 'package:flutter_svg/svg.dart';

class SplashScreenPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Container(
          height: 109,
          width: 100,
          child: FlutterLogo(),
         // child:
              /*SvgPicture.asset(
            "asset/bomb_splashscreen.svg",
            fit: BoxFit.contain,
          ),*/
             /* Image.asset(
            ConstantImage.bomb,
            fit: BoxFit.contain,
          ),*/
        ),
      ),
    );
  }
}
