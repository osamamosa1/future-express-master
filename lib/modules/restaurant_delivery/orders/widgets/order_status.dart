import 'package:buttons_tabbar/buttons_tabbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:future_express/model/order_status.dart';
import 'package:future_express/modules/restaurant_delivery/orders/widgets/order_card.dart';
import 'package:future_express/modules/store/orders/cubit/order_cubit.dart';
import 'package:future_express/shared/network/local/cache_helper.dart';
import 'package:future_express/shared/palette.dart';
import 'package:future_express/shared/widgets/order_empty.dart';

import '../../../../model/order.dart';
import '../../../home/cubit/home_cubit.dart';

class OrdersStatusScreen extends StatefulWidget {
  final List<Order> orders;

  const OrdersStatusScreen({super.key, required this.orders});

  @override
  _OrdersStatusScreenState createState() => _OrdersStatusScreenState();
}

class _OrdersStatusScreenState extends State<OrdersStatusScreen> {
  ScrollController scrollController =ScrollController();
  // قائمة لتخزين حالات الطلب
  List<OrderStatus> statuses = [];
  List<Order> allOrders = [];
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
  void initState() {
    allOrders= widget.orders;
  scrollController.addListener(() async{
    String? nextLink=context.read<OrderCubit>().nextAll;
    bool? loading=context.read<OrderCubit>().loading;
    if(scrollController.position.pixels >=scrollController.position.maxScrollExtent*0.7){
      if(nextLink!=null && loading==false){
        await context.read<OrderCubit>().getallOrder();
         allOrders.addAll(context.read<OrderCubit>().allOrder!);
      }
    }
  });

  super.initState();
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
        int count = allOrders
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
        allOrders.where((order) => order.orderStatus == statusId).toList();

    return orders.isNotEmpty
        ? ListView.builder(
      controller: scrollController,
      itemCount: orders.length,
            itemBuilder: (context, index) {
              return OrderCard(order: orders[index]);
            },
          )
        : const OrderEmpty();
  }
}
