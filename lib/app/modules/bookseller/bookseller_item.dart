import 'package:book_app/app/data/model/bookseller.dart';
import 'package:book_app/app/modules/profil/user_controller.dart';
import 'package:book_app/app/routes/app_pages.dart';
import 'package:book_app/app/utils/constant/constant_color.dart';
import 'package:book_app/app/utils/functions.dart';
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
    var address = splitAddress(bookSeller.address);
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
                        UserController.to.isBookSeller
                            ? Container()
                            : GetBuilder<UserController>(
                                  builder: (_) {
                                    bool isFollow = _.user.listFollowing
                                            .firstWhere(
                                                (item) => item.id == bookSeller.id,
                                                orElse: () => null) !=
                                        null;
                                    return GestureDetector(
                                      child: Icon(
                                          isFollow
                                              ? FontAwesomeIcons.solidBookmark
                                              : FontAwesomeIcons.bookmark,
                                          size: 20),
                                      onTap: () =>
                                          isFollow ? onUnFollow() : onFollow(),
                                    );
                                  },
                                )
                      ],
                    ),
                    SizedBox(height: 10),
                    Text(
                      "$address",
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
