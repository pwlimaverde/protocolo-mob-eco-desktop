import 'package:dependencies_module/dependencies_module.dart';

import '../../../utils/parametros/parametros_remessas_module.dart';

class TipoRemessaDatabaseDatasource implements Datasource<bool> {
  @override
  Future<bool> call({required ParametersReturnResult parameters}) async {
    try {
      if (parameters is ParametrosAlterarRemessa) {
        final remessa = dataBaseRemessa.get(parameters.idRemessa);

        if (remessa != null) {
          remessa.tipo == "RE" ? remessa.tipo = "" : remessa.tipo = "RE";
          final boletosAlterados = remessa.boletos.map(((e) {
            e.tipo == "RE" ? e.tipo = "" : e.tipo = "RE";
            return e;
          })).toList();
          dataBaseBoleto.putMany(boletosAlterados);

          dataBaseRemessa.put(remessa);

          return true;
        } else {
          return false;
        }
      } else {
        return false;
      }
    } catch (e) {
      throw Exception("Erro ao fazer a alteração da remessa no banco de dados");
    }
  }
}
