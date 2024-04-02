import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hexcolor/hexcolor.dart';

Widget myDivider() => Padding(
      padding: const EdgeInsetsDirectional.only(
        start: 20.0,
      ),
      child: Container(
        width: double.infinity,
        height: 3.0,
        color: Colors.grey[300],
      ),
    );

void showToast({required String? message, required ToastStates toastStates}) =>
    unawaited(Fluttertoast.showToast(
        msg: message ?? '',
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 5,
        backgroundColor: chooseToastColor(toastStates),
        textColor: Colors.white,
        fontSize: 16.0));

// ignore: constant_identifier_names
enum ToastStates { SUCCESS, EROOR, WARNING }

Color chooseToastColor(ToastStates states) {
  Color color;
  switch (states) {
    case ToastStates.SUCCESS:
      color = Colors.green;
      break;
    case ToastStates.EROOR:
      color = Colors.red;
      break;
    case ToastStates.WARNING:
      color = const Color.fromARGB(255, 214, 147, 3);
      break;
  }
  return color;
}

Color colorFormField = HexColor('#F6F8FF');
Color colorField = HexColor('#4182FF');

// ignore: must_be_immutable
class TextFieldShape extends StatelessWidget {
  TextFieldShape(
      {super.key,
      required this.controller,
      required this.validate,
      required this.label,
      required this.type,
      this.onSubmit,
      this.formatter,
      this.onTap,
      required this.isPassword,
      this.suffix,
      this.suffixPressed,
      required this.isClickable,
      this.lines,
      this.onChange});

  TextEditingController controller;
  TextInputType type;
  ValueChanged<String>? onSubmit;
  ValueChanged<String>? onChange;
  List<TextInputFormatter>? formatter;
  GestureTapCallback? onTap;
  bool isPassword = false;
  FormFieldValidator<String>? validate;
  String label;
  IconData? suffix;
  VoidCallback? suffixPressed;
  bool isClickable = true;
  int? lines = 1;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white.withOpacity(0.64),
      padding: EdgeInsets.all(16.w),
      child: TextFormField(
        controller: controller,
        onTapOutside: (event) => FocusManager.instance.primaryFocus?.unfocus(),
        keyboardType: type,
        inputFormatters: <TextInputFormatter>[...?formatter],
        enabled: isClickable,
        onFieldSubmitted: onSubmit,
        onChanged: onChange,
        onTap: onTap,
        maxLines: lines,
        validator: validate,
        style: Theme.of(context).textTheme.displayMedium!.copyWith(
            color: Colors.black, fontSize: 14.sp, fontWeight: FontWeight.w400),
        decoration: InputDecoration(
          hoverColor: Colors.white,
          contentPadding: EdgeInsets.symmetric(horizontal: 20.h, vertical: 10),
          border: OutlineInputBorder(
            gapPadding: 151,
            borderRadius: BorderRadius.circular(50.sp),
            borderSide: BorderSide(
                style: BorderStyle.solid, color: Colors.grey.shade400),
          ),
          hintText: label,
          fillColor: Colors.black,
          focusColor: Colors.black,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(50.sp),
            borderSide: BorderSide(
                style: BorderStyle.solid, color: Colors.grey.shade300),
          ),
        ),
      ),
    );
  }
}

Widget defaultFormField({
  required TextEditingController controller,
  required TextInputType type,
  ValueChanged<String>? onSubmit,
  ValueChanged<String>? onChange,
  GestureTapCallback? onTap,
  bool isPassword = false,
  required FormFieldValidator<String>? validate,
  required String label,
  required Widget prefix,
  IconData? suffix,
  VoidCallback? suffixPressed,
  bool isClickable = true,
  int? lines,
}) =>
    TextFormField(
      controller: controller,
      keyboardType: type,
      obscureText: isPassword,
      enabled: isClickable,
      onFieldSubmitted: onSubmit,
      onChanged: onChange,
      onTap: onTap,
      maxLines: lines,
      validator: validate,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: prefix,
        suffixIcon: suffix != null
            ? IconButton(
                onPressed: suffixPressed,
                icon: Icon(
                  suffix,
                ),
              )
            : null,
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(15.0),
          ),
        ),
      ),
    );
