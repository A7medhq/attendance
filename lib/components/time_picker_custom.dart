import 'package:attendance/providers/constants.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';

class TimePickerCustom extends StatefulWidget {
  int? addedHours;
  TextEditingController? controller;

  TimePickerCustom({Key? key, required this.controller, this.addedHours})
      : super(key: key);

  @override
  State<TimePickerCustom> createState() => _TimePickerCustomState();
}

class _TimePickerCustomState extends State<TimePickerCustom> {
  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: TextField(
          controller: widget.controller, //editing controller of this TextField
          decoration: InputDecoration(
            fillColor: Colors.white,
            filled: true,
            enabledBorder: kOutlineBorder,
            focusedBorder: kOutlineBorder,

            suffixIcon: Icon(
              FontAwesomeIcons.clock,
              color: kPrimaryColor,
            ), //icon of text field
          ),
          readOnly: true, // when true user cannot edit text
          onTap: () async {
            TimeOfDay? pickedTime = await showTimePicker(
              initialTime: TimeOfDay.now().addHour(widget.addedHours ?? 0),
              context: context,
            );

            if (pickedTime != null) {
              print(pickedTime.format(context)); //output 10:51 PM
              DateTime parsedTime =
                  DateFormat.jm().parse(pickedTime.format(context).toString());
              //converting to DateTime so that we can further format on different pattern.
              print(parsedTime); //output 1970-01-01 22:53:00.000
              String formattedTime = DateFormat('h:mm a').format(parsedTime);
              print(formattedTime); //output 14:59:00
              //DateFormat() is from intl package, you can format the time on any pattern you need.

              setState(() {
                widget.controller?.text =
                    formattedTime; //set the value of text field.
              });
            } else {
              print("Time is not selected");
            }
          }),
    );
  }
}

extension TimeOfDayExtension on TimeOfDay {
  TimeOfDay addHour(int? hour) {
    return replacing(hour: this.hour + hour!, minute: minute);
  }
}
