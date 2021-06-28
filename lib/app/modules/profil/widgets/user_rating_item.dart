import 'package:book_app/app/data/model/book.dart';
import 'package:book_app/app/data/model/rating.dart';
import 'package:book_app/app/modules/widgets_global/custom_circular_progress.dart';
import 'package:book_app/app/modules/widgets_global/description_text.dart';
import 'package:book_app/app/routes/app_pages.dart';
import 'package:book_app/app/utils/constant/constant_color.dart';
import 'package:book_app/app/utils/functions.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import '../user_controller.dart';

class UserRatingItem extends StatelessWidget {
  final Rating rating;
  final Book book;
  UserRatingItem(this.rating, this.book) {
    assert(rating != null);
    assert(book != null);
    isMyRating = UserController.to.isBookSeller
        ? false
        : UserController.to.user.id == rating.userId
            ? true
            : false;
  }

  bool isMyRating;

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
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                GestureDetector(
                  onTap: () => book.id != null
                      ? Get.toNamed(Routes.BOOK_DETAIL, arguments: book)
                      : null,
                  child: Container(
                    color: Colors.transparent,
                    child: Row(
                      children: <Widget>[
                        Container(
                          height: 45,
                          child: rating.bookImage != null &&
                                  rating.bookImage != ""
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
                                  decoration: BoxDecoration(color: Colors.grey),
                                ),
                        ),
                        SizedBox(width: 15),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                rating.bookTitle,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontFamily: 'SF Pro Text',
                                  fontSize: 17,
                                  color: ConstantColor.black,
                                  fontWeight: FontWeight.w600,
                                  fontStyle: FontStyle.italic,
                                ),
                              ),
                              SizedBox(height: 5),
                              Text(
                                "${rating.bookAuthor}  •  ${getYear(rating.bookPublished)}",
                                style: TextStyle(
                                  fontFamily: 'SF Pro Text',
                                  fontSize: 14,
                                  color: ConstantColor.greyDark,
                                ),
                              ),
                            ],
                          ),
                        ),
                        isMyRating
                            ? Row(
                                children: <Widget>[
                                  GestureDetector(
                                    onTap: () => UserController.to.updateRating(rating),
                                    child: Icon(Icons.edit),
                                  ),
                                  SizedBox(width: 10),
                                  GestureDetector(
                                    onTap: () => UserController.to.deleteRating(rating),
                                    child: Icon(Icons.close),
                                  ),
                                ],
                              )
                            : Container()
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 10),
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
              ],
            ),
            Row(
              children: [
                RatingBar.builder(
                  initialRating: rating.note.toDouble(),
                  minRating: 0,
                  direction: Axis.horizontal,
                  itemCount: 5,
                  itemSize: 20,
                  ignoreGestures: true,
                  allowHalfRating: true,
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
