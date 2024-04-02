part of 'pickup_cubit.dart';

abstract class PickupState extends Equatable {
  const PickupState();

  @override
  List<Object> get props => [];
}

class PickupInitial extends PickupState {}

// ignore: must_be_immutable
class SuccessScanOrderState extends PickupState {
  List<ScanOrder> scanOrders;
  SuccessScanOrderState({required this.scanOrders});
}

class ScanOrderLoadFailed extends PickupState {}

class ScanOrderLoad extends PickupState {}
class SetOrderChange extends PickupState {}
