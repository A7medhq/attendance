import 'package:attendance/helpers/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../helpers/manager_color.dart';

class ButtonWidget extends StatelessWidget {
  ButtonWidget({super.key, this.text, this.num = 190.0, this.color});
  String? text;
  double? num;
  Color? color;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: num,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: color ?? ManagerColor.kPrimaryColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Center(
        child: Text(
          '$text',
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
