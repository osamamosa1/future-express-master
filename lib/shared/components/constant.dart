import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void printFullText(String text) {
  final pattern = RegExp('.{1,800}');
  // ignore: avoid_print
  pattern.allMatches(text).forEach((element) => print(element.group(0)));
}

const Duration kAnimationDuration = Duration(milliseconds: 300);
const Curve kAnimationCurve = Curves.easeInOut;

EdgeInsets kPagePadding = EdgeInsets.symmetric(
  horizontal: 16.w,
);

EdgeInsets kCardPadding = EdgeInsets.symmetric(
  horizontal: 16.w,
  vertical: 16.h,
);

EdgeInsets kInputFieldPadding = EdgeInsets.symmetric(
  horizontal: 16.w,
  vertical: 16.h,
);

BorderRadiusGeometry kCardBorderRadius = BorderRadius.circular(
  16.r,
);

BorderRadius kAppIconBorderRadius = BorderRadius.circular(
  8.r,
);

BorderRadiusGeometry kBottomSheetBorderRadius = BorderRadius.only(
  topLeft: Radius.circular(16.r),
  topRight: Radius.circular(16.r),
);

class Validation {
  String? confirmPass;

  Validation();

  Validation.pass(String value) {
    confirmPass = value;
  }

  String? emailValidator(String? value) {
    RegExp? regex = RegExp(
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');
    if (!regex.hasMatch(value!)) {
      return 'البريد الالكتروني غير صحيح';
    } else {
      return null;
    }
  }

  String? ageValidator(String? value) {
    if (value == null) {
      return 'برجاء ادخال العمر ';
    } else {
      return null;
    }
  }

  String? mobValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'يرجى إدخال رقم الهاتف';
    } else if (value.length < 9) {
      return 'يجب أن يحتوي رقم الهاتف على 9 أرقام';
    }
    return null;
  }

  String? empty(String? value) {
    if (value!.isEmpty) {
      return 'هذا الحقل مطلوب';
    } else {
      return null;
    }
  }

  String? matchPassword(String? value) {
    if (!(value == confirmPass)) {
      return 'password dosent match';
    } else {
      return null;
    }
  }
}

String? ID = '';
