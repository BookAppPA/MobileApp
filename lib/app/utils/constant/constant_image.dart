import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

abstract class ConstantImage {
  static final logo = "assets/logo.png";

  static final onBoarding1 = SvgPicture.asset(
    "assets/onboarding_1.svg",
    fit: BoxFit.contain,
  );
}
