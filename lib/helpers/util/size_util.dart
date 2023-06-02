import 'package:flutter_screenutil/flutter_screenutil.dart';

class SizeUtil {
  static double setWidth(double width) {
    return width.w;
  }

  static double setHeight(double height) {
    return height.h;
  }

  static double setFontSize(double fontSize) {
    return fontSize.sp;
  }

  static double setRadius(double radius) {
    return radius.r;
  }
}

class ManagerHeight {
  static double h24 = SizeUtil.setHeight(24);
  static double h40 = SizeUtil.setHeight(40);
  static double h10 = SizeUtil.setHeight(10);
}

class ManagerWidth {
  static double w24 = SizeUtil.setWidth(24);
  static double w10 = SizeUtil.setWidth(10);
}
