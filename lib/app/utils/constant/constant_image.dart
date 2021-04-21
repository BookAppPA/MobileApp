import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

abstract class ConstantImage {
  static final interrogation = "asset/gold_interrogation.png";
  static final moodSerious = "asset/icon_mood_serious.png";

  static final bombrImage = Image.asset(
    "asset/bombr_name_white.png",
    fit: BoxFit.contain,
  );

  static final onBoarding1 = SvgPicture.asset(
    "assets/onboarding_1.svg",
    fit: BoxFit.contain,
  );
}
