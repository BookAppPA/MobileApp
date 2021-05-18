import 'package:flutter/material.dart';

class MyTextfield extends StatefulWidget {
  final TextEditingController controller;
  final BorderRadius cornerRadius;
  final double width, height, wordSpacing, fontSize;
  final Color backgroundColor,
      borderColor,
      accentColor,
      textColor,
      prefixIconColor;
  final String placeholder, fontFamily;
  final Icon prefixIcon, suffixIcon;
  final TextInputType inputType;
  final EdgeInsets margin;
  final Duration duration;
  final VoidCallback onClickSuffix;
  final TextBaseline textBaseline;
  final FontStyle fontStyle;
  final FontWeight fontWeight;
  final bool autofocus, autocorrect, enabled, obscureText, isShadow;
  final FocusNode focusNode;
  final int maxLength, minLines, maxLines;
  final ValueChanged<String> onChanged, onSubmitted;
  final GestureTapCallback onTap;
  final TextInputAction inputAction;

  const MyTextfield(
      {@required this.width,
      @required this.height,
      @required this.prefixIcon,
      @required this.inputType,
      this.controller,
      this.suffixIcon,
      this.duration = const Duration(milliseconds: 500),
      this.margin = const EdgeInsets.all(10),
      this.obscureText = false,
      this.backgroundColor = const Color(0xff111823),
      this.borderColor = Colors.grey,
      this.prefixIconColor = const Color(0x993C3C43),
      this.cornerRadius = const BorderRadius.all(Radius.circular(10)),
      this.textColor = const Color(0xff5c5bb0),
      this.accentColor = Colors.white,
      this.placeholder = "Placeholder",
      this.isShadow = false,
      this.onClickSuffix,
      this.wordSpacing,
      this.textBaseline,
      this.fontFamily,
      this.fontStyle,
      this.fontWeight,
      this.fontSize,
      this.autofocus = false,
      this.autocorrect = false,
      this.focusNode,
      this.enabled = true,
      this.maxLength,
      this.maxLines,
      this.minLines,
      this.onChanged,
      this.onTap,
      this.onSubmitted,
      this.inputAction = TextInputAction.done})
      : assert(width != null),
        assert(height != null),
        assert(prefixIcon != null),
        assert(inputType != null);

  @override
  _MyTextfieldState createState() => _MyTextfieldState();
}

class _MyTextfieldState extends State<MyTextfield> {
  bool clickSuffix = false;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      width: widget.width,
      height: widget.height,
      margin: widget.margin,
      alignment: Alignment.centerRight,
      decoration: BoxDecoration(
          boxShadow: widget.isShadow
              ? [BoxShadow(color: Colors.grey, blurRadius: 2, spreadRadius: 1)]
              : [BoxShadow(spreadRadius: 0, blurRadius: 0)],
          borderRadius: widget.cornerRadius,
          color: widget.backgroundColor,
          border: Border.all(color: widget.borderColor)),
      child: Stack(
        children: <Widget>[
          widget.suffixIcon == null
              ? Container()
              : Align(
                  alignment: Alignment.centerRight,
                  child: AnimatedContainer(
                    width: clickSuffix ? 500 : 40,
                    height: clickSuffix ? widget.height : 40,
                    margin: EdgeInsets.only(right: clickSuffix ? 0 : 8),
                    duration: widget.duration,
                    decoration: BoxDecoration(
                        borderRadius: clickSuffix
                            ? widget.cornerRadius
                            : BorderRadius.all(Radius.circular(60)),
                        color: widget.accentColor),
                  ),
                ),
          widget.suffixIcon == null
              ? Container()
              : GestureDetector(
                  onTap: () {
                    setState(() {
                      clickSuffix ? clickSuffix = false : clickSuffix = true;
                      if (widget.onClickSuffix != null) {
                        widget.onClickSuffix();
                      }
                    });
                  },
                  child: Container(
                    margin: EdgeInsets.only(right: 17),
                    alignment: Alignment.centerRight,
                    child: Icon(
                      widget.suffixIcon.icon,
                      color: Color(0x993C3C43),
                      size: 22,
                    ),
                  ),
                ),
          Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Expanded(
                  flex: 1,
                  child: Icon(
                    widget.prefixIcon.icon,
                    color: widget.prefixIconColor,
                    size: widget.prefixIcon.size,
                  ),
                ),
                Expanded(
                  flex: 5,
                  child: Container(
                    margin: EdgeInsets.only(right: 50, top: 3),
                    child: TextField(
                      controller: widget.controller,
                      cursorWidth: 2,
                      obscureText: clickSuffix ? false : widget.obscureText,
                      keyboardType: widget.inputType,
                      style: TextStyle(
                        fontFamily: widget.fontFamily,
                        fontStyle: widget.fontStyle,
                        fontWeight: widget.fontWeight,
                        wordSpacing: widget.wordSpacing,
                        textBaseline: widget.textBaseline,
                        fontSize: widget.fontSize,
                        color: widget.textColor,
                      ),
                      autofocus: widget.autofocus,
                      autocorrect: widget.autocorrect,
                      focusNode: widget.focusNode,
                      enabled: widget.enabled,
                      maxLength: widget.maxLength,
                      maxLines: widget.maxLines,
                      minLines: widget.minLines,
                      onChanged: widget.onChanged,
                      onTap: () {
                        if (widget.onTap != null) {
                          widget.onTap();
                        }
                      },
                      onSubmitted: (t) {
                        setState(() {
                          clickSuffix = false;
                        });
                        widget.onSubmitted(t);
                      },
                      textInputAction: widget.inputAction,
                      decoration: InputDecoration(
                          hintStyle: TextStyle(color: widget.textColor),
                          hintText: widget.placeholder,
                          border: InputBorder.none),
                      cursorColor: widget.textColor,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      duration: widget.duration,
    );
  }
}
