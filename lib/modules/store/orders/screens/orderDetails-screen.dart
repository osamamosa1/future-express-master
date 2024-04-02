import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:future_express/model/order.dart';
import 'package:future_express/modules/home/cubit/home_cubit.dart';
import 'package:future_express/modules/store/orders/cubit/order_cubit.dart';
import 'package:future_express/modules/store/orders/widgets/card_order_details.dart';
import 'package:future_express/modules/store/orders/widgets/order_details_bady.dart';
import 'package:future_express/shared/palette.dart';
import 'package:future_express/shared/router.dart';
import 'package:future_express/shared/utils/back_botton.dart';
import 'package:future_express/shared/utils/extension.dart';
import 'package:future_express/shared/utils/my_utils.dart';
import 'package:future_express/shared/widgets/express_app_bar.dart';
import 'package:future_express/shared/widgets/express_button.dart';
import 'package:url_launcher/url_launcher.dart';

import '../widgets/change_states_order.dart';

class OrderDetailsScreen extends StatefulWidget {
  final Order order;
  const OrderDetailsScreen({super.key, required this.order});

  @override
  State<OrderDetailsScreen> createState() => _OrderDetailsScreenState();
}

class _OrderDetailsScreenState extends State<OrderDetailsScreen> {
  @override
  void initState() {
    unawaited(HomeCubit.get(context).getStatuses());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final isArabic = Localizations.localeOf(context).languageCode == 'ar';
    return BackButtonHandler(
      child: BlocConsumer<OrderCubit, OrderState>(
          listenWhen: (previous, current) =>
              current is UpdateOrderLoad ||
              current is OrderLoadFailed ||
              current is SuccessOrderState ||
              current is SuccessOrderDetailsState,
          listener: (context, state) {
            if (state is SuccessUpdateOrder) {
              log('success change status');
              OrderCubit.get(context).getallOrder();
              // router.go('/homeLayOut');
            }
          },
          builder: (context, state) => Scaffold(
              appBar: ExpressAppBar(
                myTitle: context.tr.order_details,
                widget: IconButton(
                  onPressed: () => router.pop(),
                  icon: const Icon(Icons.arrow_back_ios,
                      color: Palette.greyColor),
                ),
              ),
              body: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: SingleChildScrollView(
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CardOrderDetails(
                          widget: widget,
                          isArabic: isArabic,
                        ),
                        Column(children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                context.tr.delivery_Address,
                                style: const TextStyle(
                                    color: Palette.blackColor,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold),
                                textAlign: TextAlign.start,
                              ),
                              TextButton(
                                child: Text(
                                  context.tr.show_on_the_map,
                                  style: const TextStyle(
                                    color: Palette.primaryColor,
                                    fontSize: 16,
                                  ),
                                  textAlign: TextAlign.start,
                                ),
                                onPressed: () => unawaited(launchUrl(Uri.parse(
                                    'https://www.google.com/maps/@${widget.order.latitude},${widget.order.longitude},6z'))),
                              )
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          BadyOrderDetails(order: widget.order),
                          const SizedBox(
                            height: 10,
                          ),
                          SizedBox(
                            width: 1.sw,
                            child: ExpressButton(
                              child: Text(
                                context.tr.change_status_order,
                                style: const TextStyle(fontSize: 16),
                              ),
                              onPressed: () => {_showBottomModal()},
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                        ]),
                      ]),
                ),
              ))),
    );
  }

  _showBottomModal() {
    return showMyBottomSheet(context, ChangeStatesOrder(order: widget.order));
  }
}
