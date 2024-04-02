import 'package:flutter/material.dart';
import 'package:future_express/shared/palette.dart';

class BodyText1 extends StatelessWidget {
  final String text;
  const BodyText1({
    super.key,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: TextAlign.center,
      style: const TextStyle(
        fontSize: 16,
        color: Palette.blackColor,
      ),
    );
  }
}
