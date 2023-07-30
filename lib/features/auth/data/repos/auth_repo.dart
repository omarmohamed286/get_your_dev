import 'package:dartz/dartz.dart';
import 'package:get_your_dev/core/errors/failures.dart';

abstract class AuthRepo {
  String getUserUid();
  Future<Either<Failure, void>> signupUser({
    required String email,
    required String password,
  });
  Future<Either<Failure, void>> signinUser({
    required String email,
    required String password,
  });
  Future<Either<Failure, void>> sendPasswordResetEmail({required String email});
}
