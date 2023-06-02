import 'package:flutter/material.dart';

// ===================== C O L O R S ===========================
Color kPrimaryColor = const Color(0xFF324ca0);
Color kDarkColor = Colors.black;
Color kLightColor = const Color.fromARGB(255, 235, 233, 233);
Color kScaffoldColor = Colors.grey.shade200;

// ===================== T E X T S ===============================

TextStyle kHeadText =
    const TextStyle(fontWeight: FontWeight.bold, fontSize: 18);

TextStyle kHintText = const TextStyle(color: Colors.grey, fontSize: 14);

// ===================== I N P U T S ===============================

InputBorder kOutlineBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(8),
    borderSide: const BorderSide(width: 1, color: Colors.grey));

class Constants {
  static const int dateTimeDuration = 2;
}
