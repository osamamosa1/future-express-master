import 'package:flutter/material.dart';

class Palette {
  static const blackColor = Color(0xFF2C3E50);
  static const whiteColor = Colors.white;
  static const greyColor = Colors.grey;
  static const primarygreyColor = Color(0xFFECEAEC);
  static const primaryColor = Color(0xFFB61919);
  static const primaryLightColor = Color(0xFFC75E5E);
  static const primaryGradient = LinearGradient(
    begin: Alignment.centerRight,
    end: Alignment.centerLeft,
    colors: [
      Color(0xFFFF0000),
      Color(0xFFF85656),
    ],
  );
  static const primaryReversedGradient = LinearGradient(
    begin: Alignment.centerRight,
    end: Alignment.centerLeft,
    colors: [
      Color(0xFFF85656),
      Color(0xFFFF0000),
    ],
  );
  static const successColor = Color(0xFF2CAF51);
  static const dangerColor = Color(0xFFE63A46);
  static const disabledColor = Color(0xFFDDDDDD);
  static const disabledTextColor = Color(0xFFA2A2A2);
  static const yellowStarColor = Color.fromRGBO(237, 191, 25, 1);
  static final overlayGradient = LinearGradient(
    colors: [
      Palette.blackColor.withOpacity(0.75),
      Palette.blackColor.withOpacity(0),
    ],
    stops: const [0, 0.4],
    begin: Alignment.bottomCenter,
    end: Alignment.topCenter,
  );

  /// Used when you want to put a color in place of a gradient
  static Gradient colorGradient([Color color = Palette.blackColor]) {
    return LinearGradient(colors: [color, color]);
  }

  static final cardShadow = BoxShadow(
    blurRadius: 19.0,
    spreadRadius: -1.0,
    color: blackColor.withOpacity(0.1),
  );
}
