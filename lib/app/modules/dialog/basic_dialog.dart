import 'package:book_app/app/translations/app_translations.dart';
import 'package:book_app/app/utils/constant/constant_color.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../routes/app_pages.dart';

abstract class BasicDialog {
  static showExitAppDialog() {
    Get.defaultDialog(
      title: AppTranslation.leave.tr,
      content: Text(AppTranslation.wantLeaveApp.tr),
      textCancel: AppTranslation.no.tr,
      onCancel: () => null,
      textConfirm: AppTranslation.yes.tr,
      buttonColor: ConstantColor.accent,
      confirmTextColor: Colors.black,
      cancelTextColor: Colors.black,
      onConfirm: () =>
          SystemChannels.platform.invokeMethod('SystemNavigator.pop'),
    );
  }

  static showLogoutDialog({VoidCallback onConfirm}) {
    Get.defaultDialog(
      title: AppTranslation.logout.tr,
      content: Text(
        AppTranslation.logoutQuestion.tr,
        textAlign: TextAlign.center,
      ),
      textCancel: AppTranslation.no.tr,
      onCancel: () => null,
      textConfirm: AppTranslation.yes.tr,
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

  static showLanguageDialog() {
    Get.dialog(Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(20),
        ),
      ),
      child: Container(
        height: 175,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          children: <Widget>[
            ListTile(
              title: Text(AppTranslation.french.tr),
              trailing: Icon(Icons.chevron_right_outlined),
              onTap: () {
                Get.updateLocale(Locale("fr", "FR"));
                Get.offAllNamed(Routes.SQUELETON);
              },
            ),
            ListTile(
              title: Text(AppTranslation.english.tr),
              trailing: Icon(Icons.chevron_right_outlined),
              onTap: () {
                Get.updateLocale(Locale("en", "US"));
                Get.offAllNamed(Routes.SQUELETON);
              },
            ),
            ListTile(
              title: Text(AppTranslation.spanish.tr),
              trailing: Icon(Icons.chevron_right_outlined),
              onTap: () {
                Get.updateLocale(Locale("es", "ES"));
                Get.offAllNamed(Routes.SQUELETON);
              },
            ),
          ],
        ),
      ),
    ));
  }

  static showConfirmFinishBookDialog({VoidCallback onConfirm}) {
    Get.defaultDialog(
      title: AppTranslation.finishBook.tr,
      content: Text(
        AppTranslation.addBookToGalleryQuestion.tr,
        textAlign: TextAlign.center,
      ),
      textCancel: AppTranslation.no.tr,
      onCancel: () => null,
      textConfirm: AppTranslation.yes.tr,
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
      title: AppTranslation.addingBookWithoutReview.tr,
      content: Text(
        AppTranslation.confirmAddingBookToLibraryWithoutReview.tr,
        textAlign: TextAlign.center,
      ),
      textCancel: AppTranslation.no.tr,
      onCancel: () => null,
      textConfirm: AppTranslation.yes.tr,
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
      title: AppTranslation.deleteBook.tr,
      content: Text(
       AppTranslation.deleteBookFromGalleryQuestion.tr,
        textAlign: TextAlign.center,
      ),
      textCancel: AppTranslation.no.tr,
      onCancel: () => null,
      textConfirm: AppTranslation.yes.tr,
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
      title: AppTranslation.addPicture.tr,
      content: Text(
        AppTranslation.noNewEditPicture.tr,
        textAlign: TextAlign.center,
      ),
      textCancel: AppTranslation.cancel.tr,
      onCancel: () => null,
      textConfirm: AppTranslation.confirm.tr,
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
