import 'package:get_your_dev/models/user_model.dart';

abstract class UserDataRepository {
  Future<void> addUser(UserModel userModel);
  Future<UserModel?> getUser();
  Future<void> updateUser({required String key, required String value});
  Future<String?> uploadUserImage({required String source});
  Future<void> sendPasswordResetEmail({required String email});
}
