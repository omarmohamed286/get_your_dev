import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_your_dev/core/utils/services/auth_service.dart';
import 'package:get_your_dev/features/auth/data/repos/auth_repo.dart';
import 'package:dartz/dartz.dart';
import 'package:get_your_dev/core/errors/failures.dart';

class AuthRepoImpl implements AuthRepo {
  final AuthService authService;

  AuthRepoImpl(this.authService);

  @override
  Future<Either<Failure, void>> signinUser({
    required String email,
    required String password,
  }) async {
    try {
      await authService.signinUser(email: email, password: password);
      return right(null);
    } on FirebaseAuthException catch (e) {
      return left(AuthFailure.fromSigninError(eCode: e.code));
    } catch (e) {
      return left(
          const AuthFailure('حدث خطأ غير متوقع، يرجي المحاولة مرة أخري'));
    }
  }

  @override
  Future<Either<Failure, void>> signupUser({
    required String email,
    required String password,
  }) async {
    try {
      await authService.signupUser(
        email: email,
        password: password,
      );
      return right(null);
    } on FirebaseAuthException catch (e) {
      return left(AuthFailure.fromSignupError(eCode: e.code));
    } catch (e) {
      return left(
          const AuthFailure('حدث خطأ غير متوقع، يرجي المحاولة مرة أخري'));
    }
  }

  @override
  Future<Either<Failure, void>> sendPasswordResetEmail(
      {required String email}) async {
    try {
      await authService.sendPasswordResetEmail(email: email);
      return right(null);
    } catch (e) {
      return left(
          const ServerFailure('فشل إرسال الطلب، يرجي المحاولة مرة أخري'));
    }
  }
}
