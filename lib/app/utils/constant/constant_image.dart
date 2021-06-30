import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

abstract class ConstantImage {
  static final logo = "assets/logo.png";
    static final List<String> categoryTitle = ["Science", "Fiction", "Histoire", "Amour", "Education", "Religion", "Policier", "Sports", "Comics"];


  static final List<String> listCategoriesPhotos = [
    "assets/categories/science.jpg", 
    "assets/categories/fiction.jpg", 
    "assets/categories/histoire.jpg", 
    "assets/categories/love.jpg",
    "assets/categories/education.jpg",
    "assets/categories/religion.png",
    "assets/categories/thriller.jpg",
    "assets/categories/sport.jpg",
    "assets/categories/comics.jpg"
  ];

  static final onBoarding1 = SvgPicture.asset(
    "assets/onboarding_1.svg",
    fit: BoxFit.contain,
  );
}
