import 'package:book_app/app/utils/constant/constant_color.dart';
import 'package:book_app/app/utils/constant/constant_image.dart';
import 'package:flutter/material.dart';

class ThemeItem extends StatefulWidget {
  final VoidCallback onSelected, onUnSelected;
  final bool selected;
  final String categoryTitle;
  final String imageCategory;

  ThemeItem(
      {@required this.onSelected,
      @required this.onUnSelected,
      @required this.categoryTitle,
      @required this.imageCategory,
      this.selected: false})
      : assert(onSelected != null),
        assert(onUnSelected != null),
        assert(categoryTitle != null),
        assert(imageCategory != null);

  @override
  _ThemeItemState createState() => _ThemeItemState(selected: selected);
}

class _ThemeItemState extends State<ThemeItem> {
  bool selected = false;
  _ThemeItemState({this.selected});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _clickItem(),
      child: Container(
        // color: Colors.red,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Container(
                width: 100.0,
                // backgroundImage: AssetImage(widget.imageCategory),
                decoration: BoxDecoration(
                    // borderRadius: BorderRadius.circular(35.0),
                    border: Border.all(color: selected ? ConstantColor.accent : Colors.transparent, width: 3),
                    shape: BoxShape.circle,
                    image: DecorationImage(
                        image: AssetImage(widget.imageCategory))),
              ),
            ),
            Text(widget.categoryTitle)
          ],
        ),
      ),
    );
  }

  _clickItem() {
    setState(() {
      selected = !selected;
      selected ? widget.onSelected() : widget.onUnSelected();
    });
  }
}
