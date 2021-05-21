import 'package:book_app/app/utils/constant/constant_color.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

abstract class BasicDialog {
  static showExitAppDialog() {
    Get.defaultDialog(
      title: "Quitter",
      content: Text("Veux-tu quitter l'application ?"),
      textCancel: "Non",
      onCancel: () => null,
      textConfirm: "Oui",
      buttonColor: ConstantColor.accent,
      confirmTextColor: Colors.black,
      cancelTextColor: Colors.black,
      onConfirm: () =>
          SystemChannels.platform.invokeMethod('SystemNavigator.pop'),
    );
  }

  static showLogoutDialog({VoidCallback onConfirm}) {
    Get.defaultDialog(
      title: "Déconnexion",
      content: Text(
        "Veux-tu te déconnecter\nde ton compte ?",
        textAlign: TextAlign.center,
      ),
      textCancel: "Non",
      onCancel: () => null,
      textConfirm: "Oui",
      buttonColor: ConstantColor.accent,
      confirmTextColor: Colors.black,
      cancelTextColor: Colors.black,
      onConfirm: onConfirm != null
          ? () {
              onConfirm();
              Get.back();
            }
          : () => null,
    );
  }
}
