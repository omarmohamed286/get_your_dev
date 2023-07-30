import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get_your_dev/core/models/user_model.dart';
import 'package:get_your_dev/features/chat/data/models/message_model.dart';

class ChatService {
  CollectionReference messages =
      FirebaseFirestore.instance.collection('messages');

  CollectionReference users = FirebaseFirestore.instance.collection('users');
  CollectionReference contacts =
      FirebaseFirestore.instance.collection('contacts');

  Future<void> addMessage(
      {required String firstUserId,
      required String secondUserId,
      required MessageModel message}) async {
    await messages
        .doc(firstUserId)
        .collection('message')
        .doc(secondUserId)
        .collection('chat')
        .doc()
        .set(message.toJson());
    await messages
        .doc(secondUserId)
        .collection('message')
        .doc(firstUserId)
        .collection('chat')
        .doc()
        .set(message.toJson());
  }

  Future<void> addUserToContactList(
      {required UserModel firstUser, required UserModel secondUser}) async {
    DocumentReference secondUserRef =
        FirebaseFirestore.instance.doc('users/${secondUser.uId}');
    DocumentReference firstUserRef =
        FirebaseFirestore.instance.doc('users/${firstUser.uId}');
    await users.doc(firstUser.uId).update({
      'contacts': FieldValue.arrayUnion([secondUserRef])
    });
    await users.doc(secondUser.uId).update({
      'contacts': FieldValue.arrayUnion([firstUserRef])
    });
  }

  Future<List<UserModel>?> getUserContacts({required String userId}) async {
    List<UserModel> contactsList = [];
    await users.doc(userId).get().then((value) async {
      Map<String, dynamic> data = value.data() as Map<String, dynamic>;
      for (var user in data['contacts']) {
        DocumentReference docRef = user;
        await docRef.get().then((value) {
          contactsList
              .add(UserModel.fromJson(value.data() as Map<String, dynamic>));
        });
      }
    });
    return contactsList;
  }

  Stream<QuerySnapshot> getMessages(
      {required String firstUserId, required String secondUserId}) {
    return messages
        .doc(firstUserId)
        .collection('message')
        .doc(secondUserId)
        .collection('chat')
        .orderBy('createdAt', descending: true)
        .snapshots();
  }
}
