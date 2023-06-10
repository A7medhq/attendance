import 'package:attendance/helpers/manager_fonts.dart';
import 'package:attendance/helpers/manager_sizes.dart';
import 'package:flutter/material.dart';

import 'manager_color.dart';

// ===================== T E X T S ===============================

TextStyle kHeadText = TextStyle(
  fontWeight: FontWeight.bold,
  fontSize: ManagerFontSize.s18,
);

TextStyle kHintText = TextStyle(
  color: ManagerColor.grey,
  fontSize: ManagerFontSize.s14,
);

// ===================== I N P U T S ===============================

InputBorder kOutlineBorder = OutlineInputBorder(
  borderRadius: BorderRadius.circular(
    ManagerRadius.r8,
  ),
  borderSide: BorderSide(
    width: ManagerWidth.w1,
    color: ManagerColor.grey,
  ),
);

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
  static const EdgeInsets dashBoardPadding =
      EdgeInsets.only(top: 0, right: 24.0, left: 24.0, bottom: 8);
  static const double cardVerticalPadding = 12.0;
  static const int maxLines = 1;
}

class NextRecordTypeConstants {
  static const int zeroNextRecordType = 0;
  static const int firstNextRecordType = 1;
  static const int secondNextRecordType = 2;
  static const int thirdNextRecordType = 3;
  static const int fourthNextRecordType = 4;
}
