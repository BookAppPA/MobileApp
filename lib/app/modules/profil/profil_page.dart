import 'package:book_app/app/data/model/book.dart';
import 'package:book_app/app/data/model/rating.dart';
import 'package:book_app/app/data/model/user.dart';
import 'package:book_app/app/modules/dialog/basic_dialog.dart';
import 'package:book_app/app/modules/profil/user_controller.dart';
import 'package:book_app/app/modules/widgets_global/book_item.dart';
import 'package:book_app/app/modules/widgets_global/button_gradient.dart';
import 'package:book_app/app/utils/constant/constant_color.dart';
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
        isMe ?
        Container(
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
        ) : Container(),
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
                        Text(
                          user.bio ?? "Aucune bio",
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontFamily: 'SF Pro Text',
                            fontSize: 13,
                            color: Color(0x80212121),
                            letterSpacing: 0.16,
                            fontWeight: FontWeight.w300,
                          ),
                          textAlign: TextAlign.left,
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      children: <Widget>[
                        CircleAvatar(radius: 42),
                        SizedBox(height: 20),
                        ButtonGradient(
                          onTap: () => print("clic edit profil"),
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
                          '21',
                          style: TextStyle(
                            fontFamily: 'SF Pro Text',
                            fontSize: 24,
                            color: Color(0x80212121),
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        SizedBox(height: 5),
                        Text(
                          'Livres',
                          style: TextStyle(
                            fontFamily: 'SF Pro Text',
                            fontSize: 13,
                            color: Color(0x80212121),
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
                          '5',
                          style: TextStyle(
                            fontFamily: 'SF Pro Text',
                            fontSize: 24,
                            color: Color(0x80212121),
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        SizedBox(height: 5),
                        Text(
                          'Avis',
                          style: TextStyle(
                            fontFamily: 'SF Pro Text',
                            fontSize: 13,
                            color: Color(0x80212121),
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
                          '19',
                          style: TextStyle(
                            fontFamily: 'SF Pro Text',
                            fontSize: 24,
                            color: Color(0x80212121),
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        SizedBox(height: 5),
                        Text(
                          'Followers',
                          style: TextStyle(
                            fontFamily: 'SF Pro Text',
                            fontSize: 13,
                            color: Color(0x80212121),
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
    return Container(
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
                color: Color(0x80212121),
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
    );
  }

  Widget _buildLastRatings() {
    return Container(
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
                color: Color(0x80212121),
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
    );
  }
}
