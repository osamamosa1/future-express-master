class Statistics {
  final int ordersShipToday;
  final int allMyOrders;
  final double balanceAccount;

  Statistics({
    required this.ordersShipToday,
    required this.allMyOrders,
    required this.balanceAccount,
  });

  factory Statistics.fromJson(Map<String, dynamic> json) {
    return Statistics(
      ordersShipToday: json['OrdersShipToday'],
      allMyOrders: json['AllMyOrders'],
      balanceAccount: double.parse(json['BalanceAccount'] ?? '0'),
    );
  }
}
