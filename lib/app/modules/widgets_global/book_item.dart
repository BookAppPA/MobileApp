import 'package:book_app/app/data/model/book.dart';
import 'package:book_app/app/modules/widgets_global/custom_circular_progress.dart';
import 'package:book_app/app/routes/app_pages.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BookItem extends StatelessWidget {
  final double width, height;
  final bool showTitle, showAuthor, isAdd;
  final Book book;
  final VoidCallback onClickAdd;

  BookItem(
      {this.width: 110,
      this.height: 170,
      this.showTitle: false,
      this.showAuthor: false,
      this.isAdd: false,
      this.onClickAdd,
      @required this.book})
      : assert(book != null);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => !isAdd && book.title != null
          ? Get.toNamed(Routes.BOOK_DETAIL, arguments: book)
          : isAdd && onClickAdd != null ? onClickAdd() : null,
      child: Container(
        //color: Colors.yellow,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: width,
              height: height,
              child: Hero(
                tag: book.id ?? DateTime.now(),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(5),
                  child:
                      !isAdd && book.coverImage != null && book.coverImage != ""
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
                                  color: Colors.grey[400],
                                  borderRadius: BorderRadius.circular(5)),
                              child: !isAdd
                                  ? Container()
                                  : Center(
                                      child: Icon(
                                        Icons.add,
                                        color: Colors.white,
                                        size: 70,
                                      ),
                                    ),
                            ),
                ),
              ),
            ),
            !isAdd && showTitle && book.title != null
                ? _buildTitle()
                : Container(),
            !isAdd && showAuthor && book.authors != null
                ? _buildAuthor()
                : Container(),
          ],
        ),
      ),
    );
  }

  Widget _buildTitle() {
    return Container(
      width: width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(height: 15),
          Text(
            book.title,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontFamily: 'SF Rounded',
              fontSize: 15,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAuthor() {
    return Container(
      width: width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(height: 7),
          Text(
            book.authors[0],
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontFamily: 'SF Rounded',
              fontSize: 11,
              color: Color(0x80212121),
            ),
          ),
        ],
      ),
    );
  }
}
