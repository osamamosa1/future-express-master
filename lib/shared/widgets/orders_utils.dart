// orders_utils.dart
import 'package:future_express/model/order_status.dart';

// تحديد الحالات المرئية بناءً على معيار الظهور
List<OrderStatus> getVisibleStatuses(List<OrderStatus> statuses, bool isUser2) {
  return statuses.where((status) {
    if (isUser2) {
      return status.storeAppear == 1;
    } else {
      return status.restaurantAppear == 1;
    }
  }).toList();
}
