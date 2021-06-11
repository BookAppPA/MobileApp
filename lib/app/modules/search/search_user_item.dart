import 'package:book_app/app/data/model/user.dart';
import 'package:book_app/app/modules/widgets_global/snackbar.dart';
import 'package:book_app/app/routes/app_pages.dart';
import 'package:book_app/app/utils/constant/constant_color.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class SearchUserItem extends StatelessWidget {
  final UserModel user;
  final VoidCallback onFollow, onUnFollow;
  SearchUserItem(this.user,
      {@required this.onFollow, @required this.onUnFollow})
      : assert(user != null),
        assert(onFollow != null),
        assert(onUnFollow != null);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => user.id != null
          ? user.isBlocked ? CustomSnackbar.snackbar("Ce profil à été bloqué") : Get.toNamed(Routes.PROFIL, arguments: user)
          : null,
      child: Container(
        width: Get.width,
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: ConstantColor.greyWhite,
          borderRadius: BorderRadius.circular(5)
        ),
        child: Row(
          children: <Widget>[
            CircleAvatar(
              radius: 32,
              backgroundColor: Colors.white,
              child: CircleAvatar(
                radius: 30,
                backgroundImage: user.picture == null || user.picture == ""
                    ? AssetImage('assets/defaut_user.jpeg')
                    : NetworkImage(user.picture),
              ),
            ),
            SizedBox(width: 25),
            Expanded(
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
                      Text(
                        "${user.nbFollowers}",
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontFamily: 'SF Pro Text',
                          fontSize: 17,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                      "${user.nbBooks} Livres  •  ${user.nbRatings} Avis",
                      style: TextStyle(
                        fontFamily: 'SF Pro Text',
                        fontSize: 14,
                        color: ConstantColor.greyDark,
                      ),
                    ),
                      GestureDetector(
                        child: Icon(FontAwesomeIcons.userPlus, size: 20),
                        onTap: () => onFollow(),
                      ),
                    ],
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
