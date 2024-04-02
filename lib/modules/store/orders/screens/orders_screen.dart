import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:future_express/model/order.dart';
import 'package:future_express/modules/restaurant_delivery/orders/widgets/order_status.dart';
import 'package:future_express/shared/palette.dart';
import 'package:future_express/shared/router.dart';
import 'package:future_express/shared/utils/back_botton.dart';
import 'package:future_express/shared/utils/extension.dart';
import 'package:future_express/shared/widgets/express_app_bar.dart';

import '../cubit/order_cubit.dart';

class OrdersScreen extends StatefulWidget {
  const OrdersScreen({
    super.key,
  });

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  List<Order>? orders;

  @override
  void initState() {
    super.initState();
    BlocProvider.of<OrderCubit>(context).getallOrder();
    orders = OrderCubit.get(context).order;
  }

  @override
  Widget build(BuildContext context) {
    return BackButtonHandler(
      child: Scaffold(
          appBar: ExpressAppBar(
            myTitle: context.tr.home,
            widget: IconButton(
              onPressed: () => router.pop(),
              icon: const Icon(Icons.arrow_back_ios, color: Palette.greyColor),
            ),
          ),
          body: BlocBuilder<OrderCubit, OrderState>(
              buildWhen: (previous, current) =>
                  current is SuccessAllOrderState ||
                  current is OrderLoadFailed ||
                  current is OrderLoad ||
                  current is SuccessOrderDetailsState ||
                  current is OrderDetailsLoadFailed,
              builder: (context, state) {
                if (state is SuccessAllOrderState) {
                  return OrdersStatusScreen(
                    orders: state.Orders,
                  );
                }
                return const Center(child: CircularProgressIndicator());
              })),
    );
  }
}
