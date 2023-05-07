import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import '../../app/repositories/auth_repository.dart';
part 'sign_up_state.dart';

class SignUpCubit extends Cubit<SignUpState> {
  SignUpCubit(this.auth) : super(SignUpInitial());
  AuthRepository auth;

  Future<void> signUp(String email, String password) async {
    emit(SignUpLoading());
    try {
      await auth.signUp(email, password);
      emit(SignUpSuccess());
    } catch (e) {
      emit(SignUpFailure(e.toString()));
    }
  }
}
