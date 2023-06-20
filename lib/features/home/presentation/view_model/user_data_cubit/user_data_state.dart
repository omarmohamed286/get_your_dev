part of 'user_data_cubit.dart';

@immutable
abstract class UserDataState {}

class UserDataInitial extends UserDataState {}

class CurrentUserDataLoading extends UserDataState {}

class CurrentUserDataSuccess extends UserDataState {}

class CurrentUserDataFailure extends UserDataState {
  final String errMessage;
  CurrentUserDataFailure(this.errMessage);
}

class UploadUserImageLoading extends UserDataState {}

class UploadUserImageSuccess extends UserDataState {}

class UploadUserImageFailure extends UserDataState {
  final String errMessage;

  UploadUserImageFailure(this.errMessage);
}

class UpdateUserDataLoading extends UserDataState {}

class UpdateUserDataSuccess extends UserDataState {}

class UpdateUserDataFailure extends UserDataState {
  final String errMessage;

  UpdateUserDataFailure(this.errMessage);
}

class DevelopersDataLoading extends UserDataState {}

class DevelopersDataSuccess extends UserDataState {
}

class DevelopersDataFailure extends UserDataState {
  final String errMessage;
  DevelopersDataFailure(this.errMessage);
}
