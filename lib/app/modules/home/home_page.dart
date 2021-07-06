import 'package:book_app/app/data/model/book.dart';
import 'package:book_app/app/modules/home/home_controller.dart';
import 'package:book_app/app/modules/home/widget/lastBookWeekItem.dart';
import 'package:book_app/app/modules/profil/user_controller.dart';
import 'package:book_app/app/modules/widgets_global/book_item.dart';
import 'package:book_app/app/modules/widgets_global/curve_painter.dart';
import 'package:book_app/app/routes/app_pages.dart';
import 'package:book_app/app/translations/app_translations.dart';
import 'package:book_app/app/utils/constant/constant_color.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width,
      height: Get.height,
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            _buildHeader(),
            Padding(
              padding: EdgeInsets.all(15),
              child: Column(
                children: <Widget>[
                  _buildMostPopularBooks(),
                  _buildBooksWant(),
                ],
              ),
            ),
            SizedBox(height: 25),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return CustomPaint(
      painter: CurvePainter(color: ConstantColor.accent),
      child: Container(
        height: 375,
        // color: ConstantColor.accent,
        padding: EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(vertical: 30),
              child: CupertinoTextField(
                maxLines: 1,
                maxLength: 50,
                placeholder: AppTranslation.searchBookAuthorUser.tr,
                readOnly: true,
                padding: EdgeInsets.all(15),
                prefix: IconButton(
                  icon: Icon(Icons.search),
                  onPressed: () => null,
                ),
                onTap: () => Get.toNamed(Routes.SEARCH),
              ),
            ),
            Text(
              AppTranslation.bookSellerChoice.tr,
              style: TextStyle(
                fontFamily: 'SF Rounded',
                fontSize: 24,
                color: Color(0xffffffff),
                fontWeight: FontWeight.w700,
              ),
            ),
            SizedBox(height: 20),
            Expanded(
              child: GetBuilder<HomeController>(
                builder: (_) => ListView.separated(
                  itemCount: _.listLastBooksWeek.length,
                  scrollDirection: Axis.horizontal,
                  separatorBuilder: (ctx, index) {
                    return SizedBox(width: 20);
                  },
                  itemBuilder: (ctx, index) {
                    return LastBookWeekItem(book: _.listLastBooksWeek[index]);
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMostPopularBooks() {
    return GetBuilder<HomeController>(
        builder: (_) => Container(
              height: _.listPopularBooks.length < 4 ? 250 : 430,
              //color: Colors.yellow,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    AppTranslation.mostPopular.tr,
                    style: TextStyle(
                      fontFamily: 'SF Rounded',
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Expanded(
                    child: Container(
                        child: Column(
                      children: <Widget>[
                        Container(
                          height: _.listPopularBooks.length < 4 ? 200 : 360,
                          width: Get.width,
                          child: GridView.builder(
                            physics: NeverScrollableScrollPhysics(),
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 3, childAspectRatio: 0.7, crossAxisSpacing: 10),
                            itemCount: _.listPopularBooks.length,
                            itemBuilder: (ctx, index) {
                              return Container(
                                child: BookItem(
                                  width: 100,
                                  height: 150,
                                  book: _.hasDataPopularBooks
                                      ? _.listPopularBooks[index]
                                      : Book(),
                                ),
                              );
                            },
                          ),
                        ),
                        /* Container(
                    height: 180,
                    child: ListView.separated(
                        itemCount: _.hasDataPopularBooks ? _.listPopularBooks.length > 3 ? 3 : _.listPopularBooks.length : 3,
                        itemBuilder: (ctx, index) => BookItem(
                          book: _.hasDataPopularBooks
                              ? _.listPopularBooks[index]
                              : Book(),
                        ),
                        separatorBuilder: (ctx, index) => SizedBox(width: 20),
                        scrollDirection: Axis.horizontal,
                    ),
                  ),
                  SizedBox(height: 10),
                  Container(
                    height: 180,
                    child: ListView.separated(
                        itemCount: _.hasDataPopularBooks ? _.listPopularBooks.length > 3 ? _.listPopularBooks.length - 3 : 6 : 6,
                        itemBuilder: (ctx, index) => BookItem(
                          book: _.hasDataPopularBooks
                              ? _.listPopularBooks[index + 3]
                              : Book(),
                        ),
                        separatorBuilder: (ctx, index) => SizedBox(width: 20),
                        scrollDirection: Axis.horizontal,
                    ),
                  ),*/
                      ],
                    )),
                  ),
                ],
              ),
            ));
  }

  Widget _buildBooksWant() {
    if (UserController.to.isBookSeller) return Container();
    return Container(
      height: 325,
      // color: Colors.red,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            AppTranslation.youWouldLike.tr,
            style: TextStyle(
              fontFamily: 'SF Rounded',
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 20),
          Expanded(
            child: GetBuilder<HomeController>(
              builder: (_) {
                print(_.hasDataRecommendationBooks);
                return ListView.separated(
                itemCount: 5,
                separatorBuilder: (ctx, index) {
                  return SizedBox(width: 25);
                },
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return BookItem(
                    book: _.hasDataRecommendationBooks
                        ? _.listRecommendationBooks[index]
                        : Book(),
                    showAuthor: true,
                    showTitle: true,
                    width: 125,
                    height: 200,
                    isAdd: index == 4,
                    onClickAdd: () => _.showMoreBooks(),
                  );
                },
              );
              }
            ),
          ),
        ],
      ),
    );
  }
}
