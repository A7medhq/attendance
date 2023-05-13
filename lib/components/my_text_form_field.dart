import 'package:attendance/helpers/constants.dart';
import 'package:flutter/material.dart';

class MyTextFormField extends StatelessWidget {
  final String text;
  bool isReadOnly;

  MyTextFormField({super.key, required this.text, this.isReadOnly = false});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      readOnly: isReadOnly,
      decoration: InputDecoration(
        contentPadding:
            const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        hintText: text,
        border: OutlineInputBorder(
          borderSide: BorderSide(color: kLightColor),
        ),
      ),
    );
  }
}
