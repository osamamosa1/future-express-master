import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:future_express/model/order_rest/order/order.dart';
import 'package:future_express/modules/restaurant_delivery/orders/cubit/order_cubit.dart';
import 'package:future_express/shared/palette.dart';
import 'package:future_express/shared/utils/extension.dart';
import 'package:future_express/shared/utils/my_utils.dart';
import 'package:future_express/shared/widgets/express_button.dart';
import 'package:url_launcher/url_launcher.dart';

class HederCurrentOder extends StatelessWidget {
  const HederCurrentOder({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OrdersRestaurantCubit, OrdersRestaurantState>(
      buildWhen: (previous, current) =>
          previous != current && current is SuccessOrderState,
      builder: (context, state) {
        if (state is SuccessOrderState) {
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                        onPressed: () {
                          showContant(context, state.Orders);
                        },
                        icon: const Icon(
                          FontAwesomeIcons.phone,
                          color: Palette.primaryColor,
                        )),
                    SizedBox(width: 0.22.sw),
                    Text(context.tr.current_orders,
                        style: const TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.bold)),
                    const Spacer(),
                  ],
                ),
                SvgPicture.asset(
                  'assets/images/reject.svg',
                  height: 150.h,
                ),
                Text(state.Orders.clientName),
                Text('${state.Orders.clientPhone}+',
                    style: const TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold)),
              ],
            ),
          );
        }

        return const SizedBox();
      },
    );
  }

  void showContant(BuildContext context, OrdersRestaurant order) {
    return showMyBottomSheet(
        context,
        SizedBox(
          height: 250,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 25,
                ),
                const Text('التواصل عن طريق',
                    style: TextStyle(fontWeight: FontWeight.w600),
                    textAlign: TextAlign.center),
                const SizedBox(
                  height: 25,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ExpressButton(
                      onPressed: () => unawaited(launchUrl(
                        Uri.parse(
                            'https://wa.me/+${order.clientPhone}?text=${Localizations.localeOf(context).languageCode == 'ar' ? order.whatUpMassageAr : order.whatUpMassage}'),
                      )),
                      style: ExpressButtonStyle.secondary,
                      child: Row(
                        children: [
                          Image.asset(
                            'assets/images/whatsapp.png',
                            width: 35,
                            height: 35,
                          ),
                          const SizedBox(
                            width: 25,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'What’s App',
                                textAlign: TextAlign.center,
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(height: 5),
                              Text(
                                '${order.clientPhone}+',
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    ExpressButton(
                      onPressed: () => unawaited(launchUrl(
                        Uri.parse('tel:+${order.clientPhone}'),
                      )),
                      style: ExpressButtonStyle.secondary,
                      child: Row(
                        children: [
                          const Icon(
                            FontAwesomeIcons.phone,
                            color: Palette.primaryColor,
                          ),
                          const SizedBox(
                            width: 30,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'هاتفيا',
                                textAlign: TextAlign.center,
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(height: 5),
                              Text(
                                '${order.clientPhone}+',
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ));
  }
}
