import 'package:book_app/app/routes/app_pages.dart';
import 'package:book_app/app/utils/constant/constant_color.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChipCategories extends StatelessWidget {

  final List listCategories; 
  final VoidCallback onSelected;

  ChipCategories(
      {@required this.onSelected,
      @required this.listCategories,
      })
      : assert(onSelected != null),
        assert(listCategories != null);


  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0,),
        child: Wrap(
          children: listCategories.map((category) {
            return Padding(
              padding: EdgeInsets.only(left: 1, right: 2, bottom: 1.0),
              child: GestureDetector(
                  onTap: () => Get.toNamed(Routes.SEARCH_CATEGORIES, arguments: category),
                  child: Chip(
                      label: Text(
                    category,
                    style: TextStyle(fontSize: 13, color: ConstantColor.background),
                  ), backgroundColor: ConstantColor.accent,)),
            );
          }).toList(),
        ),
      ),
    );
  }
}
