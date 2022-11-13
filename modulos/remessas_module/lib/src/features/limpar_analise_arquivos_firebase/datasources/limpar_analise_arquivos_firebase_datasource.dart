import 'package:dependencies_module/dependencies_module.dart';

import '../../../utils/parametros/parametros_remessas_module.dart';

class LimparAnaliseArquivosFirebaseDatasource implements Datasource<bool> {
  @override
  Future<bool> call({required ParametersReturnResult parameters}) async {
    try {
      if (parameters is ParametrosLimparAnaliseArquivos) {
        final mapDelete = {
          "Protocolos ok": null,
          "Protocolos sem boletos": null,
          "Arquivos invalidos": null
        };

        await FirebaseFirestore.instance
            .collection("remessas")
            .doc(parameters.idRemessa)
            .update(mapDelete);

        return true;
      } else {
        return false;
      }
    } catch (e) {
      throw Exception("Erro ao fazer o upload dos boletos no banco de dados");
    }
  }
}
