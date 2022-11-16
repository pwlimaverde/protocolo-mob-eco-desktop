import 'package:dependencies_module/dependencies_module.dart';

import '../../../utils/parametros/parametros_remessas_module.dart';

class UploadAnaliseArquivosDatabaseDatasource implements Datasource<bool> {
  @override
  Future<bool> call({required ParametersReturnResult parameters}) async {
    try {
      if (parameters is ParametrosUploadAnaliseArquivos) {
        final mapBoleto = parameters.mapAliseArquivos;
        final listOk = mapBoleto["Protocolos ok"] as List<int>;
        final listInvalidos = mapBoleto["Arquivos invalidos"] as List<int>;
        final RemessaModel remessa = parameters.remessa;
        final List<BoletoModel> boletos = parameters.remessa.boletos;

        for (int idCliente in listInvalidos) {
          remessa.arquivosInvalidos.add(idCliente.toString());
        }
        dataBaseRemessa.put(remessa);
        for (BoletoModel boleto in boletos) {
          if (listOk.contains(boleto.idCliente)) {
            boleto.isVerificado = true;
          }
        }
        dataBaseBoleto.putMany(boletos);

        return true;
      } else {
        return false;
      }
    } catch (e) {
      throw Exception("Erro ao fazer o upload dos boletos no banco de dados");
    }
  }
}
