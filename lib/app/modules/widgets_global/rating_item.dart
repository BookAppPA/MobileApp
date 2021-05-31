import 'package:book_app/app/data/model/book.dart';
import 'package:book_app/app/data/model/rating.dart';
import 'package:book_app/app/modules/profil/user_controller.dart';
import 'package:book_app/app/routes/app_pages.dart';
import 'package:book_app/app/utils/constant/constant_color.dart';
import 'package:book_app/app/utils/functions.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';

import 'custom_circular_progress.dart';

class RatingItem extends StatelessWidget {
  final Rating rating;
  RatingItem(this.rating) : assert(rating != null);

  @override
  Widget build(BuildContext context) {
    var isMe = rating.userId == UserController.to.user.id;
    return GestureDetector(
      onTap: () => rating.bookId != null
          ? Get.toNamed(Routes.BOOK_DETAIL, arguments: Book(id: rating.bookId))
          : null,
      child: Container(
        height: isMe ? 125 : 150,
        decoration: BoxDecoration(
          color: ConstantColor.greyWhite,
          borderRadius: BorderRadius.circular(20),
        ),
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        child: Row(
          children: <Widget>[
            Expanded(
              flex: 2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  isMe
                      ? Container()
                      : Padding(
                          padding: EdgeInsets.only(right: 20, top: 10),
                          child: GestureDetector(
                            onTap: () => print("open profil"),
                            child: Row(
                              children: <Widget>[
                                CircleAvatar(
                                  radius: 20,
                                  backgroundImage: rating.userImage == null ||
                                          rating.userImage == ""
                                      ? AssetImage('assets/defaut_user.jpeg')
                                      : NetworkImage(rating.userImage),
                                ),
                                SizedBox(width: 10),
                                Text(
                                  rating.userName,
                                  style: TextStyle(
                                    fontFamily: 'SF Pro Text',
                                    fontSize: 15,
                                    color: ConstantColor.greyDark,
                                    fontWeight: FontWeight.w700,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                  Padding(
                    padding: EdgeInsets.only(right: 20, top: 10, bottom: 5),
                    child: Text(
                      rating.message,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontFamily: 'SF Pro Text',
                        fontSize: 13,
                        color: Color(0xbf212121),
                        letterSpacing: 0.192,
                        fontWeight: FontWeight.w300,
                      ),
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
                        parseDateTime(rating.timestamp),
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
            Container(
              width: 65,
              color: Colors.grey,
              child: Hero(
                tag: rating.bookId ?? DateTime.now(),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(5),
                  child: rating.bookImage != null && rating.bookImage != ""
                      ? CachedNetworkImage(
                          imageUrl: rating.bookImage,
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
                              borderRadius: BorderRadius.circular(5)),
                        ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
