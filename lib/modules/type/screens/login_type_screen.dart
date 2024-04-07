import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:future_express/modules/type/widgets/login_type_item.dart';
import 'package:future_express/shared/network/local/cache_helper.dart';
import 'package:future_express/shared/router.dart';

class LoginTypeScreen extends StatelessWidget {
  const LoginTypeScreen({super.key, required this.types});

  final List<int> types;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('طريقة تسجيل دخولك'),
        backgroundColor: Colors.transparent,
        centerTitle: true,
        elevation: 0,
      ),
      body: Padding(
        padding: EdgeInsetsDirectional.symmetric(
            horizontal: MediaQuery.sizeOf(context).width * 0.1),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Align(
              alignment: Alignment.center,
              child: Text(
                'وش حابب تكون اليوم \n يا بطلنا !',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFFca1221),
                ),
              ),
            ),
            SizedBox(height: 20.h),
            Row(
              children: [
                if (types.contains(1))
                  InkWell(
                    onTap: () async {
                      await CacheHelper.saveData(key: 'user', value: 2);
                      router.go('/homeLayOut');
                    },
                    child: const LoginTypeItem(
                      text: 'مندوب مطاعم',
                      image: 'assets/images/mt3am.png',
                    ),
                  ),
                if (types.contains(2))
                  InkWell(
                    onTap: () async {
                      await CacheHelper.saveData(key: 'user', value: 1);
                      router.go('/homeLayOut');
                    },
                    child: const LoginTypeItem(
                      text: 'مندوب طرود',
                      image: 'assets/images/trood.png',
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (types.contains(4))
                  InkWell(
                    onTap: () async {
                      await CacheHelper.saveData(key: 'user', value: 4);
                      router.go('/homeLayOut');
                    },
                    child: const LoginTypeItem(
                      text: 'مندوب فلفمنت',
                      image: 'assets/images/folfelment.png',
                    ),
                  ),
              ],
            ),
            // const Spacer(flex: 2),
            // SizedBox(
            //   width: 1.sw,
            //   height: 100.h,
            //   child: ExpressButton(
            //     onPressed: () {},
            //     // unawaited(_logIn(context)),
            //     child: const Text(
            //       "الإختيار",
            //       style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
            //     ),
            //   ),
            // ),
            // const Spacer(),
          ],
        ),
      ),
    );
  }
}
