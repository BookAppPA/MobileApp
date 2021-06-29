import 'package:book_app/app/modules/widgets_global/button_arround.dart';
import 'package:book_app/app/utils/constant/constant_color.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';

class AddRatingBottomSheet extends StatefulWidget {
  final String title;
  final VoidCallback onCancel;
  final Function(String, String, double) onConfirm;

  AddRatingBottomSheet(
      {@required this.title, @required this.onCancel, @required this.onConfirm})
      : assert(title != null),
        assert(onConfirm != null),
        assert(onCancel != null);

  @override
  _AddRatingBottomSheetState createState() => _AddRatingBottomSheetState();
}

class _AddRatingBottomSheetState extends State<AddRatingBottomSheet> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _messageController = TextEditingController();
  int get nbMessage => _messageController.text.length;
  double note = 0.0;
  double noteFinal;
  String noteText = "0";

  @override
  void initState() {
    super.initState();
    _messageController.addListener(() {
      setState(() {});
    });
  }

  String removeDecimalZeroFormat(double n) {
    return n.toStringAsFixed(n.truncateToDouble() == n ? 0 : 1);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        widget.onCancel();
        return true;
      },
      child: SingleChildScrollView(
        child: Container(
          height: 350,
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
                  widget.title,
                  style: TextStyle(fontSize: 17),
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(10, 20, 10, 0),
                child: CupertinoTextField(
                  controller: _titleController,
                  cursorColor: ConstantColor.black,
                  maxLines: 1,
                  maxLength: 50,
                  placeholder: "Ajouter un titre",
                  padding: EdgeInsets.all(10),
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                child: CupertinoTextField(
                  controller: _messageController,
                  cursorColor: ConstantColor.black,
                  maxLines: 5,
                  minLines: 5,
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
                      "$nbMessage/300",
                      style: TextStyle(
                        color: ConstantColor.greyDark,
                        fontWeight: FontWeight.w400,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  RatingBar.builder(
                    initialRating: 0.0,
                    minRating: 0,
                    direction: Axis.horizontal,
                    itemCount: 5,
                    itemSize: 25,
                    allowHalfRating: true,
                    itemBuilder: (context, _) => Icon(
                      Icons.star,
                      color: Colors.amber,
                    ),
                    onRatingUpdate: (value) {
                      setState(() {
                        noteText = removeDecimalZeroFormat(value);
                        note = value;
                        noteFinal = note;
                      });
                    },
                  ),
                  SizedBox(width: 10),
                  Text("$noteText/5"),
                ],
              ),
              Spacer(),
              Padding(
                padding: EdgeInsets.only(bottom: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Container(
                      height: 50,
                      width: 150,
                      child: OutlinedButton(
                        onPressed: () => widget.onCancel(),
                        child: Text(
                          "Ne pas envoyer",
                          style: TextStyle(
                            fontFamily: 'SF Pro Display',
                            fontSize: 16,
                            color: ConstantColor.grey,
                            letterSpacing: 0.0425,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        style: ButtonStyle(
                          overlayColor:
                              MaterialStateProperty.resolveWith<Color>(
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
                        widget.onConfirm(
                            _titleController.text.trim() != ""
                                ? _titleController.text.trim()
                                : null,
                            _messageController.text.trim() != ""
                                ? _messageController.text.trim()
                                : null,
                            noteFinal);
                        Get.back();
                      },
                      text: "Ajouter",
                      colorBackground: ConstantColor.grey,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
