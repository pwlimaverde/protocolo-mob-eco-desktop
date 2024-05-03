import 'package:dependencies_module/dependencies_module.dart';

import '../../../utils/parametros/parametros_upload_remessa_module.dart';

class ProcessamentoDadosArquivoHtmlDatasource
    implements Datasource<Map<String, List<Map<String, dynamic>>>> {
  @override
  Future<Map<String, List<Map<String, dynamic>>>> call(
      {required ParametersReturnResult parameters}) async {
    try {
      if (parameters is ParametrosProcessamentoArquivoHtml) {
        List<Map<String, dynamic>> remessasProcessadas = [];
        List<Map<String, dynamic>> remessasProcessadasError = [];
        for (Map<String, dynamic> mapRemessa in parameters.listaMapBruta) {
          final String nomeArquivo =
              "${mapRemessa["arquivo"]["nome do arquivo"]} - ${DateTime.now().day}${DateTime.now().month}-${DateTime.now().year}";

          final List<Map<String, String>> listaBoletos =
              mapRemessa["arquivo"]["boletos"];

          final List<int> listaIdsClientes =
              mapRemessa["arquivo"]["ID Clientes"];

          final DateTime data = mapRemessa["arquivo"]["data da remessa"];

          final String tipo = mapRemessa["arquivo"]["tipo do arquivo"];

          if (listaBoletos.isNotEmpty) {
            final remessa = RemessaModel(
              nomeArquivo: nomeArquivo,
              data: data,
              upload: DateTime.now(),
            );

            final boletos = await _processamentoBoleto(
              tipoArquivo: tipo,
              listaBoletos: listaBoletos,
              listaIdsClientes: listaIdsClientes,
            );
            remessasProcessadas.add({
              "remessa": remessa,
              "boletos": boletos,
            });
          } else {
            final remessa = RemessaModel(
              nomeArquivo: nomeArquivo,
              data: data,
              upload: DateTime.now(),
            );
            remessasProcessadasError
                .add({"remessa": remessa, "boletos": <BoletoModel>[]});
          }
        }
        final Map<String, List<Map<String, dynamic>>> remessas = {
          "remessasProcessadas": remessasProcessadas,
          "remessasProcessadasError": remessasProcessadasError,
        };

        return remessas;
      } else {
        throw Exception("Erro ao processar arquivo");
      }
    } catch (e) {
      throw Exception("Erro ao processar arquivo");
    }
  }
}

// List<int> _idsClientes({required List<int> filtro}) {
//   final listIdsBoletos = <int>[];
//   for (int id in filtro) {
//     if (!listIdsBoletos.contains(id)) {
//       listIdsBoletos.add(id);
//     }
//   }
//   listIdsBoletos.sort(
//     (a, b) => a.compareTo(b),
//   );
//   return listIdsBoletos;
// }

Future<List<BoletoModel>> _processamentoBoleto({
  required List<Map<String, String>> listaBoletos,
  required String tipoArquivo,
  required List<int> listaIdsClientes,
}) async {
  List<BoletoModel> boletos = [];

  if (listaBoletos.isNotEmpty) {
    for (Map<String, String> boleto in listaBoletos) {
      if (tipoArquivo == "csv") {
        BoletoModel model = BoletoModel.fromMapCsv(
          map: boleto,
        );
        final quantBoletos = listaIdsClientes
            .where((element) => element == model.idCliente)
            .length;
        for (int id = 1; id < quantBoletos; id++) {
          model.setQuantidadeBoletos();
        }
        boletos.add(model);
      }
      if (tipoArquivo == "xlsx") {
        BoletoModel model = BoletoModel.fromMapXlsx(
          map: boleto,
        );
        final quantBoletos = listaIdsClientes
            .where((element) => element == model.idCliente)
            .length;
        for (int id = 1; id < quantBoletos; id++) {
          model.setQuantidadeBoletos();
        }
        boletos.add(model);
      }
    }
    boletos.sort(
      (a, b) => a.cliente.compareTo(b.cliente),
    );
    return boletos;
  } else {
    throw Exception("Erro ao processar arquivo");
  }
}
