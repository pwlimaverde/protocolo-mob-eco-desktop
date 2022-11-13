import 'package:dependencies_module/dependencies_module.dart';

import 'home_bindings.dart';
import 'ui/home_page.dart';

class HomeModule extends Module {
  @override
  List<GetPage> routers = [
    GetPage(
      name: Routes.initial.caminho,
      page: () => const HomePage(),
      transition: Transition.noTransition,
      bindings: [
        HomeBiding(),
      ],
    ),
  ];
}
