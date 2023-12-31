import 'package:flutter/material.dart';

import '../helpers/constants.dart';

class TextFieldCustom extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final String? labelText;
  final bool isReadOnly;
  final bool? isEnabled;
  final IconData? prefixIconData;
  final Function(String)? onChanged;
  final double? width;
  final double? height;
  const TextFieldCustom(
      {Key? key,
      required this.hintText,
      required this.controller,
      this.isReadOnly = false,
      this.isEnabled,
      this.prefixIconData,
      this.onChanged,
      this.width,
      this.height,
      this.labelText})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width ?? double.infinity,
      height: height,
      child: TextField(
          onChanged: onChanged,
          controller: controller,
          readOnly: isReadOnly,
          enabled: isEnabled,
          decoration: InputDecoration(
            labelText: labelText,
            fillColor: Colors.white,
            filled: true,
            hintText: hintText,
            disabledBorder: kOutlineBorder,
            enabledBorder: kOutlineBorder,
            focusedBorder: kOutlineBorder,
          )),
    );
  }
}
