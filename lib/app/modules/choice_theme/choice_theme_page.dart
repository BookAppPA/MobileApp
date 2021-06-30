import 'package:book_app/app/modules/choice_theme/choice_theme_controller.dart';
import 'package:book_app/app/modules/widgets_global/button_arround.dart';
import 'package:book_app/app/modules/widgets_global/curve_painter.dart';
import 'package:book_app/app/routes/app_pages.dart';
import 'package:book_app/app/utils/constant/constant.dart';
import 'package:book_app/app/utils/constant/constant_color.dart';
import 'package:book_app/app/utils/constant/constant_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'widgets/theme_item.dart';

class ChoiceThemePage extends StatelessWidget {
  final controller = Get.put(ChoiceThemeController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Container(
            height: 170,
            width: Get.width,
            child: CustomPaint(
              painter: CurvePainter(color: ConstantColor.accent),
              child: Padding(
                padding: EdgeInsets.only(left: 22, top: 50, right: 22),
                child: Text(
                  'Bienvenue,\nPour commencer, quels sont tes genres favoris ?',
                  style: TextStyle(
                    fontFamily: 'SF Rounded',
                    fontSize: 22,
                    color: ConstantColor.white,
                    fontWeight: FontWeight.w600,
                    height: 1.5,
                  ),
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
                    crossAxisSpacing: 10,
                    childAspectRatio: 0.8
                  ),
                  itemCount: Constant.categoryTitle.length,
                  itemBuilder: (context, index) {
                    return ThemeItem(
                      onSelected: () => controller.selectCategories(Constant.categoryTitle[index]),
                      onUnSelected: () => controller.deselectCategories(Constant.categoryTitle[index]),
                      categoryTitle: Constant.categoryTitle[index],
                      imageCategory: ConstantImage.listCategoriesPhotos[index],
                    );
                  },
                ),
              )),
          Expanded(
            child: Center(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 22),
                child: GetBuilder<ChoiceThemeController>(
                  builder: (_) => 
                  ButtonArround(
                    onTap: () => _.finishSelectChoice(),
                    width: Get.width,
                    borderRadius: 10,
                    text: "Terminer",
                    colorBackground: _.isBlock ? Colors.grey : ConstantColor.accent,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
