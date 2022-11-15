import 'package:dependencies_module/dependencies_module.dart';

import '../../../utils/parametros/parametros_remessas_module.dart';

class LimparAnaliseArquivosDatabaseDatasource implements Datasource<bool> {
  @override
  Future<bool> call({required ParametersReturnResult parameters}) async {
    try {
      if (parameters is ParametrosLimparAnaliseArquivos) {
        final remessa = dataBaseRemessa.get(parameters.idRemessa);
        if (remessa != null) {
          remessa.arquivosInvalidos.clear();
          final boletosAlterados = remessa.boletos.map((element) {
            element.isVerificado = false;
            return element;
          }).toList();
          dataBaseRemessa.put(remessa);
          dataBaseBoleto.putMany(boletosAlterados);
        }
        return true;
      } else {
        return false;
      }
    } catch (e) {
      throw Exception("Erro ao fazer o upload dos boletos no banco de dados");
    }
  }
}
