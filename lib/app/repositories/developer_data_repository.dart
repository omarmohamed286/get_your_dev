import 'package:get_your_dev/models/developer_model.dart';

abstract class DeveloperDataRepository {
  Future<void> addDeveloper(DeveloperModel developerModel);
  Future<List<DeveloperModel>> getDevelopers();
  Future<DeveloperModel> getCurrentDeveloper();
}
