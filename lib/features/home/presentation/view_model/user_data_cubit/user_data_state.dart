part of 'user_data_cubit.dart';

@immutable
abstract class UserDataState {}

class UserDataInitial extends UserDataState {}

class CurrentUserDataLoading extends UserDataState {}

class CurrentUserDataSuccess extends UserDataState {
}

class CurrentUserDataFailure extends UserDataState {
  final String errMessage;
  CurrentUserDataFailure(this.errMessage);
}
