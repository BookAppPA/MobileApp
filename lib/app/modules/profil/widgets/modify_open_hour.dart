import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'bottomsheet_modify_hours.dart';

class ModifyOpenHour extends StatefulWidget {
  final String day, dayHours;
  final Function(String) onModify;

  ModifyOpenHour(
      {@required this.day,
      this.dayHours: "Pas d'horaires spécifiés",
      @required this.onModify})
      : assert(day != null),
        assert(onModify != null);

  @override
  _ModifyOpenHourState createState() => _ModifyOpenHourState();
}

class _ModifyOpenHourState extends State<ModifyOpenHour> {
  String dayHours = "";

  @override
  void initState() {
    super.initState();
    dayHours = widget.dayHours;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.bottomSheet(BottomSheetModifyHours(
          day: widget.day,
          onConfirm: (newHours) {
            setState(() {
              dayHours = newHours;
            });
            widget.onModify(newHours);
          },
        ));
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(child: Text("${widget.day}: ")),
          Expanded(flex: 2, child: Text(dayHours)),
          Expanded(child: Icon(Icons.edit)),
        ],
      ),
    );
  }
}
