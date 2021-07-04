import 'package:book_app/app/data/model/book.dart';
import 'package:book_app/app/data/model/bookweek.dart';
import 'package:book_app/app/modules/widgets_global/custom_circular_progress.dart';
import 'package:book_app/app/modules/widgets_global/description_text.dart';
import 'package:book_app/app/routes/app_pages.dart';
import 'package:book_app/app/utils/constant/constant_color.dart';
import 'package:book_app/app/utils/constant/constant_image.dart';
import 'package:book_app/app/utils/functions.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BookWeekItem extends StatelessWidget {

  final BookWeek bookWeek;
  BookWeekItem(this.bookWeek) : assert(bookWeek != null);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () =>
          Get.toNamed(Routes.BOOK_DETAIL, arguments: Book(id: bookWeek.id)),
      child: Container(
        //color: index % 2 == 0 ? Colors.green : Colors.purple,
        margin: EdgeInsets.symmetric(horizontal: 25),
        child: Row(
          children: <Widget>[
            Container(
              height: 150,
              child: Hero(
                tag: bookWeek.id,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(5),
                  child: bookWeek.picture != null && bookWeek.picture != ""
                      ? CachedNetworkImage(
                          imageUrl: bookWeek.picture,
                          fit: BoxFit.cover,
                          useOldImageOnUrlChange: true,
                          placeholder: (context, url) =>
                              CustomCircularProgress(radius: 15),
                          errorWidget: (context, url, error) =>
                              Icon(Icons.error),
                        )
                      : Image.asset(ConstantImage.noBookCover, fit: BoxFit.cover,),
                ),
              ),
            ),
            SizedBox(width: 25),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          bookWeek.title,
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
                          "${bookWeek.author}  •  ${stringToDate(bookWeek.datePublished, 'yyyy').year}",
                          style: TextStyle(
                            fontFamily: 'SF Pro Text',
                            fontSize: 14,
                            color: ConstantColor.greyDark,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: DescriptionTextWidget(
                      text: bookWeek.bio,
                      showInPopup: true,
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
