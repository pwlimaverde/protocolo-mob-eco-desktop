import 'package:dependencies_module/dependencies_module.dart';
import 'package:flutter/material.dart';

import 'features/carregar_configuracao_firebase/domain/usecase/carregar_configuracao_firebase_usecase.dart';
import 'utils/errors/erros_core.dart';

class CoreModuleController extends GetxController {
  final CarregarConfiguracaoFirebaseUsecase carregarConfiguracaoFirebaseUsecase;

  CoreModuleController({
    required this.carregarConfiguracaoFirebaseUsecase,
  });

  @override
  void onInit() {
    super.onInit();
    _carregarSufixo();
    pageAtual(Get.find<GetStorage>().read("pageAtual"));
  }

  //Configuração Sufixo
  final _sufixo = Rxn<String>();

  String? get sufixo => _sufixo.value;

  bool get isSufixo {
    return _sufixo.value != null && _sufixo.value != "" ? true : false;
  }

  Future<void> _carregarSufixo() async {
    final result = await carregarConfiguracaoFirebaseUsecase(
        parameters: NoParams(
      error: ErroCarregarConfiguracao(
        message: "Erro ao Erro ao carregar configuração.",
      ),
      showRuntimeMilliseconds: true,
      nameFeature: "Carregamento de configuração",
    ));
    if (result.status == StatusResult.success) {
      _sufixo(result.result["sufixo"].toString());
    }
  }

  //Controller de Pages
  final pageAtual = 0.obs;

  //Controller de Query
  final _size = Get.size.obs;
  double get size => _size.value.width;
  double get sizeW =>
      showMenu ? _size.value.width : _size.value.width - menuWidth;
  double get sizeH => _size.value.height - hederHeight;

  void getQuery({required BuildContext context}) {
    _size(MediaQuery.of(context).size);
  }

  bool get showMenu => _size.value.width <= 1080;

  double getWidthProporcao({
    required BuildContext context,
    required double proporcao,
  }) {
    getQuery(
      context: context,
    );
    return ((proporcao * sizeW) / 100) - 16;
  }

  double getSizeProporcao({
    required double size,
    required double proporcao,
  }) {
    var prop = ((size * proporcao) / 100);
    return prop;
  }
}
