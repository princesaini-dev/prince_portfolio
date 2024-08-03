import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:prince_portfolio/presentation/resources/image_manager.dart';

extension SVGImages on String {
  Widget loadSVGImage(
      {String? label,
      double width = 20,
      double height = 20,
      BoxFit fit = BoxFit.contain,
      Color color = Colors.white}) {
    return SvgPicture.asset(
      ImageManager.iconLinkedin,
      semanticsLabel: 'label',
      width: width,
      height: height,
      fit: fit,
    );
  }

  Widget loadImages(
      {String? label,
      double width = 20,
      double height = 20,
      BoxFit fit = BoxFit.contain,
      Color color = Colors.white}) {
    return Image.asset(
      this,
      semanticLabel: label,
      color: color,
      width: width,
      height: height,
      fit: fit,
    );
  }
}
