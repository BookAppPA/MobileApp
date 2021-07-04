import 'package:book_app/app/data/model/book.dart';
import 'package:book_app/app/modules/search/search_book_item.dart';
import 'package:book_app/app/modules/widgets_global/back_button_appbar.dart';
import 'package:book_app/app/translations/app_translations.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ResultMLBooksPage extends StatelessWidget {
  final List<Book> books = Get.arguments as List<Book>;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BackButtonAppBar(
        textTitle: AppTranslation.recommendationBooks.tr,
      ),
      body: Container(
          width: Get.width,
          height: Get.height,
          child: Padding(
            padding: EdgeInsets.all(20),
            child: ListView.separated(
              itemCount: books.length,
              itemBuilder: (ctx, index) => SearchBookItem(
                books[index],
                onAdd: () => null,
                onDelete: () => null,
              ),
              separatorBuilder: (ctx, index) => SizedBox(height: 10),
            ),
          )),
    );
  }
}
