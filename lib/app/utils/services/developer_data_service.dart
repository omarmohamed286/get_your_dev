import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_your_dev/app/repositories/developer_data_repository.dart';
import 'package:get_your_dev/models/developer_model.dart';
import '../constants.dart';

class DeveloperDataService extends DeveloperDataRepository {
  final user = FirebaseAuth.instance.currentUser;
  var developers =
      FirebaseFirestore.instance.collection(Constants.developersCollection);

  @override
  Future<void> addDeveloper(DeveloperModel developerModel) async {
    await developers.doc(user?.uid).set(developerModel.toJson());
  }

  @override
  Future<List<DeveloperModel>> getDevelopers() async {
    List<DeveloperModel> developersList = [];
    await developers.where('isAccepted', isEqualTo: 'true').get().then((value) {
      for (var doc in value.docs) {
        developersList.add(DeveloperModel.fromJson(doc.data()));
      }
    });
    return developersList;
  }

  @override
  Future<DeveloperModel> getCurrentDeveloper() async {
    late DeveloperModel developerModel;
    await developers.doc(user?.uid).get().then((value) {
      developerModel = DeveloperModel.fromJson(value.data());
    });
    return developerModel;
  }
}
