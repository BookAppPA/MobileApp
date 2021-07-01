import 'package:book_app/app/modules/dialog/add_rating_bottomsheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_test/flutter_test.dart' as prefix0;

import 'test_rating_bottomsheet.dart';

void main() {

  Widget _wrapWithMaterialApp(Widget widget) {
    return TestRatingAppWidget(
      home: widget,
    );
  }
  
  testWidgets("BottomSheet Rating Exist", (WidgetTester tester) async {
    //  given
    final widget = AddRatingBottomSheet(title: "Test Rating", onConfirm: (_, __, ___) {}, onCancel: (){});

    //  when
    await tester.pumpWidget(_wrapWithMaterialApp(widget));

    //  then
    expect(find.byType(AddRatingBottomSheet), findsOneWidget);
  });

  testWidgets("Title is corresponding'", (WidgetTester tester) async {
    //  given
    final widget = AddRatingBottomSheet(title: "Click me", onConfirm: (_, __, ___) {}, onCancel: (){});

    //  when
    await tester.pumpWidget(_wrapWithMaterialApp(widget));

    //  then
    expect(find.text('Click me'), findsOneWidget);
  });
  
}