part of 'auth_cubit.dart';

@immutable
abstract class AuthState {}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthSuccess extends AuthState {}

class AuthFailure extends AuthState {
  final String errMessage;

  AuthFailure(this.errMessage);
}

class SendPasswordResetEmailLoading extends AuthState {}

class SendPasswordResetEmailSuccess extends AuthState {}

class SendPasswordResetEmailFailure extends AuthState {
  final String errMessage;

  SendPasswordResetEmailFailure(this.errMessage);
}
