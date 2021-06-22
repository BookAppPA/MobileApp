import 'package:book_app/app/data/model/rating.dart';
import 'package:book_app/app/data/model/user.dart';
import 'package:book_app/app/modules/profil/user_controller.dart';
import 'package:book_app/app/routes/app_pages.dart';
import 'package:book_app/app/utils/constant/constant_color.dart';
import 'package:book_app/app/utils/functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';

import 'description_text.dart';

class RatingItem extends StatelessWidget {
  final Rating rating;
  RatingItem(this.rating) : assert(rating != null);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.grey[100],
      elevation: 3,
      child: Container(
        height: rating.message.length < 75 ? 180 : 200,
        padding: EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            GestureDetector(
              onTap: () => rating.userId != null
                  ? Get.toNamed(Routes.PROFIL,
                      arguments: UserController.to.isBookSeller ? UserModel(id: rating.userId) : rating.userId == UserController.to.user.id
                          ? UserController.to.user
                          : UserModel(id: rating.userId))
                  : null,
              child: Container(
                color: Colors.transparent,
                child: Row(
                  children: <Widget>[
                    CircleAvatar(
                      radius: 20,
                      backgroundImage:
                          rating.userImage == null || rating.userImage == ""
                              ? AssetImage('assets/defaut_user.jpeg')
                              : NetworkImage(rating.userImage),
                    ),
                    SizedBox(width: 15),
                    Expanded(
                      child: Text(
                        rating.userName,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontFamily: 'SF Pro Text',
                          fontSize: 15,
                          color: ConstantColor.black,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              color: Colors.transparent,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(top: 10, bottom: 5),
                    child: Text(
                      rating.title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontFamily: 'SF Pro Text',
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: 5),
                    child: DescriptionTextWidget(
                      text: rating.message,
                      showInPopup: true,
                      maxLength: 130,
                      style: TextStyle(
                        fontFamily: 'SF Pro Text',
                        fontSize: 13,
                        color: Color(0xbf212121),
                        letterSpacing: 0.192,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Row(
              children: [
                RatingBar.builder(
                  initialRating: rating.note.toDouble(),
                  minRating: 1,
                  direction: Axis.horizontal,
                  itemCount: 5,
                  itemSize: 20,
                  ignoreGestures: true,
                  itemBuilder: (context, _) => Icon(
                    Icons.star,
                    color: Colors.amber,
                  ),
                  onRatingUpdate: (_) {},
                ),
                SizedBox(width: 10),
                Text(
                  parseDateTime(rating.timestamp, "dd/MM/yyyy HH:mm"),
                  style: TextStyle(
                    fontFamily: 'SF Pro Text',
                    fontSize: 12,
                    color: Color(0xbf212121),
                    letterSpacing: 0.192,
                    fontWeight: FontWeight.w300,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
