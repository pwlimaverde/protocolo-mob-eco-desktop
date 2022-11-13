import 'package:dependencies_module/dependencies_module.dart';
import 'splash_bindings.dart';
import 'ui/splash_page.dart';

class SplashModule extends Module {
  @override
  List<GetPage> routers = [
    GetPage(
      name: Routes.splash.caminho,
      page: () => const SplashPage(),
      bindings: [
        SplashBiding(),
      ],
    ),
  ];
}
