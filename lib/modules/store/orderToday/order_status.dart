import 'package:buttons_tabbar/buttons_tabbar.dart';
import 'package:flutter/material.dart';
import 'package:future_express/modules/restaurant_delivery/orders/widgets/order_card.dart';
import 'package:future_express/shared/palette.dart';
import 'package:future_express/shared/widgets/order_empty.dart';

import '../../../model/order.dart';
import '../../../model/order_status.dart';
import '../../../shared/network/local/cache_helper.dart';
import '../../home/cubit/home_cubit.dart';

class OrdersStatusScreen extends StatefulWidget {
  final List<Order> orders;

  const OrdersStatusScreen({super.key, required this.orders});

  @override
  _OrdersStatusScreenState createState() => _OrdersStatusScreenState();
}

class _OrdersStatusScreenState extends State<OrdersStatusScreen> {
  // قائمة لتخزين حالات الطلب
  List<OrderStatus> statuses = [];
  // متغير لتحديد ما إذا كان المستخدم هو مطعم أم لا
  bool isUser2 = false;
  // متغير لتحديد لغة التطبيق
  bool isArabic = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // تحديث حالات الطلب والمتغيرات المرتبطة بالمستخدم ولغة التطبيق عند تغيير الاعتماديات
    statuses = HomeCubit.get(context).statusesItems!;
    isUser2 = CacheHelper.getData(key: 'user') == 2;
    isArabic = Localizations.localeOf(context).languageCode == 'ar';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DefaultTabController(
        length: _visibleStatuses().length,
        child: Column(
          children: <Widget>[
            // بناء شريط التبويب باستخدام الحالات المرئية
            _buildButtonsTabBar(),
            // بناء عرض الطلبات باستخدام الحالات المرئية
            Expanded(
              child: TabBarView(
                children: _visibleStatuses()
                    .map((status) => _buildOrderListByStatus(status.title))
                    .toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // تحديد الحالات المرئية بناءً على معيار الظهور
  List<OrderStatus> _visibleStatuses() {
    return statuses.where((status) {
      if (!isUser2) {
        return status.storeAppear == 1;
      } else {
        return status.restaurantAppear == 1;
      }
    }).toList();
  }

  // بناء شريط التبويب باستخدام الحالات المرئية
  Widget _buildButtonsTabBar() {
    return ButtonsTabBar(
      backgroundColor: Palette.primaryColor,
      borderWidth: 1,
      buttonMargin: const EdgeInsets.all(6),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16),
      radius: 15,
      unselectedBorderColor: Palette.primaryColor,
      unselectedBackgroundColor: Palette.whiteColor,
      borderColor: Palette.primaryColor,
      labelStyle: const TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.bold,
      ),
      unselectedLabelStyle: const TextStyle(
        color: Colors.black,
        fontWeight: FontWeight.bold,
      ),
      tabs: _visibleStatuses().map((status) {
        String title = isArabic ? status.titleAr : status.title;
        int count = widget.orders
            .where((order) => order.orderStatus == status.title)
            .length;
        return Tab(
          text: '$title ($count)',
        );
      }).toList(),
    );
  }

  // بناء عرض الطلبات باستخدام حالة محددة
  Widget _buildOrderListByStatus(String statusId) {
    List<Order> orders =
        widget.orders.where((order) => order.orderStatus == statusId).toList();

    return orders.isNotEmpty
        ? ListView.builder(
            itemCount: orders.length,
            itemBuilder: (context, index) {
              return OrderCard(order: orders[index]);
            },
          )
        : const OrderEmpty();
  }
}
