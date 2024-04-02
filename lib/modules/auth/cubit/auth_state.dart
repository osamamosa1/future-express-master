part of 'auth_cubit.dart';

abstract class AuthState extends Equatable {}

class AuthLoading extends AuthState {
  @override
  List<Object?> get props => [];
}

class AuthLoadFailed extends AuthState {
  @override
  List<Object?> get props => [];
}

class ForgetPasswordLoadFailed extends AuthState {
  @override
  List<Object?> get props => [];
}

class SuccessResetPasswordState extends AuthState {
  @override
  List<Object?> get props => [];
}

class ResetPasswordLoadFailed extends AuthState {
  @override
  List<Object?> get props => [];
}

class AuthSignedOut extends AuthState {
  final String phone;
  final String otp;

  AuthSignedOut({
    this.phone = '',
    this.otp = '',
  });

  @override
  List<Object?> get props => [phone, otp];
}

class AuthSignedIn extends AuthState {
  @override
  List<Object?> get props => [];
}

class AuthSuccess extends AuthState {
  final User? user;

  AuthSuccess({this.user});

  @override
  List<Object?> get props => [user];
}

class ChangePasswordVisibilityStates extends AuthState {
  @override
  List<Object?> get props => [];
}

class LodingRequestJoin extends AuthState {
  @override
  List<Object?> get props => [];
}

class SuccessRequestJoin extends AuthState {
  @override
  List<Object?> get props => [];
}

class RequestJoinFailed extends AuthState {
  @override
  List<Object?> get props => [];
}

class SetImageState extends AuthState {
  @override
  List<Object?> get props => [];
}

class LoadingCiteState extends AuthState {
  @override
  List<Object?> get props => [];
}

class GetCiteItemsState extends AuthState {
  @override
  List<Object?> get props => [];
}

class SetAvatarImageState extends AuthState {
  @override
  List<Object?> get props => [];
}

class SetFrontPhotoImageState extends AuthState {
  @override
  List<Object?> get props => [];
}

class SetFormImageImageState extends AuthState {
  @override
  List<Object?> get props => [];
}
