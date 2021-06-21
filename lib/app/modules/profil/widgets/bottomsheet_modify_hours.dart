import 'package:book_app/app/modules/widgets_global/button_arround.dart';
import 'package:book_app/app/utils/constant/constant_color.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BottomSheetModifyHours extends StatefulWidget {
  final VoidCallback onCancel;
  final Function(String) onConfirm;
  final String day, hours;

  BottomSheetModifyHours(
      {@required this.day,
      this.hours: "",
      this.onCancel,
      @required this.onConfirm})
      : assert(day != null),
        assert(onConfirm != null);

  @override
  _BottomSheetModifyHoursState createState() => _BottomSheetModifyHoursState();
}

class _BottomSheetModifyHoursState extends State<BottomSheetModifyHours> {
  bool isClosed = false;
  bool openAllDay = false;
  String hours = "";
  String tempHour = "";
  TimeOfDay selectedTime = TimeOfDay(hour: 00, minute: 00);
  List<String> hoursAllDaySelected = List.generate(2, (index) => "00:00");
  List<String> hoursDaySelected = List.generate(4, (index) => "00:00");

  @override
  void initState() {
    super.initState();
    isClosed = false;
    openAllDay = false;
    tempHour = "";
    hours = widget.hours;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 255,
      decoration: BoxDecoration(
        color: ConstantColor.greyWhite,
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30), topRight: Radius.circular(30)),
      ),
      child: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(top: 10),
            child: Text("Horaires d'ouverture de ${widget.day}", style: TextStyle(
              fontSize: 17
            ),),
          ),
          isClosed ? Container() :
          Row(
            children: [
              GestureDetector(
                onTap: () => setState(() {
                  openAllDay = !openAllDay;
                }),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Checkbox(
                      value: openAllDay,
                      onChanged: (value) => setState(() {
                        openAllDay = value;
                      }),
                    ),
                    SizedBox(width: 10),
                    Text("Ouvert toute la journée ?"),
                  ],
                ),
              ),
            ],
          ),
          isClosed ? Container() :
          Row(
            mainAxisAlignment: openAllDay
                ? MainAxisAlignment.center
                : MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Expanded(
                child: Column(
                  children: <Widget>[
                    Text(
                      "Matin",
                      style: TextStyle(fontSize: 17),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: List.generate(
                          openAllDay ? 1 : 2,
                          (index) => GestureDetector(
                                onTap: () => _showTimePicker(index),
                                child: Row(
                                  children: <Widget>[
                                    Text(
                                      openAllDay ? hoursAllDaySelected[index] : hoursDaySelected[index],
                                      style: TextStyle(fontSize: 17),
                                    ),
                                    SizedBox(width: 3),
                                    Icon(Icons.edit),
                                  ],
                                ),
                              )).toList(),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  children: <Widget>[
                    Text(
                      openAllDay ? "Soir" : "Après-midi",
                      style: TextStyle(fontSize: 17),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: List.generate(
                          openAllDay ? 1 : 2,
                          (index) => GestureDetector(
                                onTap: () => _showTimePicker(openAllDay ? index + 1 : index + 2),
                                child: Row(
                                  children: <Widget>[
                                    Text(
                                      openAllDay ? hoursAllDaySelected[index + 1] : hoursDaySelected[index + 2],
                                      style: TextStyle(fontSize: 17),
                                    ),
                                    SizedBox(width: 3),
                                    Icon(Icons.edit),
                                  ],
                                ),
                              )).toList(),
                    ),
                  ],
                ),
              )
            ],
          ),
          SizedBox(height: 5),
          Row(
            children: [
              GestureDetector(
                onTap: () => setState(() {
                  isClosed = !isClosed;
                  tempHour = isClosed ? "Fermé" : tempHour;
                  hours = tempHour;
                }),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Checkbox(
                      value: isClosed,
                      onChanged: (value) => setState(() {
                        isClosed = value;
                        tempHour = value ? "closed" : tempHour;
                        hours = tempHour;
                      }),
                    ),
                    SizedBox(width: 10),
                    Text("Fermé"),
                  ],
                ),
              ),
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
                  width: 125,
                  child: OutlinedButton(
                    onPressed: () =>
                        widget.onCancel != null ? widget.onCancel() : Get.back(),
                    child: Text(
                      "Annuler",
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
                    if (isClosed)
                      hours = "Fermé";
                    else if (openAllDay)
                      hours = hoursAllDaySelected.join(" - ");
                    else
                      hours = hoursDaySelected[0] + " - " + hoursDaySelected[1] + ", " + hoursDaySelected[2] + " - " + hoursDaySelected[3];
                    widget.onConfirm(hours);
                    Get.back();
                  },
                  text: "Confirmer",
                  colorBackground: ConstantColor.grey,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  _showTimePicker(int index) async {
    print("show time picker");
    final TimeOfDay picked = await showTimePicker(
      context: context,
      initialTime: selectedTime,
    );
    if (picked != null) {
      setState(() {
        selectedTime = picked;
        var _hour = selectedTime.hour.toString();
        var _minute = selectedTime.minute.toString();
        if (selectedTime.minute < 10) _minute = "0" + _minute;
        var _time = _hour + ':' + _minute;
        if (openAllDay) {
          hoursAllDaySelected[index] = _time;
        } else {
          hoursDaySelected[index] = _time;
        }
      });
    }
  }
}
