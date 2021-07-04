import 'package:book_app/app/modules/search/searchCategories/search_categories_controller.dart';
import 'package:book_app/app/modules/widgets_global/back_button_appbar.dart';
import 'package:book_app/app/translations/app_translations.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../search_book_item.dart';

class SearchCategoriesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: BackButtonAppBar(
          textTitle: AppTranslation.search.tr,
        ),
        body: GestureDetector(
          onTap: () => Get.focusScope.unfocus(),
          child: Container(
            width: Get.width,
            height: Get.height,
            color: Colors.transparent,
            child: Column(
              children: <Widget>[
                SizedBox(height: 20),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 25, horizontal: 15),
                    child: GetBuilder<SearchCategoriesController>(builder: (_) {
                      if (_.searching)
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      else if (_.booksByCategories.length == 0)
                        return Center(
                          child: Text(AppTranslation.noFindBook.tr),
                        );
                      return ListView.separated(
                        itemCount: _.booksByCategories.length,
                        itemBuilder: (ctx, index) {
                          return SearchBookItem(
                            _.booksByCategories[index],
                            onAdd: () =>
                                _.addBookToGallery(_.booksByCategories[index]),
                            onDelete: () => _.deleteBookFromGallery(
                                _.booksByCategories[index]),
                          );
                        },
                        separatorBuilder: (ctx, index) => SizedBox(height: 10),
                      );
                    }),
                  ),
                )
              ],
            ),
          ),
        ));
  }
}
