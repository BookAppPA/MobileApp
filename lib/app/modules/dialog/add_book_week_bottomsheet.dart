import 'package:book_app/app/modules/widgets_global/button_arround.dart';
import 'package:book_app/app/modules/widgets_global/snackbar.dart';
import 'package:book_app/app/utils/constant/constant_color.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddBookWeekBottomSheet extends StatefulWidget {
  final VoidCallback onCancel;
  final Function(String) onConfirm;

  AddBookWeekBottomSheet({this.onCancel, @required this.onConfirm})
      : assert(onConfirm != null);

  @override
  _AddBookWeekBottomSheetState createState() => _AddBookWeekBottomSheetState();
}

class _AddBookWeekBottomSheetState extends State<AddBookWeekBottomSheet> {
  final TextEditingController _bioController = TextEditingController();
  int get nbBio => _bioController.text.length;

  @override
  void initState() {
    super.initState();
    _bioController.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 230,
      decoration: BoxDecoration(
        color: ConstantColor.greyWhite,
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20), topRight: Radius.circular(20)),
      ),
      child: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(top: 10),
            child: Text(
              "Ajouter ce Livre de la Semaine",
              style: TextStyle(fontSize: 17),
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(10, 20, 10, 0),
            child: CupertinoTextField(
              controller: _bioController,
              cursorColor: ConstantColor.black,
              maxLines: 5,
              minLines: 3,
              maxLength: 500,
              placeholder: "Ajouter une description",
              padding: EdgeInsets.all(10),
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(10, 5, 15, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Text(
                  "$nbBio/500",
                  style: TextStyle(
                    color: ConstantColor.greyDark,
                    fontWeight: FontWeight.w400,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
          Spacer(),
          Padding(
            padding: EdgeInsets.only(bottom: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Container(
                  height: 50,
                  width: 125,
                  child: OutlinedButton(
                    onPressed: () => widget.onCancel != null
                        ? widget.onCancel()
                        : Get.back(),
                    child: Text(
                      "Annuler",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: 'SF Pro Display',
                        fontSize: 17,
                        color: ConstantColor.grey,
                        letterSpacing: 0.0425,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    style: ButtonStyle(
                      overlayColor: MaterialStateProperty.resolveWith<Color>(
                          (states) => Colors.transparent),
                      shape: MaterialStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                    ),
                  ),
                ),
                ButtonArround(
                  onTap: () {
                    if (_bioController.text.trim().length >= 3) {
                      widget.onConfirm(_bioController.text.trim());
                      Get.back();
                    } else {
                      CustomSnackbar.notif(
                          "Votre description doit contenir au moins 3 caractères");
                    }
                  },
                  text: "Confirmer",
                  colorBackground: ConstantColor.grey,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
