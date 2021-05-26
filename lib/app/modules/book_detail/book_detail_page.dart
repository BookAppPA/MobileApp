import 'package:book_app/app/data/model/book.dart';
import 'package:book_app/app/modules/widgets_global/back_button_appbar.dart';
import 'package:book_app/app/modules/widgets_global/button_gradient.dart';
import 'package:book_app/app/modules/widgets_global/custom_circular_progress.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';

class BookDetailPage extends StatelessWidget {
  final Book book = Get.arguments as Book;

  @override
  Widget build(BuildContext context) {
    if (book == null) Get.back();
    return Scaffold(
      appBar: BackButtonAppBar(),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(bottom: 25, left: 50, right: 50),
                child: Text(
                  book.title.toUpperCase(),
                  maxLines: 2,
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontFamily: 'SF Pro Text',
                    fontSize: 24,
                    color: Color(0xbf212121),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Container(
                width: 180,
                height: 275,
                child: Hero(
                  tag: book.id ?? DateTime.now(),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(23),
                    child: book.coverImage != null && book.coverImage != ""
                      ? CachedNetworkImage(
                          imageUrl: book.coverImage,
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
              SizedBox(height: 25),
              ButtonGradient(
                onTap: () => print("clic preview"),
                width: 166,
                height: 40,
                text: "PREVIEW",
                fontSize: 15,
              ),
              SizedBox(height: 25),
              book.description != null && book.description != ""
                  ? Padding(
                      padding: EdgeInsets.only(bottom: 25),
                      child: Text(
                        book.description,
                        style: TextStyle(
                          fontFamily: 'SF Pro Text',
                          fontSize: 13,
                          color: Color(0x80212121),
                          letterSpacing: 0.16,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                    )
                  : Container(),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text("Note Moyenne"),
                  SizedBox(width: 20),
                  RatingBar.builder(
                    initialRating: 3,
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
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
