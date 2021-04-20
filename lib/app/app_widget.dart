import 'package:book_app/app/bindings/app_binding.dart';
import 'package:book_app/app/routes/app_pages.dart';
import 'package:book_app/app/theme/app_theme.dart';
import 'package:book_app/app/translations/app_translations.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';

class AppWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //return 
    //DevicePreview(
      //builder: (context) {
        return LayoutBuilder(
          builder: (context, constraints) {
            return OrientationBuilder(
              builder: (context, orientation) {
                return GetMaterialApp(
                  title: 'Book App',
                  debugShowCheckedModeBanner: false,
                  initialRoute: Routes.SPLASHSCREEN,
                  initialBinding: AppBinding(),
                  theme: appThemeData,
                  defaultTransition: Transition.fade,
                  builder: (context, child) {
                    return ScrollConfiguration(
                      behavior: MyBehavior(),
                      child: child,
                    );
                  },
                 // builder: DevicePreview.appBuilder,
                  getPages: AppPages.routes,
                  locale: Locale('fr', 'FR'),
                  localizationsDelegates: [
                    GlobalMaterialLocalizations.delegate,
                    GlobalWidgetsLocalizations.delegate,
                    GlobalCupertinoLocalizations.delegate,
                    DefaultCupertinoLocalizations.delegate,
                  ],
                  supportedLocales: AppTranslation.languages,
                  translationsKeys: AppTranslation.translations,
                );
              },
            );
          },
        );
      //},
   // );
  }
}

// Remove Scroll Overlay / Glow in List / Grid
class MyBehavior extends ScrollBehavior {
  @override
  Widget buildViewportChrome(
      BuildContext context, Widget child, AxisDirection axisDirection) {
    return child;
  }
}
