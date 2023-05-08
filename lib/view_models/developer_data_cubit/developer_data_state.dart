part of 'developer_data_cubit.dart';

@immutable
abstract class DeveloperDataState {}

class DeveloperDataInitial extends DeveloperDataState {}

class DeveloperDataLoading extends DeveloperDataState {}

class DeveloperDataSuccess extends DeveloperDataState {}

class DeveloperDataFailure extends DeveloperDataState {
  final String errorMessage;

  DeveloperDataFailure(this.errorMessage);
}

class DeveloperAddingLoading extends DeveloperDataState {}

class DeveloperAddingSuccess extends DeveloperDataState {}

class DeveloperAddingFailure extends DeveloperDataState {
  final String errorMessage;

  DeveloperAddingFailure(this.errorMessage);
}

class CurrentDeveloperLoading extends DeveloperDataState {}

class CurrentDeveloperSuccess extends DeveloperDataState {}

class CurrentDeveloperFailure extends DeveloperDataState {}
