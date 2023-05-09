import 'package:attendance/providers/constants.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';

class MyDatePicker extends StatefulWidget {
  TextEditingController? controller;

  MyDatePicker({Key? key, required this.controller}) : super(key: key);

  @override
  State<MyDatePicker> createState() => _MyDatePickerState();
}

class _MyDatePickerState extends State<MyDatePicker> {
  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: TextField(
          controller: widget.controller, //editing controller of this TextField
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white,
            enabledBorder: kOutlineBorder,
            focusedBorder: kOutlineBorder,

            suffixIcon: Icon(
              FontAwesomeIcons.calendar,
              color: kPrimaryColor,
            ), //icon of text field
          ),
          readOnly: true, // when true user cannot edit text
          onTap: () async {
            DateTime? pickedDate = await showDatePicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime(1950),
                //DateTime.now() - not to allow to choose before today.
                lastDate: DateTime(2100),
                builder: (context, child) {
                  return Theme(
                    data: Theme.of(context).copyWith(
                      colorScheme: ColorScheme.light(
                        primary: kPrimaryColor, // <-- SEE HERE
                        onPrimary: Colors.white, // <-- SEE HERE
                        onSurface: kDarkColor, // <-- SEE HERE
                      ),
                      textButtonTheme: TextButtonThemeData(
                        style: TextButton.styleFrom(
                          foregroundColor: kPrimaryColor, // button text color
                        ),
                      ),
                    ),
                    child: child!,
                  );
                });

            if (pickedDate != null) {
              print(
                  pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
              String formattedDate =
                  DateFormat('yyyy-MM-dd').format(pickedDate);
              print(
                  formattedDate); //formatted date output using intl package =>  2021-03-16
              setState(() {
                widget.controller?.text =
                    formattedDate; //set output date to TextField value.
              });
            } else {}
          }),
    );
  }
}
