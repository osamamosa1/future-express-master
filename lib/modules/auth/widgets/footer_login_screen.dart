

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FooterLoginScreen extends StatelessWidget {
  const FooterLoginScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Image.asset(
                    alignment: Alignment.bottomCenter,
                    'assets/images/bottom_login2.png',
                    fit: BoxFit.fitHeight,
                    width: 0.35.sw,
                    height: 0.12.sh,
                  ),
                  Image.asset(
                    alignment: Alignment.bottomCenter,
                    'assets/images/bottom_login1.png',
                    fit: BoxFit.fitHeight,
                    width: 0.45.sw,
                    height: 0.15.sh,
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
