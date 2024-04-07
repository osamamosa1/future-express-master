import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:future_express/modules/home/cubit/home_cubit.dart';
import 'package:future_express/modules/notification/cubit/notification_cubit.dart';
import 'package:future_express/shared/router.dart';
import 'package:future_express/shared/utils/extension.dart';
import 'package:future_express/shared/widgets/express_app_bar.dart';

import '../../../shared/network/local/cache_helper.dart';

import '../widgets/home_screen_button.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    unawaited((HomeCubit.get(context).init()));


    super.initState();
    unawaited(NotificationCubit.get(context).fetchNotification());
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return BlocBuilder<HomeCubit, HomeState>(
        buildWhen: (previous, current) =>
            previous != current && current is StatisticsSuccess,
        builder: (context, state) {
          if (state is StatisticsSuccess) {
            return Scaffold(
                appBar: ExpressAppBar(
                  myTitle: context.tr.home,
                ),
                body: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const SizedBox(height: 20),
                      SizedBox(
                        height: size.height * 0.11,
                        child: HomeScreenButton(
                          title: 'SCAN QR',
                          onPressed: () {
                            unawaited(router.push('/PickUp'));
                          },
                          style: HomeButtonStyle.secondary,
                        ),
                      ),
                      const SizedBox(height: 15),
                      SizedBox(
                        height: size.height * 0.11,
                        child: HomeScreenButton(
                          title: context.tr.orders_today,
                          subTitle:
                              '${state.statistics!.ordersShipToday} ${context.tr.order}',
                          onPressed: () => router.push('/allOrder'),
                          style: HomeButtonStyle.primary,
                        ),
                      ),
                      const SizedBox(height: 15),
                      SizedBox(
                        height: size.height * 0.11,
                        child: HomeScreenButton(
                          title: context.tr.all_orders,
                          onPressed: () => unawaited(router.push(
                            '/allOrder',
                          )),
                          subTitle:
                              '${state.statistics!.allMyOrders} ${context.tr.order}',
                          style: HomeButtonStyle.primary,
                        ),
                      ),
                      const SizedBox(height: 15),
                      SizedBox(
                        height: size.height * 0.11,
                        child: HomeScreenButton(
                          title: context.tr.wallet,
                          subTitle:
                              '${context.tr.sar}  ${state.statistics!.balanceAccount} ',
                          style: HomeButtonStyle.primary,
                          onPressed: () => unawaited(router.push(
                            '/MyWallet',
                          )),
                        ),
                      ),
                      const SizedBox(height: 15),
                      if (CacheHelper.getData(key: 'userReport') == 1)
                        SizedBox(
                          height: size.height * 0.11,
                          child: HomeScreenButton(
                            title: context.tr.today_report,
                            style: HomeButtonStyle.primary,
                            onPressed: () => unawaited(router.push(
                              '/ReportScreen',
                            )),
                          ),
                        ),
                    ],
                  ),
                ));
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        });
  }
}
