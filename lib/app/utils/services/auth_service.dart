import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_your_dev/app/repositories/auth_repository.dart';

class AuthService implements AuthRepository {
  AuthService();
  @override
  Future<void> signUp(String email, String password) async {
    await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  @override
  Future<void> signIn(String email, String password) async {
    await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);
  }

  factory AuthService.instance() => AuthService();
}
