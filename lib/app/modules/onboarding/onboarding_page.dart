import 'package:book_app/app/routes/app_pages.dart';
import 'package:book_app/app/utils/constant/constant_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:introduction_screen/introduction_screen.dart';

class OnBoardingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return IntroductionScreen(
      globalBackgroundColor: ConstantColor.background,
      onDone: () => print("finish"),//Get.toNamed(Routes.AUTH),
      showDoneButton: true,
      showNextButton: false,
      curve: Curves.fastLinearToSlowEaseIn,
      controlsMargin: EdgeInsets.all(16),
      dotsDecorator: DotsDecorator(
        size: Size(10.0, 10.0),
        color: Color(0xFFBDBDBD),
        activeSize: Size(11.0, 10.0),
      ),
      done: Text("COMPRIS"),
      pages: [
        PageViewModel(
          reverse: true,
          titleWidget: Column(
            children: <Widget>[
              SizedBox(height: 50),
              Text(
                  "Déniche de nouvelles pépites ",
                  style: TextStyle(
                    fontFamily: 'Roboto',
                    fontSize: 30,
                    color: ConstantColor.accent,
                    letterSpacing: 0.3,
                    fontWeight: FontWeight.w900,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 25),
                Text(
                  "Découvre de nouveaux livres à travers de nombreux avis ",
                  style: TextStyle(
                    fontFamily: 'Helvetica-Normal',
                    fontSize: 14,
                    color: ConstantColor.accent,
                    letterSpacing: 0.14,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 75),
            ],
          ),
          bodyWidget: _buildImage('onboarding_1.svg'),
        ),
        PageViewModel(
          titleWidget: Column(
            children: <Widget>[
              SizedBox(height: 50),
              Text(
                  "Partage ton avis",
                  style: TextStyle(
                    fontFamily: 'Roboto',
                    fontSize: 30,
                    color: ConstantColor.accent,
                    letterSpacing: 0.3,
                    fontWeight: FontWeight.w900,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 25),
                Text(
                  "Donne ton avis sur ta bibliothèque personnelle ",
                  style: TextStyle(
                    fontFamily: 'Helvetica-Normal',
                    fontSize: 14,
                    color: ConstantColor.accent,
                    letterSpacing: 0.14,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 50),
            ],
          ),
          bodyWidget: _buildImage('onboarding_2.svg'),
        ),
      ],
    );
  }

  Widget _buildImage(String assetName, [double width = 350]) {
    return SvgPicture.asset('assets/$assetName', width: width);
  }
}
