import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../palette.dart';

// ignore: must_be_immutable
class ExpressTextField extends StatelessWidget {
  final String hint;
  TextEditingController? controller;
  Widget? prefix;

  ExpressTextField({
    required this.hint,
    this.controller,
    this.prefix,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 80.h,
      child: TextFormField(
        controller: controller,
        // scrollPadding: const EdgeInsets.all(5),

        textAlignVertical: TextAlignVertical.bottom,
        
        decoration: InputDecoration(
            hintText: hint,
            prefixIcon: prefix == null
                ? null
                : Padding(
                    padding: const EdgeInsets.only(left: 7, right: 7),
                    child: prefix,
                  ),
            prefixIconConstraints: const BoxConstraints(
                maxWidth: 35, maxHeight: 35, minWidth: 35, minHeight: 35),
            fillColor: Palette.whiteColor,
            filled: true,
            isDense: true,
            contentPadding: const EdgeInsetsDirectional.fromSTEB(10, 22, 0, 17),
            border: OutlineInputBorder(
                gapPadding: 5,
                borderRadius: BorderRadius.circular(10),
                borderSide:
                    const BorderSide(color: Palette.greyColor, width: 1)),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide:
                    const BorderSide(color: Palette.greyColor, width: 1)),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide:
                    const BorderSide(color: Palette.primaryColor, width: 1))),
        validator: (value) {
          if (value!.isEmpty) {
            return 'هذا الحقل مطلوب';
          } else {
            return null;
          }
        },
      ),
    );
  }
}
