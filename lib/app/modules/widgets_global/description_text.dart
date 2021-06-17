import 'package:book_app/app/modules/dialog/basic_dialog.dart';
import 'package:flutter/material.dart';

class DescriptionTextWidget extends StatefulWidget {
  final String text;
  final bool showInPopup;
  final TextStyle style;
  final int maxLength;

  DescriptionTextWidget(
      {@required this.text, this.showInPopup: false, this.style, this.maxLength: 150});

  @override
  _DescriptionTextWidgetState createState() => _DescriptionTextWidgetState();
}

class _DescriptionTextWidgetState extends State<DescriptionTextWidget> {
  String firstHalf;
  String secondHalf;

  bool flag = true;

  @override
  void initState() {
    super.initState();

    if (widget.text.length > widget.maxLength) {
      firstHalf = widget.text.substring(0, widget.maxLength);
      secondHalf = widget.text.substring(widget.maxLength, widget.text.length);
    } else {
      firstHalf = widget.text;
      secondHalf = "";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: secondHalf.isEmpty
          ? Text(firstHalf, style: widget.style != null ? widget.style : null)
          : Column(
              children: <Widget>[
                Text(flag ? (firstHalf + "...") : (firstHalf + secondHalf),
                    style: widget.style != null ? widget.style : null),
                InkWell(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Text(
                        flag ? "plus" : "moins",
                        style: TextStyle(color: Colors.blue),
                      ),
                    ],
                  ),
                  onTap: () {
                    if (widget.showInPopup)
                      BasicDialog.showCompleteText(widget.text);
                    else {
                      setState(() {
                        flag = !flag;
                      });
                    }
                  },
                ),
              ],
            ),
    );
  }
}
