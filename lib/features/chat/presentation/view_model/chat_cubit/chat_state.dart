part of 'chat_cubit.dart';

@immutable
abstract class ChatState {}

class ChatInitial extends ChatState {}

class GetMessagesSuccess extends ChatState {
  final List<MessageModel> messages;

  GetMessagesSuccess(this.messages);
}

class GetMessagesFailure extends ChatState {
    final String errMessage;

  GetMessagesFailure(this.errMessage);

}

class GetContactsLoading extends ChatState {}
class GetContactsSuccess extends ChatState {}
class GetContactsFailure extends ChatState {
    final String errMessage;

  GetContactsFailure(this.errMessage);

}
