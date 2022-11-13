import 'package:dependencies_module/dependencies_module.dart';
import 'splash_controller.dart';

class SplashBiding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SplashController>(() {
      return SplashController();
    });
  }
}
