// ignore_for_file: must_be_immutable

part of 'order_cubit.dart';

abstract class OrderState extends Equatable {
  const OrderState();

  @override
  List<Object> get props => [];
}

class OrderInitial extends OrderState {}

class SuccessOrderState extends OrderState {
  List<Order> orders;

  SuccessOrderState({required this.orders});

  SuccessOrderState copyWith({List<Order>? newOrders}) {
    return SuccessOrderState(orders: newOrders ?? orders);
  }
}

class OrderLoadFailed extends OrderState {}

class OrderLoad extends OrderState {}

class SuccessOrderDetailsState extends OrderState {
  OrderDetails Orders;
  SuccessOrderDetailsState({required this.Orders});
}

class OrderDetailsLoadFailed extends OrderState {}

class OrderDetailsLoad extends OrderState {}

class SuccessAllOrderState extends OrderState {
  List<Order> Orders;
  SuccessAllOrderState({required this.Orders});
}

class AllOrderLoadFailed extends OrderState {}

class AllOrderLoad extends OrderState {}

class UpdateOrderLoadFailed extends OrderState {}

class UpdateOrderLoad extends OrderState {}
class SuccessUpdateOrder extends OrderState {}
