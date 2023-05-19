part of 'chat_cubit.dart';

@immutable
abstract class ChatState {}

class ChatInitial extends ChatState {}

class ChatDataSuccess extends ChatState {
 final List<MessageModel> messages;

  ChatDataSuccess(this.messages);

}

class ContactsDataLoading extends ChatState {}

class ContactsDataSuccess extends ChatState {}

class ContactsDataFailure extends ChatState {
  final String errorMessage;
  ContactsDataFailure(this.errorMessage);
}
