import 'package:attendance/helpers/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class ButtonWidget extends StatelessWidget {
  ButtonWidget({super.key, this.text, this.num = 190.0, this.color});
  String? text;
  double? num;
  Color? color;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: num,
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: color == null ? kPrimaryColor : color,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Center(
        child: Text(
          '$text',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
