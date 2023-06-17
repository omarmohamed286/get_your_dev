import 'package:bloc/bloc.dart';
import 'package:get_your_dev/features/auth/data/repos/auth_repo.dart';
import 'package:meta/meta.dart';
part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit(this.authRepo) : super(AuthInitial());

  final AuthRepo authRepo;

  Future<void> signupUser({
    required String email,
    required String password,
  }) async {
    emit(AuthLoading());
    var result = await authRepo.signupUser(
      email: email,
      password: password,
    );
    result.fold((failure) {
      emit(AuthFailure(failure.errMessage));
    }, (success) {
      emit(AuthSuccess());
    });
  }

  Future<void> signinUser({
    required String email,
    required String password,
  }) async {
    emit(AuthLoading());
    var result = await authRepo.signinUser(email: email, password: password);
    result.fold((failure) {
      emit(AuthFailure(failure.errMessage));
    }, (success) {
      emit(AuthSuccess());
    });
  }

  Future<void> sendPasswordResetEmail({required String email}) async {
    emit(SendPasswordResetEmailLoading());
    var result = await authRepo.sendPasswordResetEmail(email: email);
    result.fold((failure) {
      emit(SendPasswordResetEmailFailure(failure.errMessage));
    }, (success) {
      emit(SendPasswordResetEmailSuccess());
    });
  }
}
