// ChangeStatesOrder.dart
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:future_express/model/order_rest/order/order.dart';
import 'package:future_express/modules/home/cubit/home_cubit.dart';
import 'package:future_express/modules/restaurant_delivery/current_orders/widget/otpConfirm.dart';
import 'package:future_express/shared/palette.dart';
import 'package:future_express/shared/utils/extension.dart';
import 'package:future_express/shared/widgets/express_button.dart';
import 'package:future_express/shared/widgets/orders_utils.dart';
import 'package:geolocator/geolocator.dart';
import '../../../../shared/network/local/cache_helper.dart';
import '../../../../shared/utils/my_utils.dart';
import '../../../../shared/widgets/Alert_widget.dart';
import '../../orders/cubit/order_cubit.dart';

class ChangeStatesOrder extends StatefulWidget {
  final OrdersRestaurant order;
  final Position position;

  const ChangeStatesOrder({required this.order, super.key, required this.position});

  @override
  State<ChangeStatesOrder> createState() => _ChangeStatesOrderState();
}

class _ChangeStatesOrderState extends State<ChangeStatesOrder> {
  @override
  Widget build(BuildContext context) {
    var statusesItem = HomeCubit.get(context);

    log(statusesItem.statuseItme!.length.toString());
    return BlocBuilder<HomeCubit, HomeState>(builder: (context, state) {
      return Container(
          height: 0.6.sh,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(25)),
          padding: const EdgeInsets.symmetric(horizontal: 35, vertical: 25),
          child: Column(
            children: [
              const SizedBox(
                height: 25,
              ),
              Text(
                context.tr.change_status_order,
                style: const TextStyle(
                  fontSize: 16,
                ),
              ),
              Expanded(
                child: ListView(
                  children: [
                    ...[
                      ...getVisibleStatuses(statusesItem.statusesItems!,
                              CacheHelper.getData(key: 'user') == 2)
                          .map((value) {
                        bool isSelected =
                            statusesItem.statuseItme == value.id.toString();

                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TextButton(
                                child: Text(
                                  Localizations.localeOf(context)
                                              .languageCode ==
                                          'ar'
                                      ? value.titleAr.toString()
                                      : value.title.toString(),
                                  style: TextStyle(
                                      fontSize: 12,
                                      color: isSelected
                                          ? Palette.primaryColor
                                          : Palette.greyColor),
                                ),
                                onPressed: () {
                                  setState(() {
                                    statusesItem.statuseItme =
                                        value.id.toString();
                                    statusesItem.isOtp = value.isOtp;
                                    statusesItem.send_image = value.sendImage;
                                  });
                                }),
                            const Divider()
                          ],
                        );
                      }).toList(),
                    ],
                  ],
                ),
              ),
              SizedBox(
                width: 1.sw,
                child: ExpressButton(
                  child: Text(
                    context.tr.confirm,
                    style: const TextStyle(fontSize: 16),
                  ),
                  onPressed: () async {
                    print(statusesItem.isOtp);
                    await showDialog(
                      context: context,
                      builder: (_) => AlertClasses.ConfirmOrdersDialog(
                        context,
                        OrdersRestaurantCubit.get(context).updateOrder(
                            widget.order.id,
                            statusesItem.statuseItme,
                            context,
                            false),
                      ),
                    );
                    BlocProvider.of<OrdersRestaurantCubit>(context)
                        .getOrder(widget.order.orderId);

                    if (statusesItem.isOtp == 1 || statusesItem.send_image == 1) {
                      showMyBottomSheet(
                        context,
                        OtpConfirm.OtpConfirm(
                            isOtp: statusesItem.isOtp!,
                            orderId: widget.order.orderId,
                            position: widget.position,
                            send_image: statusesItem.send_image!),
                      );
                    }
                  },
                ),
              ),
              const SizedBox(height: 25)
            ],
          ));
    });
  }
}
