import 'package:book_app/app/data/model/book.dart';
import 'package:flutter/material.dart';

class BookItem extends StatelessWidget {
  final double width, height;
  final bool showTitle, showAuthor;
  final Book book;

  BookItem(
      {this.width: 100,
      this.height: 170,
      this.showTitle: false,
      this.showAuthor: false,
      @required this.book})
      : assert(book != null);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.yellow,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: width,
            height: height,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: Colors.grey,
            ),
          ),
          showTitle ? _buildTitle() : Container(),
          showAuthor ? _buildAuthor() : Container(),
        ],
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
            book.author,
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
