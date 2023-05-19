import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get_your_dev/models/message_model.dart';
import '../../models/contact_model.dart';

abstract class ChatRepository {
  void sendMessage(
      {required MessageModel message,
      required String firstUser,
      required String secondUser});
  Stream<QuerySnapshot> getMessages(
      {required String firstUser, required String secondUser});
  void addUserToContactList(
      {required ContactModel firstUserContact,
      required ContactModel secondUserContact});
  Future<List<ContactModel>> getUserContacts({required String userEmail});
}
