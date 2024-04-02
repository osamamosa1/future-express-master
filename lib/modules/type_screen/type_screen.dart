
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:future_express/shared/router.dart';

import '../../shared/network/local/cache_helper.dart';
import '../../shared/palette.dart';

class TypeScreen extends StatelessWidget {
  const TypeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'دخول ك مندوب مطعم او مندوب متجر',
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 15,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 150,
                  width: 250,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(color: Palette.primaryColor)),
                  child: GestureDetector(
                    onTap: () async {
                      await CacheHelper.saveData(key: 'user', value: 2);
                      router.go('/homeLayOut');
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
                        const Text(
                          'دخول ك مندوب مطعم',
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 25.h,
                ),
                Container(
                  height: 150,
                  width: 250,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(color: Palette.primaryColor)),
                  child: GestureDetector(
                    onTap: () async {
                      await CacheHelper.saveData(key: 'user', value: 1);
                      router.go('/homeLayOut');
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
                        const Text(
                          'دخول ك مندوب متجر',
                          style: TextStyle(
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
