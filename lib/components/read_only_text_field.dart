import 'package:flutter/material.dart';

class ReadOnlyTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final bool isReadOnly;
  final bool? isEnabled;
  final IconData? prefixIconData;
  final Function(String)? onChanged;
  final double? width;
  final double? height;
  final Color? textColor;
  final TextAlign textAlign;
  const ReadOnlyTextField(
      {Key? key,
      required this.hintText,
      required this.controller,
      this.isReadOnly = false,
      this.isEnabled,
      this.prefixIconData,
      this.onChanged,
      this.width,
      this.height,
      this.textColor,
      required this.textAlign})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width == null ? double.infinity : width,
      height: height,
      child: TextField(
          onChanged: onChanged,
          controller: controller,
          readOnly: true,
          enabled: false,
          style: TextStyle(color: textColor, fontSize: 15),
          textAlign: textAlign,
          decoration: InputDecoration(
            filled: false,
            hintText: hintText,
            border: InputBorder.none,
          )),
    );
  }
}
