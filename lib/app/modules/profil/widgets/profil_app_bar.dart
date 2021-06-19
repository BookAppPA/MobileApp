import 'package:book_app/app/modules/dialog/basic_dialog.dart';
import 'package:book_app/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import '../profil_controller.dart';

class ProfilAppBar extends StatelessWidget {
  final bool isMe, back, isBookSeller;
  final String title;
  ProfilAppBar(
      {this.isMe: false,
      this.title: "",
      this.back: true,
      this.isBookSeller: false});

  @override
  Widget build(BuildContext context) {
    return isMe
        ? Container(
            padding: EdgeInsets.only(top: 25, right: 15, left: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                back
                    ? IconButton(
                        icon: Icon(
                          Icons.arrow_back_ios,
                          color: Color(0xbf212121),
                        ),
                        onPressed: () {
                          FocusScope.of(Get.context).unfocus();
                          Get.back();
                        },
                      )
                    : IconButton(
                        icon: Icon(
                          Icons.settings,
                          size: 30,
                          color: Color(0xbf212121),
                        ),
                        onPressed: () {
                          FocusScope.of(Get.context).unfocus();
                          Get.toNamed(Routes.SETTINGS);
                        },
                      ),
                Expanded(
                  child: Text(
                    title,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.headline6,
                  ),
                ),
                back
                    ? Row(
                        children: <Widget>[
                          IconButton(
                            icon: Icon(
                              Icons.settings,
                              size: 30,
                              color: Color(0xbf212121),
                            ),
                            onPressed: () {
                              FocusScope.of(Get.context).unfocus();
                              Get.toNamed(Routes.SETTINGS);
                            },
                          ),
                          IconButton(
                            icon: Icon(
                              FontAwesomeIcons.powerOff,
                              color: Color(0xbf212121),
                            ),
                            onPressed: () => BasicDialog.showLogoutDialog(
                                onConfirm: () =>
                                    ProfilController.to.clickLogout()),
                          ),
                        ],
                      )
                    : IconButton(
                        icon: Icon(
                          FontAwesomeIcons.powerOff,
                          color: Color(0xbf212121),
                        ),
                        onPressed: () => BasicDialog.showLogoutDialog(
                            onConfirm: () => ProfilController.to.clickLogout()),
                      ),
              ],
            ),
          )
        : Container(
            padding: EdgeInsets.only(top: 25, right: 15, left: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                IconButton(
                  icon: Icon(
                    Icons.arrow_back_ios,
                    color: back ? Color(0xbf212121) : Colors.transparent,
                  ),
                  onPressed: () {
                    if (back) {
                      FocusScope.of(Get.context).unfocus();
                      Get.back();
                    }
                  },
                ),
                Expanded(
                  child: Text(
                    title,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.headline6,
                  ),
                ),
                IconButton(
                  icon: Icon(
                    Icons.settings,
                    size: 30,
                    color:
                        isBookSeller ? Colors.transparent : Color(0xbf212121),
                  ),
                  onPressed: () {
                    if (!isBookSeller) {
                      FocusScope.of(Get.context).unfocus();
                      Get.toNamed(Routes.SETTINGS);
                    }
                  },
                ),
              ],
            ),
          );
  }
}
