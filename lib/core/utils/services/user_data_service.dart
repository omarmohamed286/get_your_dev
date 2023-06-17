import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_your_dev/core/constants.dart';
import '../../models/user_model.dart';

class UserDataService {
  var users = FirebaseFirestore.instance.collection(kUsersCollection);

  Future<void> addUserData({required UserModel userModel}) async {
    await users
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .set(userModel.toJson());
  }

  Future<UserModel> getCurrentUserData() async {
    late UserModel userModel;
    await users.doc(FirebaseAuth.instance.currentUser!.uid).get().then((value) {
      userModel = UserModel.fromJson(value.data());
    });
    return userModel;
  }
}
