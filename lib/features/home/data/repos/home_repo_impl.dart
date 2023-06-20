import 'package:get_your_dev/core/models/user_model.dart';
import 'package:get_your_dev/core/errors/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:get_your_dev/core/utils/services/user_data_service.dart';
import 'package:get_your_dev/features/home/data/repos/home_repo.dart';

class HomeRepoImpl implements HomeRepo {
  final UserDataService userDataService;

  HomeRepoImpl(this.userDataService);

  @override
  Future<void> addUserData({required UserModel userModel}) async {
    await userDataService.addUserData(userModel: userModel);
  }

  @override
  Future<Either<Failure, UserModel>> getCurrentUserData() async {
    try {
      return right(await userDataService.getCurrentUserData());
    } catch (e) {
      return left(
          const ServerFailure('حدث خطأ غير متوقع، يرجي المحاولة مرة اخري'));
    }
  }

  @override
  Future<Either<Failure, String?>> uploadUserImage(
      {required String source}) async {
    try {
      return right(await userDataService.uploadUserImage(source: source));
    } catch (e) {
      return left(
          const ServerFailure('فشل تغيير الصورة، برجاء المحاولة مرة اخري'));
    }
  }

  @override
  Future<Either<Failure, void>> updateUserData(
      {required String key, required String value}) async {
    try {
      await userDataService.updateUserData(key: key, value: value);
      return right(null);
    } catch (e) {
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<UserModel>>> getAcceptedDevelopers() async {
    try {
      return right(await userDataService.getAcceptedDevelopers());
    } catch (e) {
      return left(
          const ServerFailure('فشل جلب البيانات، برجاء المحاولة مرة اخري'));
    }
  }
}
