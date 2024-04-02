// ignore_for_file: must_be_immutable

part of 'home_cubit.dart';

abstract class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object> get props => [];
}

class HomeInitial extends HomeState {}

class StatisticsSuccess extends HomeState {
  Statistics? statistics;
  StatisticsSuccess(this.statistics);
}

class StatisticsLoad extends HomeState {}

class StatisticsLoadFailed extends HomeState {}

class BalanceSuccess extends HomeState {
  List<BalanceEntry>? balance;
  BalanceSuccess(this.balance);
}

class BalanceLoad extends HomeState {}

class BalanceLoadFailed extends HomeState {}

class LoadingStatusesState extends HomeState {}

class GetStatusesItemsState extends HomeState {}
