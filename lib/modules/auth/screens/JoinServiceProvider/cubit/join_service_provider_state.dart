part of 'join_service_provider_cubit.dart';

abstract class JoinServiceProviderState extends Equatable {
  const JoinServiceProviderState();

  @override
  List<Object> get props => [];
}

class JoinServiceProviderInitial extends JoinServiceProviderState {}

class LoadingCiteState extends JoinServiceProviderState {}

class GetCiteItemsState extends JoinServiceProviderState {}

class LodingRequestJoin extends JoinServiceProviderState {}

class SuccessRequestJoin extends JoinServiceProviderState {}
