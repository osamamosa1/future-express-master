
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:future_express/modules/auth/widgets/pick_image_widget.dart';
import 'package:future_express/modules/restaurant_delivery/orders/cubit/order_cubit.dart';
import 'package:future_express/shared/utils/extension.dart';
import 'package:future_express/shared/widgets/otp_form.dart';
import 'package:geolocator/geolocator.dart';

import '../../../../shared/router.dart';

class OtpConfirm extends StatelessWidget {
  final int isOtp;
  final String orderId;
  final int send_image;
  final Position position;

  const OtpConfirm.OtpConfirm({
    required this.isOtp,
    required this.orderId,
    required this.position,
    super.key,
    required this.send_image,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OrdersRestaurantCubit, OrdersRestaurantState>(
        builder: (context, state) {
      return SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Container(
          height: send_image == 1 ? 0.83.sh : 0.7.sh,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(25)),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: OTPForm(
            isSendImage: send_image == 1 ? true : false,
              buttonText: context.tr.verify,
              isOtp: isOtp == 1 ? true : false,
              image: send_image == 1
                  ? PickImageWidget(
                      title: '',
                      image: OrdersRestaurantCubit.get(context).avatar,
                      onPressed: () async {
                        await OrdersRestaurantCubit.get(context)
                            .getAvatar(orderId);
                      })
                  : const SizedBox(),
              phone: 'code',
              onActivate: (otp) async {
                await OrdersRestaurantCubit.get(context).confirmOtpCode(otp,position);
                if(send_image == 1){
                    await OrdersRestaurantCubit. get (context).getAvatar(orderId);}
                router.go('/homeLayOut');
                return null;
              }),
        ),
      );
    });
  }
}
