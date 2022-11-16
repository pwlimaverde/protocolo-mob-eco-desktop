import 'package:dependencies_module/dependencies_module.dart';

class FirebaseService extends GetxService {
  Future<Firestore> init() async {
    final firebase = Firestore.initialize(projectId);
    return firebase;
  }
}
