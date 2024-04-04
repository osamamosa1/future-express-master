import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:future_express/modules/home/cubit/home_cubit.dart';
import 'package:future_express/modules/restaurant_delivery/orders/widgets/order_status.dart';
import 'package:future_express/shared/utils/extension.dart';
import 'package:future_express/shared/widgets/express_app_bar.dart';

import '../../../../shared/palette.dart';
import '../../../../shared/router.dart';
import '../../../../shared/utils/back_botton.dart';

import '../cubit/order_cubit.dart';

class OrdersRestaurant extends StatelessWidget {
  const OrdersRestaurant({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BackButtonHandler(
      child: Scaffold(
          appBar: ExpressAppBar(
            myTitle: '${context.tr.home} ',
            widget: IconButton(
              onPressed: () => router.pop(),
              icon: const Icon(Icons.arrow_back_ios, color: Palette.greyColor),
            ),
          ),
          body: BlocProvider(
              create: (context) => OrdersRestaurantCubit()..getOrderById(context.read<HomeCubit>().statusesItems![0].id),
              child: BlocBuilder<OrdersRestaurantCubit, OrdersRestaurantState>(
                  builder: (context, state) {
                if (state is SuccessAllOrderState) {
                  return OrdersStatusScreen(
                  );
                }

                return const Center(child: CircularProgressIndicator());
              }))),
    );
  }
}
