import 'package:book_app/app/app_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' as Service;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Service.SystemChrome.setPreferredOrientations([Service.DeviceOrientation.portraitUp]);
  runApp(AppWidget());
}