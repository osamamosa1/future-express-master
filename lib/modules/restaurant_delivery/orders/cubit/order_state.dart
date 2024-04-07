// ignore_for_file: must_be_immutable

part of 'order_cubit.dart';

abstract class OrdersRestaurantState extends Equatable {
  const OrdersRestaurantState();

  @override
  List<Object> get props => [];
}

class OrdersRestaurantInitial extends OrdersRestaurantState {}

class SuccessAllOrderState extends OrdersRestaurantState {
  List<Order> Orders;
  SuccessAllOrderState({required this.Orders});
}

class AllOrderLoadFailed extends OrdersRestaurantState {}

class AllOrderLoad extends OrdersRestaurantState {}

class SuccessOrderState extends OrdersRestaurantState {
  OrdersRestaurant Orders;
  SuccessOrderState({required this.Orders});
}

class OrderLoadFailed extends OrdersRestaurantState {}

class OrderLoad extends OrdersRestaurantState {}

class UpdateOrderLoad extends OrdersRestaurantState {}

class UpdateOrderLoaded extends OrdersRestaurantState {}

class UpdateOrderLoadFailed extends OrdersRestaurantState {}

class ConfirmOrderLoad extends OrdersRestaurantState {}

class ConfirmOrderLoadFailed extends OrdersRestaurantState {}

class ConfirmOrderLoaded extends OrdersRestaurantState {}

class SetImageState extends OrdersRestaurantState {}
class SuccessSetImageState extends OrdersRestaurantState {}

class SetAvatarImageState extends OrdersRestaurantState {}
