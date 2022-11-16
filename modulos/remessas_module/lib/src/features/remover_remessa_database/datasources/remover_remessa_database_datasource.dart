import 'package:dependencies_module/dependencies_module.dart';

import '../../../utils/parametros/parametros_remessas_module.dart';

class RemoverRemessaDatabaseDatasource implements Datasource<bool> {
  @override
  Future<bool> call({required ParametersReturnResult parameters}) async {
    try {
      if (parameters is ParametrosRemoverRemessa) {
        final remessa = dataBaseRemessa.get(parameters.idRemessa);
        if (remessa != null) {
          final boletos = remessa.boletos.map((element) => element.id).toList();
          dataBaseBoleto.removeMany(boletos);
          final remessaRemovida = dataBaseRemessa.remove(parameters.idRemessa);
          return remessaRemovida;
        } else {
          return false;
        }
      } else {
        return false;
      }
    } catch (e) {
      throw Exception("Erro ao fazer a remoção da remessa no banco de dados");
    }
  }
}
