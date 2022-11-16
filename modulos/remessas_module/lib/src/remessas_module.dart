import 'package:dependencies_module/dependencies_module.dart';

import 'remessas_bindings.dart';
import 'ui/remessas_page.dart';

class RemessasModule extends Module {
  @override
  List<GetPage> routers = [
    GetPage(
      name: Routes.remessas.caminho,
      transition: Transition.noTransition,
      page: () => const RemessasPage(),
      bindings: [
        RemessasBiding(),
      ],
    ),
  ];
}
