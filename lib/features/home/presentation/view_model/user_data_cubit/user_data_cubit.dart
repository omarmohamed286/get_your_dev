import 'package:bloc/bloc.dart';
import 'package:get_your_dev/core/models/user_model.dart';
import 'package:meta/meta.dart';
import '../../../data/repos/home_repo.dart';
part 'user_data_state.dart';

class UserDataCubit extends Cubit<UserDataState> {
  UserDataCubit(this.homeRepo) : super(UserDataInitial());

  final HomeRepo homeRepo;
  UserModel? currentUser;
  List<UserModel> developersList = [];

  Future<void> addUserData({required UserModel userModel}) async {
    await homeRepo.addUserData(userModel: userModel);
  }

  Future<void> getCurrentUserData() async {
    emit(CurrentUserDataLoading());
    var result = await homeRepo.getCurrentUserData();
    result.fold((failure) {
      emit(CurrentUserDataFailure(failure.errMessage));
    }, (userModel) {
      currentUser = userModel;
      emit(CurrentUserDataSuccess());
    });
  }

  Future<void> updateUserImage({required String source}) async {
    emit(UploadUserImageLoading());
    var result = await homeRepo.uploadUserImage(source: source);
    result.fold((failure) {
      emit(UploadUserImageFailure(failure.errMessage));
    }, (imageUrl) async {
      if (imageUrl != null) {
        updateUserData(key: 'image', value: imageUrl);
        getCurrentUserData();
        getAcceptedDevelopers();
        emit(UploadUserImageSuccess());
      } else {
        emit(UploadUserImageSuccess());
      }
    });
  }

  Future<void> updateUserData({
    required String key,
    required String value,
  }) async {
    emit(UpdateUserDataLoading());
    var result = await homeRepo.updateUserData(key: key, value: value);
    result.fold((failure) {
      emit(UpdateUserDataFailure(failure.errMessage));
    }, (success) async {
      getCurrentUserData();
      getAcceptedDevelopers();
      emit(UpdateUserDataSuccess());
    });
  }

  Future<void> getAcceptedDevelopers() async {
    emit(DevelopersDataLoading());
    var result = await homeRepo.getAcceptedDevelopers();
    result.fold((failure) {
      emit(DevelopersDataFailure(failure.errMessage));
    }, (developers) {
      developersList = developers;
      emit(DevelopersDataSuccess());
    });
  }
}
