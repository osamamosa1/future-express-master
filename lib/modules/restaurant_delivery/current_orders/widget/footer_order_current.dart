import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:future_express/modules/restaurant_delivery/orders/cubit/order_cubit.dart';
import 'package:future_express/modules/restaurant_delivery/current_orders/widget/change_states_order.dart';
import 'package:future_express/shared/palette.dart';
import 'package:future_express/shared/utils/extension.dart';
import 'package:future_express/shared/widgets/Alert_widget.dart';
import 'package:geolocator/geolocator.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../shared/utils/my_utils.dart';

class FooterOrderCurrent extends StatelessWidget {
   const FooterOrderCurrent( {super.key, required this.position});
  final Position? position;
  @override
  Widget build(BuildContext context) {
    String orderId = '';
    return BlocConsumer<OrdersRestaurantCubit, OrdersRestaurantState>(
      buildWhen: (previous, current) =>
          previous != current && current is SuccessOrderState,
      builder: (context, state) {
        if (state is SuccessOrderState) {
          orderId = state.Orders.orderId;
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                SizedBox(
                  width: 1.sw,
                  child: Text(
                    context.tr.delivery_Address,
                    style: const TextStyle(
                        color: Palette.blackColor,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                    textAlign: TextAlign.start,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      child: Text(
                        ' ${state.Orders.addressDetails}- ${state.Orders.clientRegion} -${state.Orders.clientCity} ',
                        style: const TextStyle(
                            color: Palette.greyColor,
                            fontSize: 12,
                            fontWeight: FontWeight.bold),
                        textAlign: TextAlign.start,
                      ),
                    ),
                    TextButton(
                      child: Row(
                        children: [
                          Text(
                            context.tr.show_on_the_map,
                            style: const TextStyle(
                              color: Palette.primaryColor,
                              fontSize: 14,
                            ),
                          ),
                          const SizedBox(width: 5),
                          CircleAvatar(
                            maxRadius: 12,
                            backgroundColor: Palette.primaryColor,
                            child: SvgPicture.asset(
                              'assets/images/direction.svg',
                            ),
                          ),
                        ],
                      ),
                      onPressed: () => unawaited(launchUrl(Uri.parse(
                          'https://www.google.com/maps/dir//${state.Orders.storeLatitude},${state.Orders.storeLongitude}/@${state.Orders.storeLatitude},${state.Orders.storeLongitude},17z?entry=ttu'))),
                    )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                        child: Text(
                          context.tr.change_status_order,
                          style: const TextStyle(
                            color: Palette.primaryColor,
                            fontSize: 14,
                          ),
                        ),
                        onPressed: () {
                          showMyBottomSheet(
                            context,
                            ChangeStatesOrder(order: state.Orders,position: position!,),
                          );
                        }),
                    SizedBox(
                      width: 25.w,
                    ),
                    TextButton(
                        child: const Text(
                          'اظهار الفاتورة للطلب',
                          style: TextStyle(
                            color: Palette.primaryColor,
                            fontSize: 14,
                          ),
                        ),
                        onPressed: () => unawaited(
                            AlertClasses.showInvoice(context, state.Orders)))
                  ],
                ),
                Text(
                  Localizations.localeOf(context).languageCode == 'ar'
                      ? state.Orders.orderStatusAr.toString()
                      : state.Orders.orderStatus.toString(),
                  style: const TextStyle(
                    color: Palette.primaryColor,
                    fontSize: 18,
                  ),
                ),
              ],
            ),
          );
        }

        return const SizedBox();
      },
      listener: (BuildContext context, OrdersRestaurantState state) {
        if (OrdersRestaurantCubit.get(context).isConfirm) {
          OrdersRestaurantCubit.get(context).getOrder(orderId);
        }
      },
    );
  }
}
