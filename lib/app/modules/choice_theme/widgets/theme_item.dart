import 'package:flutter/material.dart';

class ThemeItem extends StatefulWidget {

  final VoidCallback onSelected, onUnSelected;
  final bool selected;

  ThemeItem(
      {@required this.onSelected,
      @required this.onUnSelected,
      this.selected: false})
      : assert(onSelected != null),
        assert(onUnSelected != null);

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
      child: CircleAvatar(
        backgroundColor: selected ? Colors.green : Colors.grey,
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