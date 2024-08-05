import 'package:flutter/material.dart';

class ColorManager {
  static const Color primaryBlack = Color(0xFF000000);
  static const Color primaryWhite = Color(0xFFFFFFFF);
  static const Color grey = Color.fromARGB(255, 38, 38, 38);

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

  static Color greyColor(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark
        ? grey
        : primaryWhite;
  }
}
