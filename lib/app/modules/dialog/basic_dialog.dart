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

  static showConfirmFinishBookDialog({VoidCallback onConfirm}) {
    Get.defaultDialog(
      title: "Livre fini",
      content: Text(
          "Veux-tu ajouter ce livre à ta bibliothèque et y laisser un avis ?"),
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

  static showConfirmDeleteBookDialog({VoidCallback onConfirm}) {
    Get.defaultDialog(
      title: "Supprimer le livre",
      content: Text("Veux-tu supprimer définitivement ce livre et ton avis ?"),
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

  static showCompleteText(String text) {
    Get.dialog(
      Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(20.0),
          ),
        ),
        child: Container(
          height: 400,
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  IconButton(
                      icon: Icon(Icons.close), onPressed: () => Get.back())
                ],
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(10, 0, 10, 10),
                    child: Text(text),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
