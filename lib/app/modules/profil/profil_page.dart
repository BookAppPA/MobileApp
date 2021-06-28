import 'package:book_app/app/data/model/book.dart';
import 'package:book_app/app/data/model/rating.dart';
import 'package:book_app/app/modules/profil/user_controller.dart';
import 'package:book_app/app/modules/widgets_global/book_item.dart';
import 'package:book_app/app/modules/widgets_global/button_gradient.dart';
import 'package:book_app/app/modules/widgets_global/custom_circular_progress.dart';
import 'package:book_app/app/modules/widgets_global/snackbar.dart';
import 'package:book_app/app/routes/app_pages.dart';
import 'package:book_app/app/utils/constant/constant_color.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'profil_controller.dart';
import 'widgets/profil_app_bar.dart';
import 'widgets/user_rating_item.dart';

class ProfilPage extends GetWidget<ProfilController> {
  final bool back;
  final ProfilController controller;
  ProfilPage({this.back: false, this.controller});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<ProfilController>(
        builder: (_) => _.loadData && _.errorMessage == ""
            ? CustomCircularProgress(color: ConstantColor.accent, radius: 20)
            : _.loadData && _.errorMessage != ""
                ? Center(child: Text(_.errorMessage))
                : Container(
                    width: Get.width,
                    height: Get.height,
                    child: SingleChildScrollView(
                      child: Center(
                        child: Column(
                          children: <Widget>[
                            _buildInfoUser(),
                            _buildLastBooks(),
                            _buildLastRatings(),
                          ],
                        ),
                      ),
                    ),
                  ),
      ),
    );
  }

  Widget _buildInfoUser() {
    return GetBuilder<ProfilController>(
      builder: (controller) => Column(
        children: [
          ProfilAppBar(
            isMe: ProfilController.to.isMe,
            back: back,
          ),
          Container(
            padding: EdgeInsets.fromLTRB(20, 10, 20, 20),
            child: Column(
              children: <Widget>[
                //INFOS
                Row(
                  children: <Widget>[
                    Expanded(
                      flex: 2,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            controller.user.pseudo,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontFamily: 'SF Pro Text',
                              fontSize: 24,
                              color: Color(0xbf212121),
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(height: 20),
                          GetBuilder<UserController>(
                            builder: (_) {
                              String bio;
                              if (_.isBookSeller || !controller.isMe) {
                                if (controller.user.bio != null)
                                  bio = controller.user.bio;
                                else
                                  bio = "Aucune bio";
                              } else if (controller.isMe) {
                                if (_.user.bio != null)
                                  bio = _.user.bio;
                                else
                                  bio = "Aucune bio";
                              }
                              return Text(
                                bio,
                                maxLines: 3,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontFamily: 'SF Pro Text',
                                  fontSize: 13,
                                  color: ConstantColor.greyDark,
                                  letterSpacing: 0.16,
                                  fontWeight: FontWeight.w300,
                                ),
                                textAlign: TextAlign.left,
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        children: <Widget>[
                          Stack(
                            children: [
                              Align(
                                alignment: Alignment.topCenter,
                                child: SizedBox(
                                  child: GestureDetector(
                                    onTap: () => controller.isMe &&
                                            (controller.user.picture == null ||
                                                controller.user.picture == "")
                                        ? controller.changePicture()
                                        : controller.isMe
                                            ? CustomSnackbar.snackbar(
                                                "Vous ne pouvez plus modifier votre photo")
                                            : null,
                                    child: CircleAvatar(
                                      radius: 42,
                                      backgroundColor: Colors.white,
                                      child: GetBuilder<UserController>(
                                          builder: (_) {
                                        ImageProvider picture;
                                        if (_.isBookSeller ||
                                            !controller.isMe) {
                                          if (controller.user.picture != "")
                                            picture = NetworkImage(
                                                controller.user.picture);
                                          else
                                            picture = AssetImage(
                                                'assets/defaut_user.jpeg');
                                        } else if (controller.isMe) {
                                          if (_.user.picture != "")
                                            picture =
                                                NetworkImage(_.user.picture);
                                          else
                                            picture = AssetImage(
                                                'assets/defaut_user.jpeg');
                                        }
                                        return CircleAvatar(
                                          child: _.isBookSeller
                                              ? Container()
                                              : controller.isMe &&
                                                      (_.user.picture == null ||
                                                          _.user.picture == "")
                                                  ? Align(
                                                      alignment:
                                                          Alignment.bottomRight,
                                                      child: CircleAvatar(
                                                        backgroundColor:
                                                            Colors.white,
                                                        radius: 12,
                                                        child: Icon(
                                                          Icons.camera_alt,
                                                          size: 15,
                                                          color:
                                                              Color(0xFF404040),
                                                        ),
                                                      ),
                                                    )
                                                  : _.loadingPicture
                                                      ? CustomCircularProgress(
                                                          color: ConstantColor
                                                              .accent)
                                                      : Container(),
                                          radius: 40,
                                          backgroundImage: picture,
                                        );
                                      }),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    )
                  ],
                ),

                //PROFIL
                SizedBox(height: 20),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      children: <Widget>[
                        GetBuilder<UserController>(
                          builder: (_) {
                            int nbBooks;
                            if (_.isBookSeller || !controller.isMe) {
                              nbBooks = controller.user.nbBooks;
                            } else if (controller.isMe) {
                              nbBooks = _.user.nbBooks;
                            }
                            return Text(
                              "$nbBooks",
                              style: TextStyle(
                                fontFamily: 'SF Pro Text',
                                fontSize: 24,
                                color: ConstantColor.greyDark,
                                fontWeight: FontWeight.w700,
                              ),
                            );
                          },
                        ),
                        SizedBox(height: 5),
                        Text(
                          'Livres',
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
                    SizedBox(width: 40),
                    Column(
                      children: <Widget>[
                        Text(
                          "${controller.user.nbRatings}",
                          style: TextStyle(
                            fontFamily: 'SF Pro Text',
                            fontSize: 24,
                            color: ConstantColor.greyDark,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        SizedBox(height: 5),
                        Text(
                          'Avis',
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
                    SizedBox(width: 40),
                    GestureDetector(
                      onTap: () {
                        if (controller.user.nbFollowers > 0)
                          Get.toNamed(Routes.LIST_FOLLOWERS,
                              arguments: controller.user.id);
                      },
                      child: Column(
                        children: <Widget>[
                          Text(
                            "${controller.user.nbFollowers}",
                            style: TextStyle(
                              fontFamily: 'SF Pro Text',
                              fontSize: 24,
                              color: ConstantColor.greyDark,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          SizedBox(height: 5),
                          Text(
                            'Abonnés',
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
                    controller.isMe
                        ? Row(
                            children: <Widget>[
                              SizedBox(width: 30),
                              GetBuilder<UserController>(
                                builder: (_) {
                                  return GestureDetector(
                                    onTap: () {
                                      if (_.user.nbFollowing > 0)
                                        Get.toNamed(Routes.LIST_FOLLOWING,
                                            arguments: _.user.id);
                                    },
                                    child: Column(
                                      children: <Widget>[
                                        Text(
                                          "${_.user.nbFollowing}",
                                          style: TextStyle(
                                            fontFamily: 'SF Pro Text',
                                            fontSize: 24,
                                            color: ConstantColor.greyDark,
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                        SizedBox(height: 5),
                                        Text(
                                          'Abonnements',
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
                                  );
                                },
                              ),
                            ],
                          )
                        : Expanded(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: <Widget>[
                                GetBuilder<UserController>(builder: (_) {
                                  var isFollow = _.user.listFollowing
                                          .firstWhere(
                                              (item) =>
                                                  item.id == controller.user.id,
                                              orElse: () => null) !=
                                      null;
                                  return ButtonGradient(
                                    width: 130,
                                    onTap: () => isFollow
                                        ? controller
                                            .unFollowUser(controller.user)
                                        : controller
                                            .followUser(controller.user),
                                    text:
                                        isFollow ? "Ne plus suivre" : "Suivre",
                                  );
                                }),
                              ],
                            ),
                          ),
                  ],
                ),
                UserController.to.isBookSeller || !controller.isMe
                    ? Container()
                    : Padding(
                        padding: EdgeInsets.fromLTRB(10, 20, 10, 0),
                        child: Column(
                          children: <Widget>[
                            GetBuilder<UserController>(builder: (_) {
                              var isFollow = !controller.isMe &&
                                  _.user.listFollowing.firstWhere(
                                          (item) =>
                                              item.id == controller.user.id,
                                          orElse: () => null) !=
                                      null;
                              return ButtonGradient(
                                width: Get.width,
                                height: 40,
                                onTap: () => controller.isMe
                                    ? controller.clickEditProfil()
                                    : isFollow
                                        ? controller
                                            .unFollowUser(controller.user)
                                        : controller
                                            .followUser(controller.user),
                                text: controller.isMe
                                    ? "Modifier le profil"
                                    : isFollow
                                        ? "Ne plus suivre"
                                        : "Suivre",
                              );
                            }),
                            SizedBox(height: 20),
                            controller.isMe
                                ? ButtonGradient(
                                    width: Get.width,
                                    height: 40,
                                    onTap: () => controller.clickFinishBook(),
                                    text: "J'ai finis un livre",
                                  )
                                : Container(),
                          ],
                        ),
                      ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLastBooks() {
    return controller.books.length > 0
        ? GetBuilder<ProfilController>(
            builder: (_) => Container(
              height: 250,
              //color: Colors.blue,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.fromLTRB(30, 10, 45, 20),
                    child: GestureDetector(
                      onTap: () =>
                          _.books.length > 5 ? print("click last books") : null,
                      child: Container(
                        color: Colors.transparent,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "${_.isMe ? 'Mes' : 'Ses'} Derniers Livres",
                              style: TextStyle(
                                fontFamily: 'SF Pro Text',
                                fontSize: 20,
                                color: ConstantColor.greyDark,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            _.books.length > 5
                                ? Icon(
                                    FontAwesomeIcons.chevronRight,
                                    color: ConstantColor.greyDark,
                                    size: 20,
                                  )
                                : Container(),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: ListView.separated(
                      itemCount: _.books.length <= 5 ? _.books.length : 5,
                      scrollDirection: Axis.horizontal,
                      padding: EdgeInsets.fromLTRB(30, 0, 30, 15),
                      separatorBuilder: (context, index) => SizedBox(width: 15),
                      itemBuilder: (context, index) {
                        return BookItem(book: _.books[index]);
                      },
                    ),
                  ),
                ],
              ),
            ),
          )
        : Container();
  }

  Widget _buildLastRatings() {
    return controller.ratings.length > 0
        ? GetBuilder<ProfilController>(
            builder: (_) => Container(
              height: _.ratings.length <= 5
                  ? (_.ratings.length * 250).toDouble()
                  : 800,
              //color: Colors.blue,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.fromLTRB(30, 10, 45, 20),
                    child: GestureDetector(
                      onTap: () => _.ratings.length > 5
                          ? print("click last ratings")
                          : null,
                      child: Container(
                        color: Colors.transparent,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              '${_.isMe ? 'Mes' : 'Ses'} Derniers Avis',
                              style: TextStyle(
                                fontFamily: 'SF Pro Text',
                                fontSize: 20,
                                color: ConstantColor.greyDark,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            _.ratings.length > 5
                                ? Icon(
                                    FontAwesomeIcons.chevronRight,
                                    color: ConstantColor.greyDark,
                                    size: 20,
                                  )
                                : Container(),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: GetBuilder<UserController>(
                      builder: (userController) {
                        List<Rating> list;
                        if (userController.isBookSeller || !controller.isMe) {
                          list = controller.ratings;
                        } else if (controller.isMe) {
                          list = userController.user.listLastRatings;
                        }
                        return ListView.separated(
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: list.length <= 5 ? list.length : 5,
                          padding: EdgeInsets.fromLTRB(30, 0, 30, 30),
                          separatorBuilder: (context, index) =>
                              SizedBox(height: 25),
                          itemBuilder: (context, index) {
                            var book = _.books.firstWhere(
                                (book) => list[index].bookId == book.id,
                                orElse: () => Book(id: list[index].bookId));
                            return UserRatingItem(list[index], book);
                          },
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          )
        : Container();
  }
}
