import 'package:bloc/bloc.dart';
import 'package:get_your_dev/core/models/user_model.dart';
import 'package:meta/meta.dart';
import '../../../data/repos/home_repo.dart';
part 'user_data_state.dart';

class UserDataCubit extends Cubit<UserDataState> {
  UserDataCubit(this.homeRepo) : super(UserDataInitial());

  final HomeRepo homeRepo;
  UserModel? currentUser;

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
}
