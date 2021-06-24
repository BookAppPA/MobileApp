import 'package:book_app/app/data/model/bookseller.dart';
import 'package:book_app/app/data/model/following.dart';
import 'package:book_app/app/data/model/user.dart';
import 'package:book_app/app/modules/widgets_global/snackbar.dart';
import 'package:book_app/app/routes/app_pages.dart';
import 'package:book_app/app/utils/constant/constant_color.dart';
import 'package:book_app/app/utils/functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FollowerItem extends StatelessWidget {
  final Following user;
  FollowerItem(this.user) : assert(user != null);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => user.id != null
          ? user.isBlocked
              ? CustomSnackbar.snackbar("Ce profil à été bloqué")
              : user.isBookSeller
                  ? Get.toNamed(Routes.BOOKSELLER_DETAIL,
                      arguments: BookSeller(id: user.id))
                  : Get.toNamed(Routes.PROFIL,
                      arguments: UserModel(id: user.id))
          : null,
      child: Container(
        width: Get.width,
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
            color: ConstantColor.greyWhite,
            borderRadius: BorderRadius.circular(5)),
        child: Row(
          children: <Widget>[
            user.isBookSeller
                ? Container()
                : CircleAvatar(
                    radius: 32,
                    backgroundColor: Colors.white,
                    child: CircleAvatar(
                      radius: 30,
                      backgroundImage:
                          user.picture == null || user.picture == ""
                              ? AssetImage('assets/defaut_user.jpeg')
                              : NetworkImage(user.picture),
                    ),
                  ),
            SizedBox(width: user.isBookSeller ? 10 : 25),
            user.isBookSeller
                ? Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Expanded(
                              child: Text(
                                user.pseudo,
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
                            SizedBox(width: 10),
                          ],
                        ),
                        SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            user.isBookSeller
                                ? Text(
                                    splitAddress(user.address),
                                    style: TextStyle(
                                      fontFamily: 'SF Pro Text',
                                      fontSize: 14,
                                      color: ConstantColor.greyDark,
                                    ),
                                  )
                                : Container(),
                          ],
                        )
                      ],
                    ),
                  )
                : Expanded(
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: Text(
                            user.pseudo,
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
                        SizedBox(width: 10),
                      ],
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
