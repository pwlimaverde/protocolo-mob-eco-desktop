import 'package:dependencies_module/dependencies_module.dart';
import 'package:flutter/material.dart';

import 'home_bindings.dart';
import 'ui/home_page.dart';

class HomeModule extends Module {
  @override
  List<GetPage> routers = [
    GetPage(
      name: Routes.initial.caminho,
      page: () {
        return Obx(
          () {
            if (coreModuleController.isCarregado) {
              final licenca = coreModuleController.licenca;
              if (licenca != null) {
                if (licenca) {
                  return const HomePage();
                } else {
                  designSystemController.message(MessageModel.error(
                    title: 'Checagem de Licença',
                    message:
                        'Erro ao carregar a licença! Contate o Desenvolvedor...',
                  ));
                  return const Center(
                    child: SizedBox(
                      width: 350,
                      height: 350,
                      child: Card(
                        color: Colors.red,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.warning_rounded,
                              color: Colors.white,
                              size: 300,
                            ),
                            Text(
                              "Erro ao carregar licença...",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 20),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }
              } else {
                return Container(
                  color: Colors.grey,
                  child: const Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              }
            } else {
              return Container(
                color: Colors.grey,
                child: const Center(
                  child: CircularProgressIndicator(),
                ),
              );
            }
          },
        );
      },
      transition: Transition.noTransition,
      bindings: [
        HomeBiding(),
      ],
    ),
  ];
}
