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

        final Iterable<Future<Map<String, Uint8List>>> readFileFuturo =
            files.map((arquivo) => _readFile(arquivo));

        final Future<Iterable<Map<String, Uint8List>>> waitedreadFileFuturo =
            Future.wait(readFileFuturo);

        final waited =
            await waitedreadFileFuturo.then((value) => value.toList());

        // final fileBytes = files.map((file) {
        //   final Uint8List bytes = file.readAsBytesSync();

        //   return {basename(file.path): bytes};
        // }).toList();

        return waited;
      } else {
        throw Exception("erro ao carregar arquivo");
      }
    } catch (e) {
      throw Exception("erro ao carregar arquivo");
    }
  }

  Future<Map<String, Uint8List>> _readFile(File file) async {
    final result = file.readAsBytesSync();
    final nome = basename(file.path);
    return {nome: result};
  }
}
