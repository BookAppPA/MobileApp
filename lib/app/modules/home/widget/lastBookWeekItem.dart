import 'package:book_app/app/data/model/book.dart';
import 'package:book_app/app/data/model/lastBookWeek.dart';
import 'package:book_app/app/modules/widgets_global/custom_circular_progress.dart';
import 'package:book_app/app/routes/app_pages.dart';
import 'package:book_app/app/utils/constant/constant_image.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LastBookWeekItem extends StatelessWidget {
  final double width, height;
  final LastBookWeek book;

  LastBookWeekItem({this.width: 110, this.height: 170, @required this.book})
      : assert(book != null);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => book.bookId != null
          ? Get.toNamed(Routes.BOOK_DETAIL, arguments: Book(id: book.bookId, description: book.bio))
          : null,
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: width,
              height: height,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(5),
                child: book.picture != null && book.picture != ""
                    ? CachedNetworkImage(
                        imageUrl: book.picture,
                        fit: BoxFit.cover,
                        useOldImageOnUrlChange: true,
                        placeholder: (context, url) =>
                            CustomCircularProgress(radius: 15),
                        errorWidget: (context, url, error) => Icon(Icons.error),
                      )
                    : Image.asset(ConstantImage.noBookCover, fit: BoxFit.cover,),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
