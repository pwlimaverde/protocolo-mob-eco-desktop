import 'dart:io';
import 'package:dependencies_module/dependencies_module.dart';

class UploadArquivoFilePickerDatasource
    implements Datasource<List<Map<String, Uint8List>>> {
  @override
  Future<List<Map<String, Uint8List>>> call(
      {required ParametersReturnResult parameters}) async {
    try {
      FilePickerResult? result =
          await FilePicker.platform.pickFiles(allowMultiple: true);

      if (result != null) {
        List<File> files = result.paths.map((path) => File(path!)).toList();
        final fileBytes = files.map((file) {
          final String nomeCompleto = basename(file.path);
          final String nome = nomeCompleto.contains(".csv")
              ? nomeCompleto.split(".csv")[0]
              : nomeCompleto.contains(".xlsx")
                  ? nomeCompleto.split(".xlsx")[0]
                  : nomeCompleto.contains(".pdf")
                      ? nomeCompleto.split(".pdf")[0]
                      : "Arquivo Invalido";
          final Uint8List bytes = file.readAsBytesSync();

          return {nome: bytes};
        }).toList();
        return fileBytes;
      } else {
        throw Exception("erro ao carregar arquivo");
      }
    } catch (e) {
      throw Exception("erro ao carregar arquivo");
    }
  }
}
