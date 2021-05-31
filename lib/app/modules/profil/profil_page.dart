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
  ProfilPage({@required this.user}) {
    Get.put(ProfilController(
        authRepository: AuthRepository(),
        userRepository: UserRepository(),
        user: user));
  }

  bool isMe = false;

  @override
  Widget build(BuildContext context) {
    isMe = user.id == UserController.to.user.id;
    return Scaffold(
      body: Container(
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
    );
  }

  Widget _buildInfoUser() {
    return Column(
      children: [
        isMe
            ? Container(
                padding: EdgeInsets.only(top: 25, right: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
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
          padding: EdgeInsets.fromLTRB(20, isMe ? 10 : 50, 20, 20),
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
                          user.pseudo,
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
                                  onTap: () => isMe
                                      ? ProfilController.to.changePicture()
                                      : null,
                                  child: CircleAvatar(
                                    radius: 42,
                                    backgroundColor: Colors.white,
                                    child: GetBuilder<UserController>(
                                      builder: (_) => CircleAvatar(
                                        child: isMe &&
                                                (_.user.picture == null ||
                                                    _.user.picture == "")
                                            ? Align(
                                                alignment:
                                                    Alignment.bottomRight,
                                                child: CircleAvatar(
                                                  backgroundColor: Colors.white,
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
                                                    color: ConstantColor.accent)
                                                : Container(),
                                        radius: 40,
                                        backgroundImage:
                                            _.user.picture == null ||
                                                    _.user.picture == ""
                                                ? AssetImage(
                                                    'assets/defaut_user.jpeg')
                                                : NetworkImage(user.picture),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 20),
                        ButtonGradient(
                          onTap: () => isMe
                              ? ProfilController.to.clickEditProfil()
                              : ProfilController.to.clickFollow(),
                          text: isMe ? "Modifier" : "Suivre",
                        ),
                      ],
                    ),
                  )
                ],
              ),

              //PROFIL
              Padding(
                padding: EdgeInsets.only(left: 10),
                child: Row(
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        Text(
                          "${user.nbBooks}",
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
                          "${user.nbRatings}",
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
                          "${user.nbFollowers}",
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
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildLastBooks() {
    return user.nbBooks > 0
        ? GetBuilder<UserController>(
            builder: (_) => Container(
              height: 250,
              //color: Colors.blue,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.fromLTRB(30, 20, 45, 20),
                    child: GestureDetector(
                      onTap: () => print("click last books"),
                      child: Container(
                        color: Colors.transparent,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Mes Derniers Livres',
                              style: TextStyle(
                                fontFamily: 'SF Pro Text',
                                fontSize: 20,
                                color: ConstantColor.greyDark,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            Icon(
                              FontAwesomeIcons.chevronRight,
                              color: ConstantColor.greyDark,
                              size: 20,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: ListView.separated(
                      itemCount: _.user.listBooksRead.length <= 5
                          ? _.user.listBooksRead.length
                          : 5,
                      scrollDirection: Axis.horizontal,
                      padding: EdgeInsets.fromLTRB(30, 0, 30, 15),
                      separatorBuilder: (context, index) => SizedBox(width: 15),
                      itemBuilder: (context, index) {
                        return BookItem(book: _.user.listBooksRead[index]);
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
    return user.nbRatings > 0
        ? GetBuilder<UserController>(
            builder: (_) => Container(
              height: 800,
              //color: Colors.blue,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.fromLTRB(30, 10, 45, 20),
                    child: GestureDetector(
                      onTap: () => print("click last ratings"),
                      child: Container(
                        color: Colors.transparent,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Mes Derniers Avis',
                              style: TextStyle(
                                fontFamily: 'SF Pro Text',
                                fontSize: 20,
                                color: ConstantColor.greyDark,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            Icon(
                              FontAwesomeIcons.chevronRight,
                              color: ConstantColor.greyDark,
                              size: 20,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: ListView.separated(
                      physics: NeverScrollableScrollPhysics(),
                      itemCount:  _.user.listLastRatings.length <= 5
                          ? _.user.listLastRatings.length
                          : 5,
                      padding: EdgeInsets.fromLTRB(30, 0, 30, 30),
                      separatorBuilder: (context, index) =>
                          SizedBox(height: 25),
                      itemBuilder: (context, index) {
                        return UserRatingItem(_.user.listLastRatings[index]);
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
