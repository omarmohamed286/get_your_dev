import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get_your_dev/app/repositories/chat_repository.dart';
import 'package:meta/meta.dart';
import '../../models/contact_model.dart';
import '../../models/message_model.dart';
part 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  ChatCubit(this.chat) : super(ChatInitial());
  ChatRepository chat;

  List<ContactModel> contactsList = [];

  void sendMessage(
      {required MessageModel message,
      required String firstUser,
      required String secondUser}) {
    chat.sendMessage(
        message: message, firstUser: firstUser, secondUser: secondUser);
  }

  Stream<QuerySnapshot> getMessages(
      {required String firstUser, required String secondUser}) {
    return chat.getMessages(firstUser: firstUser, secondUser: secondUser);
  }

  void addUserToContactList(
      {required ContactModel firstUserContact,
      required ContactModel secondUserContact}) {
    chat.addUserToContactList(
        firstUserContact: firstUserContact,
        secondUserContact: secondUserContact);
  }

  Future<void> getUserContacts({required String userEmail}) async {
    emit(ContactsDataLoading());
    try {
      contactsList = await chat.getUserContacts(userEmail: userEmail);
      emit(ContactsDataSuccess());
    } catch (e) {
      emit(ContactsDataFailure(e.toString()));
    }
  }
}
