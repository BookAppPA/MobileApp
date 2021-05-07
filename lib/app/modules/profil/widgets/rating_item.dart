import 'package:book_app/app/data/model/rating.dart';
import 'package:book_app/app/utils/constant/constant_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class RatingItem extends StatelessWidget {
  final Rating rating;
  RatingItem(this.rating) : assert(rating != null);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 125,
      decoration: BoxDecoration(
        color: ConstantColor.accent,
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
                Padding(
                  padding: EdgeInsets.only(right: 20, top: 10),
                  child: Text(
                    'A must read for everybody. This book taught me so many things about dzedzed dzedz ze dz d f rfefrer erferf ',
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
          ),
          Container(
            width: 65,
            color: Colors.grey,
          )
        ],
      ),
    );
  }
}
