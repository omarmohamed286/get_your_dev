import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get_your_dev/core/constants.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
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

  Future<String?> uploadUserImage({required String source}) async {
    ImagePicker imagePicker = ImagePicker();
    File? file;
    XFile? pickedImage = await imagePicker.pickImage(
        source: source == 'camera' ? ImageSource.camera : ImageSource.gallery);
    if (pickedImage != null) {
      file = File(pickedImage.path);
      String imageName = basename(pickedImage.path);
      imageName = "${FirebaseAuth.instance.currentUser!.uid}$imageName";
      Reference storageAccess =
          FirebaseStorage.instance.ref('images/$imageName');
      await storageAccess.putFile(file);
      String? url = await storageAccess.getDownloadURL();
      return url;
    }
    return null;
  }

  Future<void> updateUserData({
    required String key,
    required String value,
  }) async {
    if (key == 'email') {
      await FirebaseAuth.instance.currentUser!.updateEmail(value);
      users.doc(FirebaseAuth.instance.currentUser!.uid).update({key: value});
    } else if (key == 'password') {
      await FirebaseAuth.instance.currentUser!.updatePassword(value);
    } else {
      await users
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .update({key: value});
    }
  }

  Future<List<UserModel>> getAcceptedDevelopers() async {
    List<UserModel> developersList = [];
    await users.where('status', isEqualTo: 'accepted').get().then((value) {
      for (var doc in value.docs) {
        developersList.add(UserModel.fromJson(doc.data()));
      }
    });
    return developersList;
  }

  Future<List<UserModel>> getSpecificFieldDevelopers(
      {required String field}) async {
    List<UserModel> developersList = [];
    if (field == 'الكل') {
      await users.where('status', isEqualTo: 'accepted').get().then((value) {
        for (var doc in value.docs) {
          developersList.add(UserModel.fromJson(doc.data()));
        }
      });
    } else {
      await users
          .where('status', isEqualTo: 'accepted')
          .where('field', isEqualTo: field)
          .get()
          .then((value) {
        for (var doc in value.docs) {
          developersList.add(UserModel.fromJson(doc.data()));
        }
      });
    }
    return developersList;
  }
}
