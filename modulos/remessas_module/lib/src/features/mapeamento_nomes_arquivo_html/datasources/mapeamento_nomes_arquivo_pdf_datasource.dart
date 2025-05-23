import 'package:dependencies_module/dependencies_module.dart';
import '../../../utils/parametros/parametros_remessas_module.dart';

class MapeamentoNomesArquivoPdfDatasource
    implements Datasource<List<Map<int, Uint8List>>> {
  @override
  Future<List<Map<int, Uint8List>>> call(
      {required ParametersReturnResult parameters}) async {
    if (parameters is ParametrosMapeamentoArquivoHtml) {
      List<Map<String, Uint8List>> mapBytes = parameters.listaMapBytes;

      if (mapBytes.isNotEmpty) {
        List<Map<int, Uint8List>> listaArquivos = [];
        for (Map<String, Uint8List> map in mapBytes) {
          listaArquivos.add(_listaProcessada(
            map: map,
            remessa: parameters.remessa,
          ));
        }
        return listaArquivos;
      } else {
        throw Exception(
            "Erro ao mapear as informaões do arquivo - ${parameters.error}");
      }
    } else {
      throw Exception(
          "Erro ao mapear as informaões do arquivo - - ${parameters.error}");
    }
  }

  Map<int, Uint8List> _listaProcessada({
    required Map<String, Uint8List> map,
    required RemessaModel remessa,
  }) {
    if (map.keys.first.contains(".pdf")) {
      return _processamentoPdf(map: map, remessa: remessa);
    } else {
      return <int, Uint8List>{};
    }
  }

  Map<int, Uint8List> _processamentoPdf({
    required Map<String, Uint8List> map,
    required RemessaModel remessa,
  }) {
    Map<int, Uint8List> arquivoProcessado = {};
    final nomeArquivo = map.keys.first;

    final isBoleto = remessa.nomeArquivo.split(" - ")[0] == "Boleto";

    final arquivo = map.values.first;

    final idArquivo = !isBoleto
        ? int.tryParse(nomeArquivo.toString().split("_").length > 1
            ? nomeArquivo.toString().split("_")[1]
            : "")
        : int.tryParse(nomeArquivo.toString().split("_").length > 1
            ? nomeArquivo.toString().split("_")[2].split(".")[0]
            : "");

    print("&&&&&&&&&&&&&");
    print(nomeArquivo.toString().split("_")[2].split(".")[0]);
    if (idArquivo != null) {
      arquivoProcessado.addAll({idArquivo: arquivo});
      return arquivoProcessado;
    } else {
      return <int, Uint8List>{};
    }
  }
}
