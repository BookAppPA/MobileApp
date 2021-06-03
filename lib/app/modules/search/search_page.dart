import 'package:book_app/app/data/model/book.dart';
import 'package:book_app/app/modules/search/search_book_item.dart';
import 'package:book_app/app/modules/search/search_controller.dart';
import 'package:book_app/app/modules/widgets_global/back_button_appbar.dart';
import 'package:book_app/app/utils/constant/constant_color.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class SearchPage extends GetView<SearchController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: BackButtonAppBar(
          textTitle: "Recherche",
        ),
        body: GestureDetector(
          onTap: () => Get.focusScope.unfocus(),
          child: Container(
            width: Get.width,
            height: Get.height,
            color: Colors.transparent,
            child: Column(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: CupertinoTextField(
                    controller: controller.editTextController,
                    cursorColor: ConstantColor.black,
                    maxLines: 1,
                    maxLength: 50,
                    placeholder: "Rechercher un livre",
                    padding: EdgeInsets.all(15),
                    autofocus: true,
                    prefix: IconButton(
                      icon: Icon(Icons.search),
                      onPressed: () => controller.search(),
                    ),
                    suffixMode: OverlayVisibilityMode.editing,
                    suffix: IconButton(
                      icon: Icon(
                        FontAwesomeIcons.times,
                        color: ConstantColor.greyDark,
                      ),
                      onPressed: () => controller.cancelSearch(),
                    ),
                    onSubmitted: (text) => controller.search(),
                    onEditingComplete: () => Get.focusScope.unfocus(),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.all(25),
                    child: Obx(
                      () => ListView.separated(
                        itemCount: controller.books.length,
                        itemBuilder: (ctx, index) {
                          return SearchBookItem(controller.books[index]);
                        },
                        separatorBuilder: (ctx, index) => SizedBox(height: 20),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ));
  }
}
