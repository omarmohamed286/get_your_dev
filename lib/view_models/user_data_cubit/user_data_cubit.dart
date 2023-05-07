import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:meta/meta.dart';
import '../../app/utils/services/user_data_service.dart';
import '../../models/user_model.dart';
part 'user_data_state.dart';

class UserDataCubit extends Cubit<UserDataState> {
  UserDataCubit(this.user) : super(UserDataInitial());
  UserDataService user;

  UserModel? userModel;

  Future<void> addUser(UserModel userModel) async {
    await user.addUser(userModel).catchError((onError) => debugPrint(onError));
  }

  Future<void> getUser() async {
    emit(UserDataLoading());
    try {
      userModel = await user.getUser();
      emit(UserDataSuccess());
    } catch (e) {
      emit(UserDataFailure(e.toString()));
    }
  }

  Future<void> updateUser({required String key, required String value}) async {
    emit(UserDataUpdateLoading());
    try {
      await user.updateUser(key: key, value: value);
      emit(UserDataUpdateSuccess());
    } catch (e) {
      emit(UserDataUpdateFailure(e.toString()));
    }
  }

  Future<String?> uploadUserImage({required String source}) async {
    String? url;
    emit(UserDataUpdateLoading());
    try {
      url = await user.uploadUserImage(source: source);
      emit(UserDataUpdateSuccess());
      return url;
    } catch (e) {
      emit(UserDataUpdateFailure(e.toString()));
    }
    return null;
  }

  Future<void> sendPasswordResetEmail({required String email}) async {
    emit(UserDataUpdateLoading());
    try {
      await user.sendPasswordResetEmail(email: email);
      emit(UserDataUpdateSuccess());
    } catch (e) {
      emit(UserDataUpdateFailure(e.toString()));
    }
  }
}
