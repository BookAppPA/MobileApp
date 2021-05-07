import 'package:book_app/app/data/model/rating.dart';
import 'package:book_app/app/utils/constant/constant_color.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'widgets/button_gradient.dart';
import 'widgets/rating_item.dart';

class ProfilPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
    return Container(
      // color: Colors.red,
      padding: EdgeInsets.fromLTRB(20, 50, 20, 20),
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
                      'Will Newman',
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
                      'Constantly travelling and keeping up to date with business related books.',
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
                      text: "Edit Profile",
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
                SizedBox(width: 50),
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
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLastBooks() {
    return Container(
      height: 275,
      //color: Colors.blue,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.fromLTRB(45, 20, 0, 20),
            child: Text(
              'Mes Dernier Livres',
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
                return Container(
                  height: 200,
                  width: 133,
                  color: Colors.grey,
                );
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
              'Mes Dernier Avis',
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
