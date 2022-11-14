import 'package:dependencies_module/dependencies_module.dart';

import '../../../utils/parametros/parametros_upload_remessa_module.dart';

class UploadRemessaDatabaseDatasource implements Datasource<RemessaModel> {
  @override
  Future<RemessaModel> call(
      {required ParametersReturnResult parameters}) async {
    try {
      if (parameters is ParametrosUploadRemessa) {
        dataBaseRemessa.removeAll();
        dataBaseBoleto.removeAll();
        final map = parameters.remessaUpload;

        final RemessaModel remessa = map["remessa"];

        final List<BoletoModel> boletos = map["boletos"];

        final remessaId = dataBaseRemessa.put(remessa);

        final remessaModel = dataBaseRemessa.get(remessaId);

        if (remessaModel != null) {
          remessaModel.boletos.addAll(boletos);
          dataBaseRemessa.put(remessaModel);
          return remessaModel;
        } else {
          throw Exception(
              "Erro ao fazer o upload das remessas no banco de dados");
        }
      } else {
        throw Exception(
            "Erro ao fazer o upload das remessas no banco de dados");
      }
    } catch (e) {
      throw Exception("Erro ao fazer o upload das remessas no banco de dados");
    }
  }
}
