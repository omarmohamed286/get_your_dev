part of 'chat_cubit.dart';

@immutable
abstract class ChatState {}

class ChatInitial extends ChatState {}

class ContactsDataLoading extends ChatState {}

class ContactsDataSuccess extends ChatState {}

class ContactsDataFailure extends ChatState {
  final String errorMessage;
  ContactsDataFailure(this.errorMessage);
}
