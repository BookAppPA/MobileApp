import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TestRatingAppWidget extends StatelessWidget {
  final Widget home;
  final Map<String, WidgetBuilder> routes;

  TestRatingAppWidget({
    Key key,
    this.home,
    this.routes
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Widget Test',
      home: home,
    );
  }
}