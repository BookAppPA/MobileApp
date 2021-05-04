import 'package:book_app/app/utils/constant/constant_color.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'widgets/button_gradient.dart';

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
      color: Colors.blue,
    );
  }

  Widget _buildLastRatings() {
    return Container(
      color: Colors.yellow,
    );
  }
}
