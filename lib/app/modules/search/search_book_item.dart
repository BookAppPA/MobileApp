import 'package:book_app/app/data/model/book.dart';
import 'package:book_app/app/modules/widgets_global/custom_circular_progress.dart';
import 'package:book_app/app/routes/app_pages.dart';
import 'package:book_app/app/utils/constant/constant_color.dart';
import 'package:book_app/app/utils/functions.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SearchBookItem extends StatelessWidget {
  final Book book;
  SearchBookItem(this.book) : assert(book != null);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => book.id != null
          ? Get.toNamed(Routes.BOOK_DETAIL, arguments: book)
          : null,
      child: Container(
        color: Colors.transparent,
        width: Get.width,
        child: Row(
          children: <Widget>[
            Container(
              height: 130,
              child: Hero(
                tag: book.id ?? DateTime.now(),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(5),
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
            SizedBox(width: 25),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    book.title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontFamily: 'SF Pro Text',
                      fontSize: 20,
                      color: ConstantColor.black,
                      fontWeight: FontWeight.w600,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    "${book.authors.first}  •  ${stringToDate(book.publishedDate, 'yyyy').year}",
                    style: TextStyle(
                      fontFamily: 'SF Pro Text',
                      fontSize: 14,
                      color: ConstantColor.greyDark,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
