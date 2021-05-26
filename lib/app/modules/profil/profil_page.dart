import 'package:book_app/app/data/model/book.dart';
import 'package:book_app/app/data/model/rating.dart';
import 'package:book_app/app/data/model/user.dart';
import 'package:book_app/app/modules/dialog/basic_dialog.dart';
import 'package:book_app/app/modules/profil/user_controller.dart';
import 'package:book_app/app/modules/widgets_global/book_item.dart';
import 'package:book_app/app/modules/widgets_global/button_gradient.dart';
import 'package:book_app/app/modules/widgets_global/custom_circular_progress.dart';
import 'package:book_app/app/utils/constant/constant_color.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'profil_controller.dart';
import 'widgets/rating_item.dart';

class ProfilPage extends StatelessWidget {
  final UserModel user;
  ProfilPage({@required this.user});

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
                                  onTap: () => isMe && user.picture == ""
                                      ? ProfilController.to.changePicture()
                                      : null,
                                  child: CircleAvatar(
                                    radius: 42,
                                    backgroundColor: Colors.white,
                                    child: CircleAvatar(
                                      child: isMe && user.picture == ""
                                          ? Align(
                                              alignment: Alignment.bottomRight,
                                              child: CircleAvatar(
                                                backgroundColor: Colors.white,
                                                radius: 12.0,
                                                child: Icon(
                                                  Icons.camera_alt,
                                                  size: 15.0,
                                                  color: Color(0xFF404040),
                                                ),
                                              ),
                                            )
                                          : Container(),
                                      radius: 40,
                                      backgroundImage: user.picture == ""
                                          ? AssetImage(
                                              'assets/defaut_user.jpeg')
                                          : NetworkImage(
                                              user.picture,
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
        ? Container(
            height: 250,
            //color: Colors.blue,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.fromLTRB(45, 20, 0, 20),
                  child: Text(
                    'Mes Derniers Livres',
                    style: TextStyle(
                      fontFamily: 'SF Pro Text',
                      fontSize: 20,
                      color: ConstantColor.greyDark,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                Expanded(
                  child: ListView.separated(
                    itemCount: 6,
                    scrollDirection: Axis.horizontal,
                    padding: EdgeInsets.fromLTRB(30, 0, 30, 15),
                    separatorBuilder: (context, index) => SizedBox(width: 15),
                    itemBuilder: (context, index) {
                      return BookItem(book: Book());
                    },
                  ),
                ),
              ],
            ),
          )
        : Container();
  }

  Widget _buildLastRatings() {
    return user.nbRatings > 0
        ? Container(
            height: 800,
            //color: Colors.blue,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.fromLTRB(45, 10, 0, 20),
                  child: Text(
                    'Mes Derniers Avis',
                    style: TextStyle(
                      fontFamily: 'SF Pro Text',
                      fontSize: 20,
                      color: ConstantColor.greyDark,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                Expanded(
                  child: ListView.separated(
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: 5,
                    padding: EdgeInsets.fromLTRB(40, 0, 40, 30),
                    separatorBuilder: (context, index) => SizedBox(height: 25),
                    itemBuilder: (context, index) {
                      return RatingItem(Rating());
                    },
                  ),
                ),
              ],
            ),
          )
        : Container();
  }
}
