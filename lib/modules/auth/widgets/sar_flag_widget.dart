import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../shared/palette.dart';

// ignore: must_be_immutable
class SarFlagWidget extends StatelessWidget {
  final double size;
  bool filled;
  bool outline;
  SarFlagWidget(
      {super.key,
      required this.size,
      this.outline = false,
      this.filled = false});

  final _flagController = TextEditingController(text: '0');
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      child: TextField(
        controller: _flagController,
        textAlign: TextAlign.center,
        style: const TextStyle(color: Palette.blackColor),
        decoration: InputDecoration(
            fillColor: filled ? Palette.whiteColor : null,
            filled: filled ? true : false,
            isDense: true,
            contentPadding: const EdgeInsets.symmetric(vertical: 14),
            enabledBorder: outline
                ? OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide:
                        const BorderSide(color: Palette.greyColor, width: 1.0))
                : const UnderlineInputBorder(
                    borderSide:
                        BorderSide(color: Palette.greyColor, width: 1.0)),
            border: outline
                ? OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide:
                        const BorderSide(color: Palette.greyColor, width: 1.0))
                : const UnderlineInputBorder(
                    borderSide:
                        BorderSide(color: Palette.greyColor, width: 1.0)),
            enabled: false,
            suffix: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  '  966+  ',
                  style: TextStyle(
                    color: Palette.blackColor,
                  ),
                ),
                SvgPicture.asset(
                  'assets/icons/sar_flag.svg',
                  height: 30,
                  width: 30,
                  fit: BoxFit.cover,
                ),
              ],
            )),
      ),
    );
  }
}
