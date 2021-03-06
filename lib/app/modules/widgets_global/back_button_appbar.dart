import 'package:book_app/app/utils/constant/constant_color.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BackButtonAppBar extends AppBar {
  final Color iconColor, appBarColor;
  final String textTitle;
  BackButtonAppBar(
      {this.appBarColor: ConstantColor.background,
      this.iconColor: ConstantColor.grey,
      this.textTitle: ""})
      : super(
          elevation: 0,
          backgroundColor: appBarColor,
          automaticallyImplyLeading: false,
          leading: Padding(
            padding: EdgeInsets.only(left: 10),
            child: IconButton(
              icon: Icon(
                Icons.arrow_back_ios,
                color: iconColor,
              ),
              onPressed: () {
                FocusScope.of(Get.context).unfocus();
                Get.back();
              },
            ),
          ),
          title: Text(textTitle),
        );
}
