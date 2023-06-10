import 'package:attendance/helpers/constants.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';

import '../helpers/manager_color.dart';

class DatePickerCustom extends StatefulWidget {
  TextEditingController? controller;

  DatePickerCustom({Key? key, required this.controller}) : super(key: key);

  @override
  State<DatePickerCustom> createState() => _DatePickerCustomState();
}

class _DatePickerCustomState extends State<DatePickerCustom> {
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

            suffixIcon: const Icon(
              FontAwesomeIcons.calendar,
              color: ManagerColor.kPrimaryColor,
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
                      colorScheme: const ColorScheme.light(
                        primary: ManagerColor.kPrimaryColor, // <-- SEE HERE
                        onPrimary: Colors.white, // <-- SEE HERE
                        onSurface: ManagerColor.black, // <-- SEE HERE
                      ),
                      textButtonTheme: TextButtonThemeData(
                        style: TextButton.styleFrom(
                          foregroundColor:
                              ManagerColor.kPrimaryColor, // button text color
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
