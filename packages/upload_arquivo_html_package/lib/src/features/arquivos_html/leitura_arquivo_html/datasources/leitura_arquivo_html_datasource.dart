import 'package:dependencies_module/dependencies_module.dart';
// ignore: avoid_web_libraries_in_flutter
import 'dart:html' as html;
import 'dart:convert' as convert;

import '../../../../utils/parametros/parametos.dart';

class LeituraArquivoHtmlDatasource
    implements Datasource<List<Map<String, Uint8List>>> {
  @override
  Future<List<Map<String, Uint8List>>> call(
      {required ParametersReturnResult parameters}) async {
    if (parameters is ParametrosLeituraArquivoHtml) {
      List<html.File>? files = parameters.listaArquivosHtml;

      if (files.isNotEmpty) {
        List<Map<String, Uint8List>> listaMapBytes = [];
        for (html.File file in files) {
          listaMapBytes.add(await _mapBytes(file: file));
        }
        return listaMapBytes;
      } else {
        throw Exception(
            "Erro ao ler as informaões do arquivo - ${parameters.error}");
      }
    } else {
      throw Exception(
          "Erro ao ler as informaões do arquivo - - ${parameters.error}");
    }
  }

  Future<Map<String, Uint8List>> _mapBytes({required html.File file}) {
    final reader = html.FileReader();

    final resultReader = reader.onLoadEnd.first.then((_) {
      Object? result = reader.result;
      String resultString = result.toString();
      String base64 = resultString.substring(resultString.indexOf(",") + 1);
      final Uint8List bytes = convert.base64.decode(base64);

      final Map<String, Uint8List> mapBytes = {file.name: bytes};

      return mapBytes;
    });

    reader.readAsDataUrl(file);

    return resultReader;
  }
}
