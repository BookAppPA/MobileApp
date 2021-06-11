import 'package:book_app/app/data/model/book.dart';
import 'package:book_app/app/modules/profil/user_controller.dart';
import 'package:book_app/app/modules/widgets_global/custom_circular_progress.dart';
import 'package:book_app/app/routes/app_pages.dart';
import 'package:book_app/app/utils/constant/constant_color.dart';
import 'package:book_app/app/utils/functions.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class SearchBookItem extends StatelessWidget {
  final Book book;
  final VoidCallback onAdd, onDelete;
  SearchBookItem(this.book, {@required this.onAdd, @required this.onDelete})
      : assert(book != null),
        assert(onAdd != null),
        assert(onDelete != null);

  @override
  Widget build(BuildContext context) {
    var haveAlreadyBook = UserController.to.user.listBooksRead
            .firstWhere((item) => item.id == book.id, orElse: () => null) !=
        null;

    return GestureDetector(
      onTap: () => book.id != null
          ? Get.toNamed(Routes.BOOK_DETAIL, arguments: book)
          : null,
      child: Container(
        width: Get.width,
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
            color: ConstantColor.greyWhite,
            borderRadius: BorderRadius.circular(5)),
        child: IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
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
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        GestureDetector(
                          child: Icon(haveAlreadyBook
                              ? FontAwesomeIcons.solidBookmark
                              : FontAwesomeIcons.bookmark),
                          onTap: () => haveAlreadyBook ? onDelete() : onAdd(),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
