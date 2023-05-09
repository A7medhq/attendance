import 'package:flutter/material.dart';

import '../providers/constants.dart';

class MyTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final bool isReadOnly;
  final bool? isEnabled;
  final IconData? prefixIconData;
  final Function(String)? onChanged;
  final double? width;
  final double? height;
  const MyTextField(
      {Key? key,
      required this.hintText,
      required this.controller,
      this.isReadOnly = false,
      this.isEnabled,
      this.prefixIconData,
      this.onChanged,
      this.width,
      this.height})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width == null ? double.infinity : width,
      height: height,
      child: TextField(
          onChanged: onChanged,
          controller: controller,
          readOnly: isReadOnly,
          enabled: isEnabled,
          decoration: InputDecoration(
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
