part of 'profie_cubit.dart';

abstract class ProfieState extends Equatable {
  const ProfieState();

  @override
  List<Object> get props => [];
}

class ProfieInitial extends ProfieState {}
class SetAvatarImageState extends ProfieState {}
class SetImageState extends ProfieState {}
class StateGetProfileLoded extends ProfieState {}
class StateGetProfileError extends ProfieState {}
class   StateGetProfileLoading extends ProfieState {}
class StateGetProfileSuccess extends ProfieState {

  final User profileModel;
  const StateGetProfileSuccess({required this.profileModel});

}

class ProfileUpdateLodingState extends ProfieState{}
class ProfileUpdateSuccessState extends ProfieState{}
class ProfileUpdateErrorState extends ProfieState{}
