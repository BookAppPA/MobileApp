import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomSnackbar {
  static snackbar(String text, {bool shortDuration: false, int seconds: 0}) {
    Get.snackbar(
      "text",
      "",
      snackPosition: SnackPosition.BOTTOM,
      colorText: Colors.white,
      duration: Duration(seconds: seconds <= 0 ? shortDuration ? 1 : 2 : seconds),
      backgroundColor: Colors.black87,
      isDismissible: true,
      dismissDirection: SnackDismissDirection.HORIZONTAL,
      titleText: Text(
        text,
        style: TextStyle(
          color: Colors.white,
          fontSize: 18,
          fontWeight: FontWeight.w600,
        ),
      ),
      messageText: Container(),
    );
  }

  static notif(String text, {bool fixed: false}) {
    Get.snackbar(
      "text",
      "",
      snackPosition: SnackPosition.TOP,
      colorText: Colors.black87,
      duration: fixed ? Duration(hours: 2) : Duration(seconds: 2),
      backgroundColor: Colors.white,
      isDismissible: true,
      dismissDirection: SnackDismissDirection.HORIZONTAL,
      titleText: Container(),
      messageText: Text(
        text,
        style: TextStyle(
          color: Colors.black87,
          fontSize: 18,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
