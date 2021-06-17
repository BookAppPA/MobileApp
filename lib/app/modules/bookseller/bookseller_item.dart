import 'package:book_app/app/data/model/bookseller.dart';
import 'package:book_app/app/routes/app_pages.dart';
import 'package:book_app/app/utils/constant/constant_color.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class SearchBookSellerItem extends StatelessWidget {
  final BookSeller bookSeller;
  final VoidCallback onFollow, onUnFollow;
  SearchBookSellerItem(this.bookSeller,
      {@required this.onFollow, @required this.onUnFollow})
      : assert(bookSeller != null),
        assert(onFollow != null),
        assert(onUnFollow != null);

  @override
  Widget build(BuildContext context) {
    /* var haveAlreadyBook = UserController.to.user.listBooksRead
            .firstWhere((item) => item.id == book.id, orElse: () => null) !=
        null;*/

    var address = bookSeller.address.split(",");
    address[1] = address[1].substring(1);

    return GestureDetector(
      onTap: () => Get.toNamed(Routes.BOOKSELLER_DETAIL, arguments: bookSeller),
      child: Container(
        width: Get.width,
        padding: EdgeInsets.all(15),
        decoration: BoxDecoration(
            color: ConstantColor.greyWhite,
            borderRadius: BorderRadius.circular(5)),
        child: IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Expanded(
                          child: Text(
                            bookSeller.name,
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
                        ),
                        GestureDetector(
                          child: Icon(FontAwesomeIcons.bookmark, size: 20),
                          onTap: () => onFollow(),
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    Text(
                      "${address.first}\n${address[1]}",
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
      ),
    );
  }
}
