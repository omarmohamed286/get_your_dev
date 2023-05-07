import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get_your_dev/app/repositories/user_data_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import '../../../models/user_model.dart';
import '../constants.dart';

class UserDataService extends UserDataRepository {
  UserDataService();

  final user = FirebaseAuth.instance.currentUser;
  var users = FirebaseFirestore.instance.collection(Constants.usersCollection);

  @override
  Future<void> addUser(UserModel userModel) async {
    await users.doc(user?.uid).set(userModel.toJson());
  }

  @override
  Future<UserModel?> getUser() async {
    late UserModel userModel;
    await users.doc(user?.uid).get().then((value) {
      userModel = UserModel.fromJson(value.data());
    });
    return userModel;
  }

  @override
  Future<void> updateUser({required String key, required String value}) async {
    if (key == 'البريد الإلكتروني') {
      await user?.updateEmail(value);
      await users.doc(user?.uid).update({'email': value});
    } else if (key == 'اسم المستخدم') {
      await users.doc(user?.uid).update({'username': value});
    } else if (key == 'كلمة المرور') {
      await user?.updatePassword(value);
    } else if (key == 'camera') {
      await users.doc(user?.uid).update({'image': value});
    }
  }

  @override
  Future<String?> uploadUserImage({required String source}) async {
    ImagePicker imagePicker = ImagePicker();
    File? file;
    XFile? pickedImage = await imagePicker.pickImage(
        source: source == 'camera' ? ImageSource.camera : ImageSource.gallery);
    if (pickedImage != null) {
      file = File(pickedImage.path);
      String imageName = basename(pickedImage.path);
      imageName = "${user?.uid}$imageName";
      Reference storageAccess =
          FirebaseStorage.instance.ref('images/$imageName');
      await storageAccess.putFile(file);
      String url = await storageAccess.getDownloadURL();
      return url;
    }
    return null;
  }

  @override
  Future<void> sendPasswordResetEmail({required String email}) async {
    await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
  }

  factory UserDataService.instance() => UserDataService();
}
