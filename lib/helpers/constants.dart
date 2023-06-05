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
  static const double deviceWidth = 375;
  static const double deviceHeight = 812;
  static const int dateTimeDuration = 2;
  static const double latLnglatitude = 0;
  static const double latLnglongitude = 0;
  static const double zoom15 = 15.4746;
  static const double zoom18 = 18;
  static const int flex3 = 3;
  static const int errorCode = 0;
  static const EdgeInsets dashBoardShimmerPadding =
      EdgeInsets.fromLTRB(8, 32, 8, 8);
  static const double elevationCard = 2;
  static const EdgeInsets cardPadding = EdgeInsets.fromLTRB(0, 12.0, 0, 6);
  static const EdgeInsets cardPadding = EdgeInsets.fromLTRB(0, 12.0, 0, 6);
}

class NextRecordTypeConstants {
  static const int zeroNextRecordType = 0;
  static const int firstNextRecordType = 1;
  static const int secondNextRecordType = 2;
  static const int thirdNextRecordType = 3;
  static const int fourthNextRecordType = 4;
}
