import 'package:book_app/app/data/model/bookseller.dart';
import 'package:book_app/app/data/model/bookweek.dart';
import 'package:book_app/app/modules/bookseller/bookseller_detail/bookseller_detail_controller.dart';
import 'package:book_app/app/modules/profil/user_controller.dart';
import 'package:book_app/app/modules/profil/widgets/profil_app_bar.dart';
import 'package:book_app/app/modules/widgets_global/button_gradient.dart';
import 'package:book_app/app/modules/widgets_global/custom_circular_progress.dart';
import 'package:book_app/app/modules/widgets_global/description_text.dart';
import 'package:book_app/app/routes/app_pages.dart';
import 'package:book_app/app/translations/app_translations.dart';
import 'package:book_app/app/utils/constant/constant_color.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'book_week_item.dart';

class BookSellerDetailPage extends GetWidget<BookSellerDetailController> {
  final bool back;
  final BookSeller bookSeller;
  final BookSellerDetailController controller;
  BookSellerDetailPage({this.bookSeller, this.back: true, this.controller});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<BookSellerDetailController>(
        builder: (_) {
          if (_.loadData && _.errorMessage == "")
            return CustomCircularProgress(
                color: ConstantColor.accent, radius: 20);
          if (_.loadData && _.errorMessage != "")
            return Center(child: Text(_.errorMessage));
          return Container(
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
          );
        },
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
          Center(
            child: Container(
              height: 75,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    controller.bookSeller.nbFollowers.toString(),
                    style: TextStyle(
                      fontFamily: 'SF Pro Text',
                      fontSize: 24,
                      color: ConstantColor.greyDark,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(
                    AppTranslation.followers.tr,
                    style: TextStyle(
                      fontFamily: 'SF Pro Text',
                      fontSize: 13,
                      color: ConstantColor.greyDark,
                      letterSpacing: 0.16,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 10),
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
                        text: AppTranslation.contact.tr,
                        width: 120,
                        height: 35,
                        fontSize: 16,
                        onTap: () => controller.callBookSeller(),
                      )
                    : Container(),
                UserController.to.isBookSeller
                    ? Container()
                    : GetBuilder<UserController>(
                        builder: (_) {
                          bool isFollow = _.user.listFollowing.firstWhere(
                                  (item) => item.id == bookSeller.id,
                                  orElse: () => null) !=
                              null;
                          return ButtonGradient(
                            text: isFollow ? AppTranslation.noFollow.tr : AppTranslation.follow.tr,
                            width: 120,
                            height: 35,
                            fontSize: 16,
                            onTap: () => isFollow
                                ? controller.unFollowUser(controller.bookSeller)
                                : controller.followUser(controller.bookSeller),
                          );
                        },
                      ),
                _.isMe
                    ? ButtonGradient(
                        text: AppTranslation.edit.tr,
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
                  AppTranslation.openHours.tr,
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
                            AppTranslation.noOpenHoursSpecify.tr,
                            style: TextStyle(
                              fontSize: 14,
                              color: ConstantColor.greyDark,
                            ),
                          ),
                        ],
                      );
                    return Row(
                      children: <Widget>[
                        Text(AppTranslation.allDays.tr),
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
                  AppTranslation.description.tr,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 17,
                  ),
                ),
                SizedBox(height: 10),
                GetBuilder<BookSellerDetailController>(
                  builder: (_) => DescriptionTextWidget(
                    text: _.bookSeller.bio == ""
                        ? AppTranslation.noDescription.tr
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
${controller.bookSeller.openHour["monday"] ?? AppTranslation.noOpenHoursSpecify.tr}
${controller.bookSeller.openHour["tuesday"] ?? AppTranslation.noOpenHoursSpecify.tr}
${controller.bookSeller.openHour["wednesday"] ?? AppTranslation.noOpenHoursSpecify.tr}
${controller.bookSeller.openHour["thursday"] ?? AppTranslation.noOpenHoursSpecify.tr}
${controller.bookSeller.openHour["friday"] ?? AppTranslation.noOpenHoursSpecify.tr}
${controller.bookSeller.openHour["saturday"] ?? AppTranslation.noOpenHoursSpecify.tr}
${controller.bookSeller.openHour["sunday"] ?? AppTranslation.noOpenHoursSpecify.tr}""";
    }
    return res;
  }

  _buildLastBooksWeek() {
    if (controller.isMe)
      return GetBuilder<UserController>(builder: (_) {
        var length = _.bookseller.listBooksWeek.length;
        if (length > 0)
          return Container(
            //height: 100,
            // color: Colors.blue,
            child: Column(
              children: [
                Row(
                  children: <Widget>[
                    Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                      child: Text(
                        AppTranslation.lastBookWeek.tr,
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
                    onPageChanged: (index, reason) =>
                        controller.changePositionBook(index),
                  ),
                  itemBuilder: (ctx, index, realIndex) {
                    BookWeek bookWeek = _.bookseller.listBooksWeek[index];
                    return BookWeekItem(bookWeek);
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

        return Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                    child: Text(
                      AppTranslation.lastBookWeek.tr,
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
      });

    return GetBuilder<BookSellerDetailController>(
      builder: (__) {
        var length = __.bookSeller.listBooksWeek.length;
        if (length > 0)
          return Container(
            //height: 100,
            // color: Colors.blue,
            child: Column(
              children: [
                Row(
                  children: <Widget>[
                    Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                      child: Text(
                        AppTranslation.lastBookWeek.tr,
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
                    onPageChanged: (index, reason) =>
                        __.changePositionBook(index),
                  ),
                  itemBuilder: (ctx, index, realIndex) {
                    BookWeek bookWeek = __.bookSeller.listBooksWeek[index];
                    return BookWeekItem(bookWeek);
                  },
                ),
                GetBuilder<BookSellerDetailController>(
                  builder: (___) => DotsIndicator(
                    dotsCount: length,
                    position: ___.bookPosition.toDouble(),
                  ),
                ),
              ],
            ),
          );
        return Container();
      },
    );
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
            AppTranslation.address.tr,
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
