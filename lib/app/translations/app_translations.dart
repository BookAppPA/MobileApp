import 'package:flutter/material.dart';
import 'en_US/en_us_translation.dart';
import 'es_ES/es_es_translation.dart';
import 'fr_FR/fr_fr_translation.dart';

abstract class AppTranslation {

  static final List<Locale> languages = [
    Locale("fr", "FR"),
    Locale("en", "US"),
    Locale("es", "ES"),
  ];

  static Map<String, Map<String, String>> translations = {
    'fr_FR': frFR,
    'en_US': enUS,
    'es_ES': esES,
  };

  static const String locationCheckTitle = "location_check";

  // EXCEPTION API
  static const String errorAPIdefault = "error_api_default";
  static const String errorAPInetwork = "error_api_network";
}
