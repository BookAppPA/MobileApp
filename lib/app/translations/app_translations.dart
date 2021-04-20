import 'package:book_app/app/translations/en_US/en_us_translation.dart';
import 'package:book_app/app/translations/fr_FR/fr_fr_translation.dart';
import 'package:flutter/material.dart';

abstract class AppTranslation {

  static final List<Locale> languages = [
    Locale("fr", "FR"),
    Locale("en", "US"),
  ];

  static Map<String, Map<String, String>> translations = {
    'fr_FR': frFR,
    'en_US': enUs
  };

  static const String locationCheckTitle = "location_check";

  // EXCEPTION API
  static const String errorAPIdefault = "error_api_default";
  static const String errorAPInetwork = "error_api_network";
}
