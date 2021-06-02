import 'package:book_app/app/data/model/user.dart';
import 'package:book_app/app/data/repository/auth_repository.dart';
import 'package:book_app/app/data/repository/user_repository.dart';
import 'package:book_app/app/modules/dialog/basic_dialog.dart';
import 'package:book_app/app/modules/profil/user_controller.dart';
import 'package:book_app/app/modules/widgets_global/book_item.dart';
import 'package:book_app/app/modules/widgets_global/button_gradient.dart';
import 'package:book_app/app/modules/widgets_global/custom_circular_progress.dart';
import 'package:book_app/app/utils/constant/constant_color.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'profil_controller.dart';
import 'widgets/user_rating_item.dart';

class ProfilPage extends StatelessWidget {
  final UserModel user;
  final bool back;
  ProfilPage({this.user, this.back: false}) {
    if (user != null && user.pseudo != null) {
      Get.put(ProfilController(
          authRepository: AuthRepository(),
          userRepository: UserRepository(),
          user: user));
    }
  }

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
          controller.isMe
              ? Container(
                  padding: EdgeInsets.only(top: 25, right: 15, left: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      back
                          ? IconButton(
                              icon: Icon(
                                Icons.arrow_back_ios,
                                color: Color(0xbf212121),
                              ),
                              onPressed: () {
                                FocusScope.of(Get.context).unfocus();
                                Get.back();
                              },
                            )
                          : Container(),
                      IconButton(
                        icon: Icon(
                          FontAwesomeIcons.powerOff,
                          color: Color(0xbf212121),
                        ),
                        onPressed: () => BasicDialog.showLogoutDialog(
                            onConfirm: () => ProfilController.to.clickLogout()),
                      ),
                    ],
                  ),
                )
              : Container(),
          Container(
            padding: EdgeInsets.fromLTRB(20, controller.isMe ? 10 : 50, 20, 20),
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
                            ProfilController.to.user.pseudo,
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
                            builder: (_) => Text(
                              _.user.bio ?? "Aucune bio",
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
                            ),
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
                                    onTap: () => controller.isMe
                                        ? controller.changePicture()
                                        : null,
                                    child: CircleAvatar(
                                      radius: 42,
                                      backgroundColor: Colors.white,
                                      child: GetBuilder<UserController>(
                                        builder: (_) => CircleAvatar(
                                          child: controller.isMe &&
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
                                                      color: Color(0xFF404040),
                                                    ),
                                                  ),
                                                )
                                              : _.loadingPicture
                                                  ? CustomCircularProgress(
                                                      color:
                                                          ConstantColor.accent)
                                                  : Container(),
                                          radius: 40,
                                          backgroundImage: _.user.picture ==
                                                      null ||
                                                  _.user.picture == ""
                                              ? AssetImage(
                                                  'assets/defaut_user.jpeg')
                                              : NetworkImage(ProfilController
                                                  .to.user.picture),
                                        ),
                                      ),
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
                    Expanded(
                      flex: 2,
                      child: Row(
                        children: <Widget>[
                          Column(
                            children: <Widget>[
                              Text(
                                "${ProfilController.to.user.nbBooks}",
                                style: TextStyle(
                                  fontFamily: 'SF Pro Text',
                                  fontSize: 24,
                                  color: ConstantColor.greyDark,
                                  fontWeight: FontWeight.w700,
                                ),
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
                                "${ProfilController.to.user.nbRatings}",
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
                          Column(
                            children: <Widget>[
                              Text(
                                "${ProfilController.to.user.nbFollowers}",
                                style: TextStyle(
                                  fontFamily: 'SF Pro Text',
                                  fontSize: 24,
                                  color: ConstantColor.greyDark,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              SizedBox(height: 5),
                              Text(
                                'Followers',
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
                        ],
                      ),
                    ),

                    Expanded(
                      child: Column(
                        children: <Widget>[
                          ButtonGradient(
                            width: 175,
                            onTap: () => controller.isMe
                                ? ProfilController.to.clickEditProfil()
                                : ProfilController.to.clickFollow(),
                            text: controller.isMe ? "Modifier" : "Suivre",
                          ),
                          
                          SizedBox(height: 20),

                          controller.isMe
                            ? Column(
                                children: <Widget>[
                                  ButtonGradient(
                                    width: 175,
                                    onTap: () => ProfilController.to.clickFinishBook(),
                                    text: "J'ai finis un livre",
                                  ),
                                ],
                              )
                            : Container(),
                        ],
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLastBooks() {
    return ProfilController.to.books.length > 0
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
    return ProfilController.to.ratings.length > 0
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
                    child: ListView.separated(
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: _.ratings.length <= 5 ? _.ratings.length : 5,
                      padding: EdgeInsets.fromLTRB(30, 0, 30, 30),
                      separatorBuilder: (context, index) =>
                          SizedBox(height: 25),
                      itemBuilder: (context, index) {
                        return UserRatingItem(_.ratings[index], _.books[index]);
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
