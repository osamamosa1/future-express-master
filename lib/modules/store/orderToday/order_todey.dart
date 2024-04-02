import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:future_express/modules/store/orderToday/order_status.dart';

import 'package:future_express/modules/store/orders/cubit/order_cubit.dart';
import 'package:future_express/shared/router.dart';
import 'package:future_express/shared/utils/extension.dart';
import 'package:future_express/shared/widgets/express_app_bar.dart';
import 'package:get/get.dart';

class OrdersTodayScreen extends StatelessWidget {
  const OrdersTodayScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: ExpressAppBar(
          myTitle: context.tr.orders_today,
          widget: IconButton(
              onPressed: () => router.go('/homeLayOut'),
              icon: const Icon(
                Icons.arrow_back,
                color: Colors.black,
              )),
        ),
        body: Column(
          children: [
            SizedBox(
              height: 0.8.sh,
              child: BlocBuilder<OrderCubit, OrderState>(
                  bloc: OrderCubit.get(context)..getOrderToday(),
                  builder: (context, state) {
                    if (state is SuccessOrderState) {
                      return OrdersStatusScreen(
                        orders: state.orders,
                      );
                    }
                    return const Center(child: CircularProgressIndicator());
                  }),
            ),
            if (OrderCubit.get(context).last_page > 1)
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                for (int i = 0; i < OrderCubit.get(context).last_page; i++)
                  ElevatedButton(
                    onPressed: () {
                      OrderCubit.get(context).currentPage =
                          i; // زيادة رقم الصفحة لتحميل البيانات التالية
                      OrderCubit.get(context).getOrderToday(currentPage: i + 1);
                    },
                    child: Text('${i + 1}'.toString()),
                  ).paddingOnly(left: 2, right: 2)
              ]),
          ],
        ));
  }
}
