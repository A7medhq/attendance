import 'package:attendance/helpers/constants.dart';
import 'package:flutter/material.dart';

import '../helpers/manager_color.dart';

class TextFormFieldCustom extends StatelessWidget {
  final String text;
  bool isReadOnly;

  TextFormFieldCustom({super.key, required this.text, this.isReadOnly = false});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      readOnly: isReadOnly,
      decoration: InputDecoration(
        contentPadding:
            const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        hintText: text,
        border: const OutlineInputBorder(
          borderSide: BorderSide(color: ManagerColor.kLightColor),
        ),
      ),
    );
  }
}
