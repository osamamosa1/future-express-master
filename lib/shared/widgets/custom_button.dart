import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:future_express/shared/palette.dart';

import '../styles/sizeConfig.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPress;

  const CustomButton(this.text, {super.key, this.onPress});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8.0.h),
      child: GestureDetector(
        onTap: onPress,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(
              SizeConfig.safeBlockHorizontal * 15,
            ),
            color: Palette.primaryColor,
          ),
          padding: EdgeInsets.symmetric(
            vertical: SizeConfig.safeBlockVertical * 1.5,
          ),
          width: 0.97.sw,
          alignment: Alignment.center,
          child: Text(
            text,
            style: TextStyle(
              color: Colors.white,
              fontSize: 18.sp,
            ),
          ),
        ),
      ),
    );
  }
}
