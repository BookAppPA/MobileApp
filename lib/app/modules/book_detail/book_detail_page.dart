import 'package:book_app/app/modules/book_detail/book_detail_controller.dart';
import 'package:book_app/app/modules/profil/user_controller.dart';
import 'package:book_app/app/modules/widgets_global/back_button_appbar.dart';
import 'package:book_app/app/modules/widgets_global/button_gradient.dart';
import 'package:book_app/app/modules/widgets_global/chip_category.dart';
import 'package:book_app/app/modules/widgets_global/custom_circular_progress.dart';
import 'package:book_app/app/modules/widgets_global/rating_item.dart';
import 'package:book_app/app/routes/app_pages.dart';
import 'package:book_app/app/utils/constant/constant_color.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class BookDetailPage extends GetWidget<BookDetailController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BackButtonAppBar(),
      body: GetBuilder<BookDetailController>(
        builder: (_) => _.loadData && _.errorMessage == ""
            ? CustomCircularProgress(color: ConstantColor.accent, radius: 20)
            : _.loadData && _.errorMessage != ""
                ? Center(child: Text(_.errorMessage))
                : SingleChildScrollView(
                    child: Center(
                      child: Column(
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.only(
                                bottom: 25, left: 50, right: 50),
                            child: Text(
                              _.book.title.toUpperCase(),
                              maxLines: 2,
                              textAlign: TextAlign.center,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontFamily: 'SF Pro Text',
                                fontSize: 24,
                                color: Color(0xbf212121),
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          Container(
                            width: 180,
                            height: 275,
                            child: Hero(
                              tag: _.book.id ?? DateTime.now(),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(23),
                                child: _.book.coverImage != null &&
                                        _.book.coverImage != ""
                                    ? CachedNetworkImage(
                                        imageUrl: _.book.coverImage,
                                        fit: BoxFit.cover,
                                        useOldImageOnUrlChange: true,
                                        placeholder: (context, url) =>
                                            CustomCircularProgress(radius: 15),
                                        errorWidget: (context, url, error) =>
                                            Icon(Icons.error),
                                      )
                                    : Container(
                                        decoration: BoxDecoration(
                                            color: Colors.grey,
                                            borderRadius:
                                                BorderRadius.circular(5)),
                                      ),
                              ),
                            ),
                          ),
                          SizedBox(height: 25),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              _.book.previewLink != ""
                                  ? ButtonGradient(
                                      onTap: () => Get.toNamed(
                                          Routes.BOOK_PREVIEW,
                                          arguments: _.book.id),
                                      width: 166,
                                      height: 40,
                                      text: "PREVIEW",
                                      fontSize: 15,
                                    )
                                  : Container(),
                              SizedBox(width: 25),
                              GetBuilder<UserController>(
                                builder: (controller) {
                                  return ButtonGradient(
                                    width: 166,
                                    height: 40,
                                    text: _.haveAlreadyBook
                                        ? "Supprimer ce livre".toUpperCase()
                                        : UserController.to.isBookSeller
                                            ? "Ajouter ce livre".toUpperCase()
                                            : "J'ai finis ce livre"
                                                .toUpperCase(),
                                    onTap: () => _.handleAddOrDeleteBook(),
                                  );
                                },
                              ),
                            ],
                          ),
                          SizedBox(height: 25),
                          _.bio == '' || _.bio == null
                              ? _.book.description != null &&
                                      _.book.description != ""
                                  ? Padding(
                                      padding: EdgeInsets.only(
                                          left: 25, right: 25, bottom: 25),
                                      child: Text(
                                        _.book.description,
                                        style: TextStyle(
                                          fontFamily: 'SF Pro Text',
                                          fontSize: 13,
                                          color: Color(0x80212121),
                                          letterSpacing: 0.16,
                                          fontWeight: FontWeight.w300,
                                        ),
                                      ),
                                    )
                                  : Container()
                              : Padding(
                                  padding: EdgeInsets.only(
                                      left: 25, right: 25, bottom: 25),
                                  child: Text(
                                    _.bio,
                                    style: TextStyle(
                                      fontFamily: 'SF Pro Text',
                                      fontSize: 13,
                                      color: Color(0x80212121),
                                      letterSpacing: 0.16,
                                      fontWeight: FontWeight.w300,
                                    ),
                                  ),
                                ),
                          SizedBox(height: 5),
                          ChipCategories(
                            listCategories: _.book.categories,
                            onSelected: () => print('select'),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              // Text("Note Moyenne"),
                              SizedBox(width: 20),
                            ],
                          ),
                          Padding(
                            padding:
                                EdgeInsets.only(left: 25, right: 25, top: 25),
                            child: GestureDetector(
                              onTap: () => _.book.nbRating > 5
                                  ? print("click list ratings")
                                  : null,
                              child: Container(
                                color: Colors.transparent,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      _.book.nbRating <= 0
                                          ? "Aucun Avis"
                                          : "Avis (${_.book.nbRating})",
                                      style: TextStyle(
                                        fontFamily: 'SF Pro Text',
                                        fontSize: 20,
                                        color: ConstantColor.greyDark,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                    _.book.nbRating > 5
                                        ? Icon(
                                            FontAwesomeIcons.chevronRight,
                                            color: ConstantColor.greyDark,
                                            size: 20,
                                          )
                                        : Container(),
                                    RatingBar.builder(
                                      initialRating: _.book.note,
                                      minRating: 0,
                                      direction: Axis.horizontal,
                                      itemCount: 5,
                                      itemSize: 20,
                                      allowHalfRating: true,
                                      ignoreGestures: true,
                                      itemBuilder: (context, _) => Icon(
                                        Icons.star,
                                        color: Colors.amber,
                                      ),
                                      onRatingUpdate: (_) {},
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 15),
                          Container(
                            height: _.book.nbRating <= 5
                                ? (_.book.nbRating * 225).toDouble()
                                : 800,
                            child: ListView.separated(
                              physics: NeverScrollableScrollPhysics(),
                              itemCount: _.listRatings.length <= 5
                                  ? _.listRatings.length
                                  : 5,
                              padding: EdgeInsets.fromLTRB(30, 0, 30, 30),
                              separatorBuilder: (context, index) =>
                                  SizedBox(height: 25),
                              itemBuilder: (context, index) {
                                return RatingItem(_.listRatings[index]);
                              },
                            ),
                          ),
                          SizedBox(height: 30),
                        ],
                      ),
                    ),
                  ),
      ),
    );
  }
}
