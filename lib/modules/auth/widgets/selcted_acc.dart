import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:future_express/shared/palette.dart';
import 'package:future_express/shared/router.dart';
import 'package:future_express/shared/utils/extension.dart';

import '../screens/sign_up_screen.dart';

class SelctedAccuontBottomShet extends StatelessWidget {
  const SelctedAccuontBottomShet({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom, top: 10.h),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        height: 400.h,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'الرجاء إختيار طريقة التسجيل',
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 15,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 130,
                  width: 130,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(color: Palette.primaryColor)),
                  child: GestureDetector(
                    onTap: () async {
                      unawaited(Navigator.of(context).push(MaterialPageRoute(
                          builder: (con) => const SignUpScreen())));
                    },
                    child: Column(
                      children: [
                        Image.asset(
                          'assets/images/courier.png',
                          height: 100,
                          width: 100,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          context.tr.register_now_as_a_representative,
                          style: const TextStyle(
                              fontSize: 14, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  width: 25.w,
                ),
                Container(
                  height: 130,
                  width: 130,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(color: Palette.primaryColor)),
                  child: GestureDetector(
                    onTap: () async {
                      await router.push('/JoinServiceProviderScreen');
                    },
                    child: Column(
                      children: [
                        Image.asset(
                          'assets/images/arabian.png',
                          height: 100,
                          width: 100,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          context.tr.request_join_service_provider,
                          style: const TextStyle(
                              fontSize: 14, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
