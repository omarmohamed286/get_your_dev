import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get_your_dev/app/repositories/chat_repository.dart';
import 'package:get_your_dev/models/message_model.dart';
import 'dart:async';
import '../../../models/contact_model.dart';

class ChatService extends ChatRepository {
  CollectionReference messages =
      FirebaseFirestore.instance.collection('messages');

  CollectionReference contacts =
      FirebaseFirestore.instance.collection('contacts');

  @override
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

  @override
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

  @override
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

  @override
  Future<List<ContactModel>> getUserContacts(
      {required String userEmail}) async {
    List<ContactModel> contactsList = [];
    await contacts
        .doc(userEmail)
        .collection('user contacts')
        .get()
        .then((value) {
      for (var doc in value.docs) {
        contactsList.add(ContactModel.fromJson(doc.data()));
      }
    });
    return contactsList;
  }
}
