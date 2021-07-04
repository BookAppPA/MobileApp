import 'package:book_app/app/modules/dialog/basic_dialog.dart';
import 'package:book_app/app/modules/widgets_global/back_button_appbar.dart';
import 'package:book_app/app/translations/app_translations.dart';
import 'package:book_app/app/utils/constant/constant_color.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:settings_ui/settings_ui.dart';
import 'package:flutter/material.dart';
import 'settings_controller.dart';

class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BackButtonAppBar(textTitle: AppTranslation.settings.tr),
      body: SettingsList(
        backgroundColor: ConstantColor.background,
        sections: [
          SettingsSection(
            tiles: [
              SettingsTile(
                title: AppTranslation.language.tr,
                subtitle: AppTranslation.french.tr,
                leading: Icon(Icons.language),
                onPressed: (ctx) => BasicDialog.showLanguageDialog(),
              ),
              SettingsTile(
                title: AppTranslation.contact.tr,
                leading: Icon(Icons.mail_outline),
                trailing: Padding(
                  padding: EdgeInsets.only(right: 10),
                  child: Text("contact@bookapp.fr"),
                ),
              ),
              SettingsTile(
                title: AppTranslation.version.tr,
                leading: Icon(
                  GetPlatform.isAndroid
                      ? FontAwesomeIcons.android
                      : FontAwesomeIcons.apple,
                ),
                trailing: GetBuilder<SettingsController>(
                  init: SettingsController(),
                  builder: (_) => Padding(
                    padding: EdgeInsets.only(right: 15),
                    child: Text(_.version),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
