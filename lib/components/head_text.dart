import 'package:flutter/material.dart';

class TextWidget extends StatelessWidget {
  final String text;

  TextWidget({required this.text});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 20,
      ),
    );
  }
}
