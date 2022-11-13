import 'package:dependencies_module/dependencies_module.dart';
import 'db/objectbox.g.dart';

class DatabaseService extends GetxService {
  Future<Store> init() async {
    print("Inicio Database");
    final store = await openStore();
    return store;
  }
}
