import 'package:book_app/app/modules/dialog/basic_dialog.dart';
import 'package:flutter/material.dart';

class SqueletonPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => BasicDialog.showExitAppDialog(),
      child: Scaffold(
        body: Container()
      ),
    );
  }
}
