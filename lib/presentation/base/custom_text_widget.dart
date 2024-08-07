import 'package:flutter/material.dart';
import 'package:prince_portfolio/presentation/resources/color_manager.dart';

class CustomTextWidget extends StatelessWidget {
  final String text;
  final double? fontSize;
  final double? latterSpacing;
  final FontWeight? fontWeight;
  final Color? color;
  final TextAlign? textAlign;
  const CustomTextWidget(
      {super.key,
      required this.text,
      this.fontSize,
      this.latterSpacing,
      this.fontWeight,
      this.color,
      this.textAlign});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
          letterSpacing: latterSpacing ?? 1,
          color: color ?? ColorManager.blackColor(context),
          fontSize: fontSize ?? 14,
          fontWeight: fontWeight ?? FontWeight.normal),
    );
  }
}
