import 'package:book_app/app/routes/app_pages.dart';
import 'package:book_app/app/translations/app_translations.dart';
import 'package:book_app/app/utils/constant/constant_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:lottie/lottie.dart';

class OnBoardingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return IntroductionScreen(
      globalBackgroundColor: ConstantColor.background,
      onDone: () => Get.offAllNamed(Routes.AUTH),
      showDoneButton: true,
      showNextButton: false,
      curve: Curves.fastLinearToSlowEaseIn,
      controlsMargin: EdgeInsets.all(16),
      dotsDecorator: DotsDecorator(
        size: Size(10.0, 10.0),
        color: Color(0xFFBDBDBD),
        activeSize: Size(11.0, 10.0),
      ),
      done: Text(AppTranslation.gotIt.tr),
      pages: [
        PageViewModel(
          reverse: true,
          titleWidget: Column(
            children: <Widget>[
              SizedBox(height: 50),
              Text(
                  AppTranslation.findNuggets.tr,
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
                  AppTranslation.discoverNewBook.tr,
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
          bodyWidget: _buildImage(),
        ),
        PageViewModel(
          titleWidget: Column(
            children: <Widget>[
              SizedBox(height: 50),
              Text(
                  AppTranslation.shareRating.tr,
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
                  AppTranslation.rateYourGallery.tr,
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
          bodyWidget: _buildImage(),
        ),
        PageViewModel(
          titleWidget: Column(
            children: <Widget>[
              SizedBox(height: 50),
              Text(
                  AppTranslation.findSeller.tr,
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
                  AppTranslation.shareBookWeek.tr,
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
          bodyWidget: _buildImage(),
        ),
      ],
    );
  }

  Widget _buildImage() {
    return Container(
      child: Center(
        child: Lottie.asset('assets/book-loading.json', width: 600,
          height: 600,
          fit: BoxFit.contain,),
      ),
    );
  }
}
