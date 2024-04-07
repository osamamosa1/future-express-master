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
  final Position position;

  const ChangeStatesOrder({required this.order, super.key, required this.position});

  @override
  State<ChangeStatesOrder> createState() => _ChangeStatesOrderState();
}

class _ChangeStatesOrderState extends State<ChangeStatesOrder> {
  // Position? position;

  // getLocation() async {
  //   position = await Geolocator.getCurrentPosition();
  // }

  @override
  void initState() {
    // getLocation();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    bool isArabic = Localizations.localeOf(context).languageCode == 'ar';
    bool isLoading = false;
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
                                });
                              }));
                    }).toList(),
                  ],
                ],
              ),
            ),
            if (statusesItem.statuseItme != '18')
              BlocConsumer<OrderCubit, OrderState>(listener: (context, state) {
                if (state is UpdateOrderLoad) {
                  isLoading = true;
                } else {
                  isLoading = false;
                }
              },
                  builder: (context, state) {
                if (state is! UpdateOrderLoad) {
                  return SizedBox(
                    width: 1.sw,
                    child: ExpressButton(
                      child: (isLoading)
                          ? const CircularProgressIndicator()
                          : Text(
                              context.tr.confirm,
                              style: const TextStyle(fontSize: 16),
                            ),
                      onPressed: () async {
                        if (!isLoading) {
                          await OrderCubit.get(context).updateOrder(
                              widget.order.id,
                              statusesItem.statuseItme,widget.position);
                          if (statusesItem.isOtp == 1 ||
                              statusesItem.send_image == 1) {
                            showMyBottomSheet(
                              context,
                              OtpConfirm.OtpConfirm(
                                  isOtp: statusesItem.isOtp!,
                                  orderId: widget.order.orderId,
                                  send_image: statusesItem.send_image!),
                            );
                          }else{
                            Navigator.pop(context);

                          }
                        }
                      },
                    ),
                  );
                } else {
                  return CircularProgressIndicator();
                }
              })
          ],
        ));
  }
}
