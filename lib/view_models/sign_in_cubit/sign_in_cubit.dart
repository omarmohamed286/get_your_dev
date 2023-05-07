import 'package:bloc/bloc.dart';
import 'package:get_your_dev/app/utils/services/auth_service.dart';
import 'package:meta/meta.dart';
part 'sign_in_state.dart';

class SignInCubit extends Cubit<SignInState> {
  SignInCubit(this.auth) : super(SignInInitial());
  AuthService auth;

  Future<void> signIn(String email, String password) async {
    emit(SignInLoading());
    try {
      await auth.signIn(email, password);
      emit(SignInSuccess());
    } catch (e) {
      emit(SignInFailure(e.toString()));
    }
  }
}
