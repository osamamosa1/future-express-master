import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:future_express/shared/utils/extension.dart';

class OrderEmpty extends StatelessWidget {
  const OrderEmpty({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          SvgPicture.asset(
            'assets/images/Mystery.svg',
            height: 600.h,
          ),
          Text(
            context.tr.no_current_requests,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
          Text(context.tr.here_you_can_access_current_orders,
              textAlign: TextAlign.center),
        ],
      ),
    );
  }
}
