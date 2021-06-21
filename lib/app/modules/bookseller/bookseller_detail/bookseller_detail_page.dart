import 'package:book_app/app/data/model/book.dart';
import 'package:book_app/app/data/model/bookseller.dart';
import 'package:book_app/app/data/model/bookweek.dart';
import 'package:book_app/app/data/repository/bookseller_repository.dart';
import 'package:book_app/app/modules/bookseller/bookseller_detail/bookseller_detail_controller.dart';
import 'package:book_app/app/modules/profil/user_controller.dart';
import 'package:book_app/app/modules/profil/widgets/profil_app_bar.dart';
import 'package:book_app/app/modules/widgets_global/button_gradient.dart';
import 'package:book_app/app/modules/widgets_global/custom_circular_progress.dart';
import 'package:book_app/app/modules/widgets_global/description_text.dart';
import 'package:book_app/app/routes/app_pages.dart';
import 'package:book_app/app/utils/constant/constant_color.dart';
import 'package:book_app/app/utils/functions.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class BookSellerDetailPage extends GetView<BookSellerDetailController> {
  final bool back;
  final BookSeller bookSeller;
  BookSellerDetailPage({this.bookSeller, this.back: true}) {
    if (bookSeller != null && bookSeller.name != null) {
      Get.put(BookSellerDetailController(
          repository: BookSellerRepository(), bookSeller: bookSeller));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: Get.width,
        height: Get.height,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              ProfilAppBar(
                isBookSeller: controller.isMe,
                isMe: controller.isMe,
                back: back,
                title: controller.bookSeller.name,
              ),
              _buildBasicInfo(),
              _buildLastBooksWeek(),
              _buildInfoBookSeller(),
              _buildContactInfo(),
            ],
          ),
        ),
      ),
    );
  }

  _buildBasicInfo() {
    return Padding(
      padding: EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Center(
            child: Text(
              controller.bookSeller.name,
              style: TextStyle(
                fontSize: 24,
              ),
            ),
          ),
          SizedBox(height: 25),
          GetBuilder<BookSellerDetailController>(
            builder: (_) => Row(
              mainAxisAlignment: _.bookSeller.phone != ""
                  ? UserController.to.isBookSeller && !_.isMe
                      ? MainAxisAlignment.center
                      : MainAxisAlignment.spaceEvenly
                  : MainAxisAlignment.center,
              children: <Widget>[
                _.bookSeller.phone != ""
                    ? ButtonGradient(
                        text: "CONTACTER",
                        width: 120,
                        height: 35,
                        fontSize: 16,
                        onTap: () => controller.callBookSeller(),
                      )
                    : Container(),
                UserController.to.isBookSeller
                    ? Container()
                    : ButtonGradient(
                        text: "SUIVRE",
                        width: 120,
                        height: 35,
                        fontSize: 16,
                        onTap: () => print("click")),
                _.isMe
                    ? ButtonGradient(
                        text: "MODIFIER",
                        width: 120,
                        height: 35,
                        fontSize: 16,
                        onTap: () => Get.toNamed(Routes.EDIT_PROFIL))
                    : Container()
              ],
            ),
          ),
        ],
      ),
    );
  }

  _buildInfoBookSeller() {
    return Padding(
      padding: EdgeInsets.fromLTRB(20, 0, 20, 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: EdgeInsets.symmetric(vertical: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  "Horaires: ",
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 17,
                  ),
                ),
                SizedBox(height: 10),
                GetBuilder<BookSellerDetailController>(
                  builder: (_) {
                    if (_.bookSeller.openHour.isEmpty)
                      return Row(
                        children: <Widget>[
                          Text(
                            "Pas d'horaires spécifiés",
                            style: TextStyle(
                              fontSize: 14,
                              color: ConstantColor.greyDark,
                            ),
                          ),
                        ],
                      );
                    return Row(
                      children: <Widget>[
                        Text(
                            "Lundi:\nMardi:\nMercredi:\nJeudi:\nVendredi:\nSamedi:\nDimanche:"),
                        SizedBox(width: 20),
                        Text(_getHorraires()),
                      ],
                    );
                  },
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.only(top: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  "Description: ",
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 17,
                  ),
                ),
                SizedBox(height: 10),
                GetBuilder<BookSellerDetailController>(
                  builder: (_) => DescriptionTextWidget(
                    text: _.bookSeller.bio == ""
                        ? "Aucune description"
                        : _.bookSeller.bio,
                    style: TextStyle(
                      fontSize: 14,
                      color: ConstantColor.greyDark,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String _getHorraires() {
    String res = "";
    if (controller.bookSeller.openHour != null) {
      res += """
${controller.bookSeller.openHour["monday"] ?? "Pas d'horaires spécifiés"}
${controller.bookSeller.openHour["tuesday"] ?? "Pas d'horaires spécifiés"}
${controller.bookSeller.openHour["wednesday"] ?? "Pas d'horaires spécifiés"}
${controller.bookSeller.openHour["thursday"] ?? "Pas d'horaires spécifiés"}
${controller.bookSeller.openHour["friday"] ?? "Pas d'horaires spécifiés"}
${controller.bookSeller.openHour["saturday"] ?? "Pas d'horaires spécifiés"}
${controller.bookSeller.openHour["sunday"] ?? "Pas d'horaires spécifiés"}""";
    }
    return res;
  }

  _buildLastBooksWeek() {
    return GetBuilder<BookSellerDetailController>(builder: (_) {
      var length = _.bookSeller.listBooksWeek.length;
      if (length > 0)
        return Container(
          //height: 100,
          // color: Colors.blue,
          child: Column(
            children: [
              Row(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                    child: Text(
                      "Derniers Livres de la Semaine",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
              CarouselSlider.builder(
                itemCount: length,
                options: CarouselOptions(
                  viewportFraction: 1,
                  onPageChanged: (index, reason) => _.changePositionBook(index),
                ),
                itemBuilder: (ctx, index, realIndex) {
                  BookWeek bookWeek = _.bookSeller.listBooksWeek[index];
                  return GestureDetector(
                    onTap: () => Get.toNamed(Routes.BOOK_DETAIL,
                        arguments: Book(id: bookWeek.id)),
                    child: Container(
                      //color: index % 2 == 0 ? Colors.green : Colors.purple,
                      margin: EdgeInsets.symmetric(horizontal: 25),
                      child: Row(
                        children: <Widget>[
                          Container(
                            height: 150,
                            child: Hero(
                              tag: bookWeek.id,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(5),
                                child: bookWeek.picture != null &&
                                        bookWeek.picture != ""
                                    ? CachedNetworkImage(
                                        imageUrl: bookWeek.picture,
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
                          SizedBox(width: 25),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Text(
                                        bookWeek.title,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                          fontFamily: 'SF Pro Text',
                                          fontSize: 20,
                                          color: ConstantColor.black,
                                          fontWeight: FontWeight.w600,
                                          fontStyle: FontStyle.italic,
                                        ),
                                      ),
                                      SizedBox(height: 10),
                                      Text(
                                        "${bookWeek.author}  •  ${stringToDate(bookWeek.datePublished, 'yyyy').year}",
                                        style: TextStyle(
                                          fontFamily: 'SF Pro Text',
                                          fontSize: 14,
                                          color: ConstantColor.greyDark,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  flex: 2,
                                  child: DescriptionTextWidget(
                                    text: bookWeek.bio,
                                    showInPopup: true,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
              GetBuilder<BookSellerDetailController>(
                builder: (_) => DotsIndicator(
                  dotsCount: length,
                  position: _.bookPosition.toDouble(),
                ),
              ),
            ],
          ),
        );
      if (controller.isMe)
        return Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                    child: Text(
                      "Derniers Livres de la Semaine",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
              GestureDetector(
                onTap: () => Get.toNamed(Routes.SEARCH),
                child: Container(
                  height: 130,
                  width: 100,
                  margin: EdgeInsets.only(left: 20),
                  decoration: BoxDecoration(
                    color: ConstantColor.grey.withOpacity(.3),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(
                    child: Icon(
                      Icons.add,
                      color: ConstantColor.grey,
                      size: 50,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      return Container();
    });
  }

  _buildContactInfo() {
    return Container(
      //  color: Colors.yellow,
      padding: EdgeInsets.fromLTRB(20, 0, 20, 25),
      height: 250,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Adresse: ",
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 17,
            ),
          ),
          SizedBox(height: 10),
          Expanded(
            child: GetBuilder<BookSellerDetailController>(
              builder: (_) {
                if (_.bookSeller.coord == null) return Container();
                return GoogleMap(
                  initialCameraPosition: CameraPosition(
                    target: _.bookSeller.coord,
                    zoom: 12,
                  ),
                  markers: {
                    Marker(
                      markerId: MarkerId(_.bookSeller.id),
                      position: _.bookSeller.coord,
                    )
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
