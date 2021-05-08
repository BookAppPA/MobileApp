import 'package:book_app/app/data/model/book.dart';
import 'package:book_app/app/modules/widgets_global/book_item.dart';
import 'package:book_app/app/utils/constant/constant_color.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width,
      height: Get.height,
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(15),
          child: Column(
            children: <Widget>[
              _buildHeader(),
              _buildMostPopularBooks(),
              _buildBooksWant(),
              SizedBox(height: 25),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      height: 200,
      color: Colors.blue,
    );
  }

  Widget _buildMostPopularBooks() {
    List<Widget> _books = List.generate(
      3,
      (index) =>
          Expanded(child: BookItem(book: Book(title: "THE FIRM", authors: [""]))),
    );
    List<Widget> _books2 = List.generate(
      3,
      (index) =>
          Expanded(child: BookItem(book: Book(title: "Fatherhood", authors: [""]))),
    );
    return Container(
      height: 430,
      //color: Colors.yellow,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            "Les Plus Populaires",
            style: TextStyle(
              fontFamily: 'SF Rounded',
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 20),
          Expanded(
            child: Container(
                //color: Colors.red,
                child: Column(
              children: <Widget>[
                Row(
                  children: _books,
                ),
                SizedBox(height: 20),
                Row(
                  children: _books2,
                ),
              ],
            )),
          ),
        ],
      ),
    );
  }

  Widget _buildBooksWant() {
    return Container(
      height: 325,
      // color: Colors.red,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            "Risque De Vous Plaire",
            style: TextStyle(
              fontFamily: 'SF Rounded',
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 20),
          Expanded(
            child: ListView.separated(
              itemCount: 6,
              separatorBuilder: (ctx, index) {
                return SizedBox(width: 25);
              },
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return BookItem(
                  book: Book(
                      title: "Fatherhood", authors: ["Christopher Wilson"]),
                  showAuthor: true,
                  showTitle: true,
                  width: 125,
                  height: 200,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
