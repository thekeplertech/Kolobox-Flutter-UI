import 'dart:io';

import 'package:flutter/material.dart';

extension ImageExtension on String {
  Image getImage({
    double? height = 2.0,
    double? width = 2.0,
    Color? imgColor,
    BoxFit? boxFit,
  }) =>
      Image.asset(
        this,
        height: height,
        width: width,
        color: imgColor,
        fit: boxFit,
      );

  Image getImageFile({
    double? height = 2.0,
    double? width = 2.0,
    Color? imgColor,
    BoxFit? boxFit,
  }) =>
      Image.file(
        File(this),
        height: height,
        width: width,
        color: imgColor,
        fit: boxFit,
      );

  Widget getRoundedImage({
    double height = 23,
    double width = 23,
    double padding = 6,
    Color? backColor,
    Color? iconColor,
  }) =>
      Container(
        height: height,
        width: width,
        decoration: BoxDecoration(shape: BoxShape.circle, color: backColor),
        padding: EdgeInsets.all(padding),
        child: Image.asset(
          this,
          color: iconColor,
        ),
      );
}
