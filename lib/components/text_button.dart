import 'package:flutter/material.dart';

import '../helpers/manager_color.dart';

class TextButtonWidget extends StatelessWidget {
  TextButtonWidget({
    super.key,
    this.onPressed,
    required this.text,
    this.textDecoration,
    this.textColor = const Color(0xFF324ca0),
  });
  String text;
  Color textColor;
  TextDecoration? textDecoration;
  Function()? onPressed;
  @override
  Widget build(BuildContext context) {
    return TextButton(
        style: TextButton.styleFrom(
          foregroundColor: ManagerColor.kPrimaryColor,
        ),
        onPressed: onPressed,
        child: Text(
          text,
          style: TextStyle(decoration: textDecoration, color: textColor),
        ));
  }
}
