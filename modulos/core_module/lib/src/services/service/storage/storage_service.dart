import 'package:dependencies_module/dependencies_module.dart';

class StorageService extends GetxService {
  Future<GetStorage> init() async {
    final storage = GetStorage();
    return storage;
  }
}
