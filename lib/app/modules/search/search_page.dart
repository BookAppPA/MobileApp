import 'package:book_app/app/data/model/book.dart';
import 'package:book_app/app/modules/search/search_book_item.dart';
import 'package:book_app/app/modules/search/search_controller.dart';
import 'package:book_app/app/modules/widgets_global/back_button_appbar.dart';
import 'package:book_app/app/utils/constant/constant_color.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import 'search_user_item.dart';

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
                Row(
                  children: <Widget>[
                    _getTab(0, Icon(FontAwesomeIcons.book)),
                    _getTab(1, Icon(FontAwesomeIcons.pen)),
                    _getTab(2, Icon(FontAwesomeIcons.userAlt)),
                  ],
                ),
                SizedBox(height: 20),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: GetBuilder<SearchController>(
                    builder: (_) => CupertinoTextField(
                      controller: _.editTextController,
                      cursorColor: ConstantColor.black,
                      maxLines: 1,
                      maxLength: 50,
                      placeholder: _.placeholderSearchBar,
                      padding: EdgeInsets.all(15),
                      prefix: IconButton(
                        icon: Icon(Icons.search),
                        onPressed: () => _.search(),
                      ),
                      suffixMode: OverlayVisibilityMode.editing,
                      suffix: IconButton(
                        icon: Icon(
                          FontAwesomeIcons.times,
                          color: ConstantColor.greyDark,
                        ),
                        onPressed: () => _.cancelSearch(),
                      ),
                      onSubmitted: (text) => _.search(),
                      onEditingComplete: () => Get.focusScope.unfocus(),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 25, horizontal: 15),
                    child: GetBuilder<SearchController>(builder: (_) {
                      if (_.searching)
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      else if (_.searchMode == 0 && _.books == null)
                        return Center(
                          child: Text("Aucun livre trouvé..."),
                        );
                      else if (_.searchMode == 1 && _.booksByAuthor == null)
                        return Center(
                          child: Text("Aucun auteur trouvé..."),
                        );
                      else if (_.searchMode == 2 && _.users == null)
                        return Center(
                          child: Text("Aucun utilisateur trouvé..."),
                        );
                      if (_.searchMode == 0 || _.searchMode == 1)
                        return ListView.separated(
                          itemCount: _.searchMode == 0 ? _.books.length : _.booksByAuthor.length,
                          itemBuilder: (ctx, index) {
                            return SearchBookItem(
                              _.getBookIndex(index),
                              onAdd: () => _.addBookToGallery(_.getBookIndex(index)),
                              onDelete: () =>
                                  _.deleteBookFromGallery(_.getBookIndex(index)),
                            );
                          },
                          separatorBuilder: (ctx, index) => SizedBox(height: 10),
                        );
                      return ListView.separated(
                          itemCount: _.users.length,
                          itemBuilder: (ctx, index) {
                            return SearchUserItem(
                              _.users[index],
                              onFollow: () => print("follow user"),
                              onUnFollow: () => print("unfollow user"),
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

  _getTab(int index, Widget child) {
    return GetBuilder<SearchController>(
      builder: (_) => Expanded(
        child: GestureDetector(
          onTap: () => _.changeSearchingMode(index),
          child: Container(
            child: child,
            height: 50,
            decoration: BoxDecoration(
              color: (_.searchMode == index
                  ? ConstantColor.background
                  : Colors.grey.shade300),
              borderRadius: _generateBorderRadius(index, _.searchMode),
            ),
          ),
        ),
      ),
    );
  }

  _generateBorderRadius(int index, int indexSelected) {
    if ((indexSelected + 1) == index)
      return BorderRadius.only(bottomLeft: Radius.circular(20));
    else if ((indexSelected - 1) == index)
      return BorderRadius.only(bottomRight: Radius.circular(20));
    else
      return BorderRadius.zero;
  }
}
