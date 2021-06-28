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
        "Veux-tu ajouter ce livre à ta bibliothèque et y laisser un avis ?",
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
              Future.delayed(Duration(milliseconds: 300), () => onConfirm());
              Get.back();
            }
          : () => null,
    );
  }

  static showConfirmAddBookWithoutRating({@required VoidCallback onConfirm}) {
    assert(onConfirm != null);
    Get.defaultDialog(
      title: "Ajouter le livre sans avis",
      content: Text(
        "Confirmer l'ajout du livre à votre bibliothèque sans y laisser un avis ?",
        textAlign: TextAlign.center,
      ),
      textCancel: "Non",
      onCancel: () => null,
      textConfirm: "Oui",
      buttonColor: ConstantColor.accent,
      confirmTextColor: Colors.black,
      cancelTextColor: Colors.black,
      onConfirm: () {
        Future.delayed(Duration(milliseconds: 300), () => onConfirm());
        Navigator.of(Get.overlayContext).pop();
      },
    );
  }

  static showConfirmDeleteBookDialog({VoidCallback onConfirm}) {
    Get.defaultDialog(
      title: "Supprimer le livre",
      content: Text(
        "Veux-tu supprimer définitivement ce livre et ton avis ?",
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

  static showConfirmPictureDialog({VoidCallback onConfirm}) {
    Get.defaultDialog(
      title: "Ajouter une photo",
      content: Text(
        "Vous ne pourrez plus modifier votre photo après cette étape",
        textAlign: TextAlign.center,
      ),
      textCancel: "Annuler",
      onCancel: () => null,
      textConfirm: "Confirmer",
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
