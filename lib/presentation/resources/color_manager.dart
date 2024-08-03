import 'package:flutter/material.dart';

class ColorManager {
  static const Color primaryBlack = Color(0xFF000000);
  static const Color primaryWhite = Color(0xFFFFFFFF);
  static const Color secondaryBlack = Color(0xFF333333);
  static const Color secondaryWhite = Color(0xFFEEEEEE);

  static Color blackColor(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark
        ? primaryWhite
        : primaryBlack;
  }

  static Color whiteColor(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark
        ? primaryBlack
        : primaryWhite;
  }

  static Color secondaryBlackColor(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark
        ? secondaryWhite
        : secondaryBlack;
  }

  static Color secondaryWhiteColor(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark
        ? secondaryBlack
        : secondaryWhite;
  }
}
