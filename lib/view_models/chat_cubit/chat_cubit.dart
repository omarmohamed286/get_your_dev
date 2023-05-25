import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';
import '../../models/contact_model.dart';
import '../../models/message_model.dart';
part 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  ChatCubit() : super(ChatInitial());

  CollectionReference messages =
      FirebaseFirestore.instance.collection('messages');

  CollectionReference contacts =
      FirebaseFirestore.instance.collection('contacts');

  List<ContactModel> contactsList = [];

  void sendMessage(
      {required MessageModel message,
      required String firstUser,
      required String secondUser}) {
    messages
        .doc(firstUser)
        .collection('message')
        .doc(secondUser)
        .collection('chat')
        .doc()
        .set(message.toJson());
    messages
        .doc(secondUser)
        .collection('message')
        .doc(firstUser)
        .collection('chat')
        .doc()
        .set(message.toJson());
  }

  Stream<QuerySnapshot> getMessages(
      {required String firstUser, required String secondUser}) {
    return messages
        .doc(firstUser)
        .collection('message')
        .doc(secondUser)
        .collection('chat')
        .orderBy('createdAt', descending: true)
        .snapshots();
  }

  void addUserToContactList(
      {required ContactModel firstUserContact,
      required ContactModel secondUserContact}) {
    contacts
        .doc(firstUserContact.email)
        .collection('user contacts')
        .doc()
        .set(secondUserContact.toJson());
    contacts
        .doc(secondUserContact.email)
        .collection('user contacts')
        .doc()
        .set(firstUserContact.toJson());
  }

  Future<void> getUserContacts({required String userEmail}) async {
    emit(ContactsDataLoading());
    try {
      await contacts
          .doc(userEmail)
          .collection('user contacts')
          .get()
          .then((value) {
        for (var doc in value.docs) {
          contactsList.add(ContactModel.fromJson(doc.data()));
        }
      });
      emit(ContactsDataSuccess());
    } catch (e) {
      emit(ContactsDataFailure(e.toString()));
    }
  }
}
