import 'package:dependencies_module/dependencies_module.dart';

import 'ui/upload_remessa_page.dart';
import 'upload_remessa_bindings.dart';

class UploadRemessaModule extends Module {
  @override
  List<GetPage> routers = [
    GetPage(
      name: Routes.uploadRemessa.caminho,
      transition: Transition.noTransition,
      page: () => const UploadRemessaPage(),
      bindings: [
        UploadRemessaBiding(),
      ],
    ),
  ];
}
