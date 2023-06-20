import 'package:dartz/dartz.dart';
import 'package:get_your_dev/core/errors/failures.dart';
import 'package:get_your_dev/core/models/user_model.dart';

abstract class HomeRepo {
  Future<void> addUserData({required UserModel userModel});
  Future<Either<Failure, UserModel>> getCurrentUserData();
  Future<Either<Failure, List<UserModel>>> getAcceptedDevelopers();
  Future<Either<Failure, String?>> uploadUserImage({required String source});
  Future<Either<Failure, void>> updateUserData({
    required String key,
    required String value,
  });
}
