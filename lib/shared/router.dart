import 'package:future_express/layouts/home_layout.dart';
import 'package:future_express/model/order.dart';
import 'package:future_express/modules/auth/screens/JoinServiceProvider/screen/join_service_provider.dart';
import 'package:future_express/modules/store/orderToday/order_todey.dart';
import 'package:future_express/modules/store/orders/screens/orderDetails-screen.dart';
import 'package:future_express/modules/store/orders/screens/orders_screen.dart';
import 'package:future_express/modules/store/pickUp/pick_up_screen_screen.dart';
import 'package:future_express/modules/store/pickUp/scan_order_screen.dart';
import 'package:future_express/modules/type/screens/login_type_screen.dart';
import 'package:go_router/go_router.dart';

import '../modules/auth/screens/login_screen.dart';
import '../modules/home/screens/home_screen.dart';

import '../modules/report/screen/report_screen.dart';
import '../modules/type_screen/type_screen.dart';
import '../modules/wallet/screens/my_wallet_screen.dart';
import 'utils/back_botton.dart';
import 'widgets/loding.dart';

final router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const LoginScreen(),
    ),
    GoRoute(
      path: '/home',
      builder: (context, state) => const HomeScreen(),
    ),
    GoRoute(
      path: '/loginTypeScreen',
      builder: (context, state) {
        var extra = state.extra;
        return LoginTypeScreen(types: extra as List<int>);
      },
    ),
    GoRoute(
      path: '/myLoadingPage',
      builder: (context, state) => const MyLoadingPage(),
    ),
    GoRoute(
      path: '/homeLayOut',
      builder: (context, state) => const HomeLayout(),
    ),
    GoRoute(
      path: '/PickUp',
      builder: (context, state) => const PickUpScreenScreen(),
    ),
    GoRoute(
      path: '/orderScaned',
      builder: (context, state) =>
          const BackButtonHandler(child: ScanOrdersScreen()),
    ),
    GoRoute(
      path: '/orderToday',
      builder: (context, state) =>
          const BackButtonHandler(child: OrdersTodayScreen()),
    ),
    GoRoute(
      path: '/allOrder',
      builder: (context, state) =>
          const BackButtonHandler(child: OrdersScreen()),
    ),
    GoRoute(
      path: '/MyWallet',
      builder: (context, state) =>
          const BackButtonHandler(child: MyWalletScreen()),
    ),
    GoRoute(
      path: '/ReportScreen',
      builder: (context, state) =>
          const BackButtonHandler(child: ReportScreen()),
    ),
    GoRoute(
      path: '/JoinServiceProviderScreen',
      builder: (context, state) =>
          const BackButtonHandler(child: JoinServiceProviderScreen()),
    ),
    GoRoute(
      path: '/orderDetails',
      builder: (context, state) => BackButtonHandler(
          child: OrderDetailsScreen(order: state.extra! as Order)),
    ),
    GoRoute(
        path: '/typeScreen', builder: (context, state) => const TypeScreen()),
  ],
);
