import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class TextInput extends StatelessWidget {
  TextInput({super.key, this.icon, this.text});
  IconData? icon;
  String? text;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      margin: EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.white,
      ),
      child: Row(children: [
        Icon(
          icon,
          color: Colors.grey,
        ),
        SizedBox(
          width: 10,
        ),
        Text(
          "$text",
          style: TextStyle(
            color: Colors.grey,
            fontSize: 12,
          ),
        ),
      ]),
    );
  }
}
