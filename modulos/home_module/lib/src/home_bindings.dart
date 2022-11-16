import 'package:dependencies_module/dependencies_module.dart';
import 'home_controller.dart';

class HomeBiding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeController>(() {
      return HomeController();
    });
  }
}
