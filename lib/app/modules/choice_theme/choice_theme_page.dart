import 'package:book_app/app/modules/widgets_global/button_arround.dart';
import 'package:book_app/app/modules/widgets_global/curve_painter.dart';
import 'package:book_app/app/routes/app_pages.dart';
import 'package:book_app/app/utils/constant/constant_color.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'widgets/theme_item.dart';

class ChoiceThemePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Container(
            height: 160,
            width: Get.width,
            child: CustomPaint(
              painter: CurvePainter(color: ConstantColor.accent),
              child: Padding(
                padding: EdgeInsets.only(left: 22, top: 50),
                child: Text(
                  'Bienvenue,\nchoisissez des thèmes',
                  style: TextStyle(
                      fontFamily: 'SF Rounded',
                      fontSize: 22,
                      color: ConstantColor.white,
                      fontWeight: FontWeight.w600,
                      height: 1.5),
                ),
              ),
            ),
          ),
          Expanded(
              flex: 3,
              child: Container(
                //color: Colors.red,
                child: GridView.builder(
                  padding: EdgeInsets.all(25),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    mainAxisSpacing: 30,
                    crossAxisSpacing: 20,
                  ),
                  itemCount: 10,
                  itemBuilder: (context, index) {
                    return ThemeItem(
                      onSelected: () => print("on selected"),
                      onUnSelected: () => print("on unselected"),
                    );
                  },
                ),
              )),
          Expanded(
            child: Center(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 22),
                child: ButtonArround(
                  onTap: () => Get.toNamed(Routes.SQUELETON),
                  height: 50,
                  text: "Terminer",
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
