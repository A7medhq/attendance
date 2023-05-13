import 'package:attendance/helpers/constants.dart';
import 'package:flutter/material.dart';

class TextButtonWidget extends StatelessWidget {
  TextButtonWidget(
      {super.key, this.onPressed, required this.text, this.textDecoration});
  String text;
  TextDecoration? textDecoration;
  Function()? onPressed;
  @override
  Widget build(BuildContext context) {
    return TextButton(
        style: TextButton.styleFrom(
          foregroundColor: kPrimaryColor,
        ),
        onPressed: onPressed,
        child: Text(
          text,
          style: TextStyle(decoration: textDecoration, color: kPrimaryColor),
        ));
  }
}
