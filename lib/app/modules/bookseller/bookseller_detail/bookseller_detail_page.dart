import 'package:book_app/app/data/model/book.dart';
import 'package:book_app/app/data/model/bookweek.dart';
import 'package:book_app/app/modules/bookseller/bookseller_detail/bookseller_detail_controller.dart';
import 'package:book_app/app/modules/widgets_global/back_button_appbar.dart';
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BackButtonAppBar(textTitle: controller.bookSeller.name),
      body: Container(
        width: Get.width,
        height: Get.height,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              controller.bookSeller.phone != ""
                  ? ButtonGradient(
                      text: "CONTACTER",
                      width: 120,
                      height: 35,
                      fontSize: 16,
                      onTap: () => controller.callBookSeller(),
                    )
                  : Container(),
              ButtonGradient(
                  text: "SUIVRE",
                  width: 120,
                  height: 35,
                  fontSize: 16,
                  onTap: () => print("click")),
            ],
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
                  "Horraires: ",
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 17,
                  ),
                ),
                SizedBox(height: 10),
                Row(
                  children: <Widget>[
                    Text(
                        "Lundi:\nMardi:\nMercredi:\nJeudi:\nVendredi:\nSamedi:\nDimanche:"),
                    SizedBox(width: 20),
                    Text(_getHorraires()),
                  ],
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
                DescriptionTextWidget(
                  text: controller.bookSeller.bio,
                  style: TextStyle(
                    fontSize: 14,
                    color: ConstantColor.greyDark,
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
${controller.bookSeller.openHour["monday"]}
${controller.bookSeller.openHour["tuesday"]}
${controller.bookSeller.openHour["wednesday"]}
${controller.bookSeller.openHour["thursday"]}
${controller.bookSeller.openHour["friday"]}
${controller.bookSeller.openHour["saturday"]}
${controller.bookSeller.openHour["sunday"]}""";
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
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 25),
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
              builder: (_) => GoogleMap(
                initialCameraPosition: CameraPosition(
                  target: LatLng(_.location.latitude, _.location.longitude),
                  zoom: 12,
                ),
                markers: {
                  Marker(
                      markerId: MarkerId(_.bookSeller.id),
                      position:
                          LatLng(_.location.latitude, _.location.longitude))
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
