import 'package:get/get.dart';
import 'package:book_app/app/translations/app_translations.dart';


abstract class Constant {
  static final RegExp regexEmail = RegExp(
      r'^[a-zA-Z0-9]+([-+._][a-zA-Z0-9]+){0,2}@.*?(\.(a(?:[cdefgilmnoqrstuwxz]|ero|(?:rp|si)a)|b(?:[abdefghijmnorstvwyz]iz)|c(?:[acdfghiklmnoruvxyz]|at|o(?:m|op))|d[ejkmoz]|e(?:[ceghrstu]|du)|f[ijkmor]|g(?:[abdefghilmnpqrstuwy]|ov)|h[kmnrtu]|i(?:[delmnoqrst]|n(?:fo|t))|j(?:[emop]|obs)|k[eghimnprwyz]|l[abcikrstuvy]|m(?:[acdeghklmnopqrstuvwxyz]|il|obi|useum)|n(?:[acefgilopruz]|ame|et)|o(?:m|rg)|p(?:[aefghklmnrstwy]|ro)|qa|r[eosuw]|s[abcdeghijklmnortuvyz]|t(?:[cdfghjklmnoprtvwz]|(?:rav)?el)|u[agkmsyz]|v[aceginu]|w[fs]|y[etu]|z[amw])\b){1,2}$');
  
  static final List<String> categoryTitle = [
    AppTranslation.science.tr,
    AppTranslation.fiction.tr,
    AppTranslation.histoire.tr,
    AppTranslation.amour.tr,
    AppTranslation.education.tr,
    AppTranslation.religion.tr,
    AppTranslation.policier.tr,
    AppTranslation.sports.tr,
    AppTranslation.comics.tr
  ];
}
