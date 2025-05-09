import 'package:flutter/material.dart';
import '../core/app_export.dart';

class AppDecoration {
  // Fill decorations
  static BoxDecoration get fillBlack => BoxDecoration(color: appTheme.black900);
  // Outline decorations
  static BoxDecoration get outlineBlack => BoxDecoration(
    color: appTheme.gray90001,
    boxShadow: [
      BoxShadow(
        color: appTheme.black900.withOpacity(0.1),
        spreadRadius: 2.h,
        blurRadius: 2.h,
        offset: Offset(0, 0),
      ),
    ],
  );
  static BoxDecoration get outlineGray => BoxDecoration(
    color: appTheme.gray900,
    border: Border.all(color: appTheme.gray900, width: 0.6.h),
  );
}

class BorderRadiusStyle {
  // Circle borders
  static BorderRadius get circleBorder12 => BorderRadius.circular(12.h);
  static BorderRadius get circleBorder16 => BorderRadius.circular(16.h);
  // Rounded borders
  static BorderRadius get roundedBorder8 => BorderRadius.circular(8.h);
}
