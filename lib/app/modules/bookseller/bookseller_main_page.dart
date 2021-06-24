import 'package:book_app/app/data/repository/bookseller_repository.dart';
import 'package:book_app/app/modules/bookseller/bookseller_main_controller.dart';
import 'package:book_app/app/utils/constant/constant_color.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'bookseller_item.dart';

class BookSellerMainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: GestureDetector(
          onTap: () => Get.focusScope.unfocus(),
          child: Column(
            children: <Widget>[
              SizedBox(height: 20),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: GetBuilder<BookSellerMainController>(
                  init: BookSellerMainController(
                      repository: BookSellerRepository()),
                  builder: (_) => CupertinoTextField(
                    controller: _.editTextController,
                    cursorColor: ConstantColor.black,
                    maxLines: 1,
                    maxLength: 50,
                    placeholder: "Rechercher une librairie",
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
                  child: GetBuilder<BookSellerMainController>(builder: (_) {
                    if (_.searching)
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    else if (_.booksellers == null)
                      return Center(
                        child: Text("Aucune librairie trouvées..."),
                      );
                    return ListView.separated(
                      itemCount: _.booksellers.length,
                      itemBuilder: (ctx, index) {
                        return SearchBookSellerItem(
                          _.booksellers[index],
                          onFollow: () => _.followBookSeller(index, _.booksellers[index]),
                          onUnFollow: () => _.unFollowBookSeller(index, _.booksellers[index]),
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
      ),
    );
  }
}
