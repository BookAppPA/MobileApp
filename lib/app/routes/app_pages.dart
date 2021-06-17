import 'package:book_app/app/bindings/auth_binding.dart';
import 'package:book_app/app/bindings/book_detail_binding.dart';
import 'package:book_app/app/bindings/bookseller_detail_binding.dart';
import 'package:book_app/app/bindings/edit_profil_binding.dart';
import 'package:book_app/app/bindings/profil_binding.dart';
import 'package:book_app/app/bindings/search_binding.dart';
import 'package:book_app/app/modules/auth/auth_page.dart';
import 'package:book_app/app/modules/book_detail/book_detail_page.dart';
import 'package:book_app/app/modules/book_detail/book_preview/book_preview_page.dart';
import 'package:book_app/app/modules/bookseller/bookseller_detail/bookseller_detail_page.dart';
import 'package:book_app/app/modules/choice_theme/choice_theme_page.dart';
import 'package:book_app/app/modules/onboarding/onboarding_page.dart';
import 'package:book_app/app/modules/profil/edit_profil/edit_profil_page.dart';
import 'package:book_app/app/modules/profil/profil_page.dart';
import 'package:book_app/app/modules/search/search_page.dart';
import 'package:book_app/app/modules/settings/settings_page.dart';
import 'package:book_app/app/modules/splashscreen/splashscreen_page.dart';
import 'package:book_app/app/modules/squeleton/squeleton_page.dart';
import 'package:get/get.dart';
part './app_routes.dart';

class AppPages {
  
  static final routes = [
    GetPage(name: Routes.SPLASHSCREEN, page: () => SplashScreenPage(),),
    GetPage(name: Routes.ONBOARDING, page: () => OnBoardingPage(),),
    GetPage(name: Routes.AUTH, page: () => AuthPage(), binding: AuthBinding()),
    GetPage(name: Routes.CHOICE_THEME, page: () => ChoiceThemePage()),
    GetPage(name: Routes.SQUELETON, page: () => SqueletonPage()),
    GetPage(name: Routes.BOOK_DETAIL, page: () => BookDetailPage(), binding: BookDetailBinding()),
    GetPage(name: Routes.BOOK_PREVIEW, page: () => BookPreviewPage()), 
    GetPage(name: Routes.PROFIL, page: () => ProfilPage(back: true), binding: ProfilBinding()),
    GetPage(name: Routes.EDIT_PROFIL, page: () => EditProfilPage(), binding: EditProfilBinding()),
    GetPage(name: Routes.SEARCH, page: () => SearchPage(), binding: SearchBinding()),
    GetPage(name: Routes.BOOKSELLER_DETAIL, page: () => BookSellerDetailPage(), binding: BookSellerDetailBinding()),
    GetPage(name: Routes.SETTINGS, page: () => SettingsPage()),
  ];
}