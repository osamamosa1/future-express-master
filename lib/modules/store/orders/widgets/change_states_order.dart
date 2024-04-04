import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:future_express/model/order.dart';
import 'package:future_express/modules/home/cubit/home_cubit.dart';
import 'package:future_express/shared/utils/extension.dart';
import 'package:future_express/shared/widgets/express_button.dart';
import 'package:geolocator/geolocator.dart';

import '../../../../shared/utils/my_utils.dart';
import '../../../restaurant_delivery/current_orders/widget/otpConfirm.dart';
import '../cubit/order_cubit.dart';

class ChangeStatesOrder extends StatefulWidget {
  final Order order;

  const ChangeStatesOrder({required this.order, super.key});

  @override
  State<ChangeStatesOrder> createState() => _ChangeStatesOrderState();
}

class _ChangeStatesOrderState extends State<ChangeStatesOrder> {
  Position? position;

  getLocation() async {
    position = await Geolocator.getCurrentPosition();
  }

  @override
  void initState() {
    getLocation();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    bool isArabic = Localizations.localeOf(context).languageCode == 'ar';

    return BlocBuilder<HomeCubit, HomeState>(builder: (context, state) {
      var statusesItem = HomeCubit.get(context);
      log("builder bottom Sheet ${statusesItem.statuseItme.toString()}");

      return Container(
          height: 0.7.sh,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(25)),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Column(
            children: [
              Container(
                height: 0.61.sh,
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: ListView(
                  children: [
                    ...[
                      ...statusesItem.statusesItems!.map((value) {
                        bool isSelected =
                            statusesItem.statuseItme == value.id.toString();

                        return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ExpressButton(
                                style: isSelected
                                    ? ExpressButtonStyle.primary
                                    : ExpressButtonStyle.secondary,
                                child: Text(
                                  isArabic
                                      ? value.titleAr
                                      : value.title.toString(),
                                  style: const TextStyle(fontSize: 16),
                                ),
                                onPressed: () {
                                  setState(() {
                                    statusesItem.statuseItme =
                                        value.id.toString();
                                    statusesItem.isOtp = value.isOtp;
                                    statusesItem.send_image = value.sendImage;
                                    print(statusesItem.isOtp);
                                    print('++++++++++++++++++++++');
                                    print(statusesItem.send_image);
                                  });
                                }));
                      }).toList(),
                    ],
                  ],
                ),
              ),
              if (statusesItem.statuseItme != '18')
                SizedBox(
                  width: 1.sw,
                  child: ExpressButton(
                    child:(state is UpdateOrderLoad)? const CircularProgressIndicator(): Text(
                      context.tr.confirm,
                      style: const TextStyle(fontSize: 16),
                    ),
                    onPressed: () async {
                      if(state is !UpdateOrderLoad){
                        await OrderCubit.get(context).updateOrder(widget.order.id, statusesItem.statuseItme,position!);
                        if (statusesItem.isOtp == 1 || statusesItem.send_image ==1) {
                          showMyBottomSheet(
                            context,
                            OtpConfirm.OtpConfirm(
                                isOtp: statusesItem.isOtp!,
                                orderId: widget.order.orderId,
                                position: position!,
                                send_image: statusesItem.send_image!),
                          );
                          // router.pop();
                          // router.pop();
                        }
                      }
                    },
                  ),
                ),
            ],
          ));
    });
  }
}
