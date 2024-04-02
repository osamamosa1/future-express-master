import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:future_express/modules/restaurant_delivery/orders/cubit/order_cubit.dart';
import 'package:future_express/shared/palette.dart';
import 'package:future_express/shared/widgets/order_empty.dart';

import '../../../home/cubit/home_cubit.dart';

class SliderCurrentOrder extends StatelessWidget {
  const SliderCurrentOrder({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OrdersRestaurantCubit, OrdersRestaurantState>(
        buildWhen: (previous, current) =>
            previous != current && current is SuccessAllOrderState,
        builder: (context, state) {
          if (state is SuccessAllOrderState) {
            if (state.Orders.isNotEmpty) {
              OrdersRestaurantCubit.get(context)
                  .getOrder(state.Orders.first.orderId);
            }
            return state.Orders.isNotEmpty
                ? CarouselSlider.builder(
                    itemCount: state.Orders.length,
                    itemBuilder: (context, index, realIndex) {
                      return Container(
                        width: 0.85.sw,
                        decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.circular(25)),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.network(
                              'https://www.future-ex.com/public/storage/${state.Orders[index].storeImage}',
                              height: 190.h,
                              width: 340.w,
                              errorBuilder: (context, error, stackTrace) =>
                                  SvgPicture.asset(
                                'assets/images/reject.svg',
                                height: 150.h,
                              ),
                            ),
                            SizedBox(
                              height: 15.h,
                            ),
                            Text(
                              'No: ${state.Orders[index].orderId}',
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              height: 35.h,
                            ),
                            Text(
                              '${state.Orders[index].amount} ريال سعودى ',
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              height: 10.h,
                            ),
                            const Text(
                              'كاش',
                              style: TextStyle(
                                  color: Palette.primaryColor,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      );
                    },
                    options: CarouselOptions(
                      height: 445.h,
                      viewportFraction: 0.82,
                      initialPage: 0,
                      enableInfiniteScroll: true,
                      reverse: false,
                      autoPlay: false,
                      autoPlayCurve: Curves.fastOutSlowIn,
                      enlargeCenterPage: true,
                      enlargeFactor: 0.3,
                      onPageChanged: (index, reason) {
                        OrdersRestaurantCubit.get(context)
                            .getOrder(state.Orders[index].orderId);
                        HomeCubit.get(context).statuseItme = '0';
                        HomeCubit.get(context).isOtp = 0;
                      },
                      scrollDirection: Axis.horizontal,
                    ))
                : const OrderEmpty();
          }

          return const SizedBox();
        });
  }
}
