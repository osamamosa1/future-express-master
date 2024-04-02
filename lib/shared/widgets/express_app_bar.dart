import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../palette.dart';
import '../router.dart';

class ExpressAppBar extends AppBar {
  final String myTitle;
  final Widget? widget;

  ExpressAppBar({super.key, required this.myTitle, this.widget})
      : super(
          title: Text(
            myTitle,
            style: const TextStyle(
              color: Palette.blackColor,
            ),
          ),
          elevation: 0,
          centerTitle: true,
          leading: widget ??
              IconButton(
                onPressed: () => router.pop(),
                icon:
                    const Icon(Icons.arrow_back_ios, color: Palette.greyColor),
              ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(10.h),
            ),
          ),
        );
}
