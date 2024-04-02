


import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HeaderLoginScreen extends StatelessWidget {
  const HeaderLoginScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
           SizedBox(
                  height: 70.h,
                ),
                Image.asset(
                  'assets/icons/lines.png',
                  fit: BoxFit.fill,
                  width: 0.3.sw,
                  height: 50.h,
                ),
                const SizedBox(
                  height: 50,
                ),
                Align(
                  alignment: Alignment.center,
                  child: Image.asset(
                    'assets/images/logo_splash.png',
                    fit: BoxFit.fill,
                    width: 0.6.sw,
                    height: 75,
                  ),
                ),
      ],
    );}
}
