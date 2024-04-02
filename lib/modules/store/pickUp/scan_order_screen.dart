import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:future_express/model/scan_order_model.dart';
import 'package:future_express/modules/store/pickUp/widget/change_states_pickup.dart';
import 'package:future_express/shared/palette.dart';
import 'package:future_express/shared/router.dart';
import 'package:future_express/shared/utils/back_botton.dart';
import 'package:future_express/shared/utils/extension.dart';
import 'package:future_express/shared/utils/my_utils.dart';
import 'package:future_express/shared/widgets/Alert_widget.dart';
import 'package:future_express/shared/widgets/express_app_bar.dart';
import 'package:future_express/shared/widgets/express_button.dart';
import 'package:future_express/shared/widgets/express_card.dart';
import 'package:future_express/shared/widgets/order_empty.dart';

import 'cubit/pickup_cubit.dart';

class ScanOrdersScreen extends StatelessWidget {
  const ScanOrdersScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PickupCubit, PickupState>(
      listener: (context, state) {
        if (state is SetOrderChange) {
          unawaited(PickupCubit.get(context).setPickUp());
        }
      },
      builder: (context, state) {
        return BackButtonHandler(
          onWillPop: () => router.go('/homeLayOut'),
          child: Scaffold(
              appBar: ExpressAppBar(
                myTitle: 'Order scaned',
                widget: IconButton(
                    onPressed: () => router.go('/homeLayOut'),
                    icon: const Icon(
                      Icons.arrow_back,
                      color: Colors.black,
                    )),
              ),
              body: BlocBuilder<PickupCubit, PickupState>(
                  builder: (context, state) {
                List<ScanOrder> scanOrders = [];

                if (state is SuccessScanOrderState) {
                  scanOrders = state.scanOrders;
                }

                return Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.h, vertical: 20),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 110.h,
                        child: ExpressButton(
                          onPressed: () => router.go('/PickUp'),
                          style: ExpressButtonStyle.primary,
                          child: Center(
                            child: Text(context.tr.scan_new_barcode,
                                style: const TextStyle(fontSize: 18)),
                          ),
                        ),
                      ),
                      Expanded(
                        child: ListView(
                          children: [
                            if (scanOrders.isNotEmpty) ...[
                              ...scanOrders.map((e) => OrderCard(e, context)),
                            ],
                            if (scanOrders.isEmpty) const OrderEmpty(),
                            SizedBox(
                              height: 15.h,
                            ),
                            SizedBox(
                              height: 15.h,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: 1.sw,
                        child: ExpressButton(
                          onPressed: () async => showMyBottomSheet(
                              context, const ChangeStatePickup()),
                          style: ExpressButtonStyle.primary,
                          child: Text(context.tr.received_orders),
                        ),
                      ),
                    ],
                  ),
                );
              })),
        );
      },
    );
  }

  Widget OrderCard(ScanOrder order, context) {
    log(order.storeImage);
    return BlocBuilder<PickupCubit, PickupState>(builder: (context, state) {
      return Container(
        margin: const EdgeInsets.all(8.0),
        child: ExpressCard(
          padding: const EdgeInsets.only(
            top: 18,
            right: 12,
            left: 12,
            bottom: 8,
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                          width: 0.14.sw,
                          height: 130,
                          child: Image.network(
                            order.storeImage,
                            fit: BoxFit.fitWidth,
                            errorBuilder: (context, error, stackTrace) =>
                                Image.asset('assets/images/logo_splash.png'),
                          )),
                      Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              order.clientName,
                              style: TextStyle(
                                  color: Palette.blackColor,
                                  fontSize: 22.sp,
                                  fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Row(
                              children: [
                                const Padding(
                                  padding: EdgeInsets.all(5.0),
                                  child: CircleAvatar(
                                    radius: 5.0,
                                    backgroundColor: Palette.greyColor,
                                  ),
                                ),
                                Text(
                                  order.clientCity,
                                  style: TextStyle(
                                      color: Palette.greyColor,
                                      fontSize: 24.sp),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Wrap(
                              crossAxisAlignment: WrapCrossAlignment.center,
                              children: [
                                const Padding(
                                  padding: EdgeInsets.all(5.0),
                                  child: CircleAvatar(
                                    radius: 5.0,
                                    backgroundColor: Palette.primaryColor,
                                  ),
                                ),
                                SizedBox(
                                  width: 0.4.sw,
                                  child: Text(
                                    order.clientAddress,
                                    style: TextStyle(
                                        color: Palette.greyColor,
                                        fontSize: 22.sp),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Wrap(
                              crossAxisAlignment: WrapCrossAlignment.center,
                              children: [
                                const Padding(
                                  padding: EdgeInsets.all(5.0),
                                  child: CircleAvatar(
                                    radius: 5.0,
                                    backgroundColor: Palette.primaryColor,
                                  ),
                                ),
                                Text(
                                  order.orderStatusAr,
                                  style: TextStyle(
                                      color: Palette.primaryColor,
                                      fontSize: 24.sp),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Text(
                              '${order.store} ',
                              style: const TextStyle(
                                  color: Palette.greyColor, fontSize: 16),
                            ),
                          ],
                        ),
                      ),
                      Text(
                        '${order.amount} ر.س',
                        style: TextStyle(
                            color: Palette.primaryColor,
                            fontSize: 22.sp,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ],
              ),
              const Divider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SvgPicture.asset('assets/icons/order.svg', height: 30),
                  SizedBox(
                    width: 25.w,
                  ),
                  Text(
                    '${order.orderId} # ',
                    style: const TextStyle(
                        color: Palette.primaryColor,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                  const Spacer(),
                  IconButton(
                      onPressed: () {
                        showDialog(
                            context: context,
                            builder: (_) => AlertClasses.DelateOrdersDialog(
                                    context, () async {
                                  await PickupCubit.get(context)
                                      .removeOrder(order);
                                }));
                      },
                      icon: const Icon(
                        FontAwesomeIcons.trash,
                        color: Palette.primaryColor,
                      ))
                ],
              )
            ],
          ),
        ),
      );
    });
  }
}
