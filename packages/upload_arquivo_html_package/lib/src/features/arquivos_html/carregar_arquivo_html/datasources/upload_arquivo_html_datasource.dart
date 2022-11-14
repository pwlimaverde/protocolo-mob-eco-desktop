import 'package:dependencies_module/dependencies_module.dart';

class UploadArquivoHtmlDatasource implements Datasource<List<html.File>> {
  @override
  Future<List<html.File>> call(
      {required ParametersReturnResult parameters}) async {
    final uploadInput = html.FileUploadInputElement();
    uploadInput.multiple = true;
    uploadInput.click();
    final result = await uploadInput.onChange.first.then((_) async {
      List<html.File>? files = uploadInput.files;
      if (files != null && files.isNotEmpty) {
        return files;
      } else {
        throw Exception("Erro ao carregar arquivo");
      }
    });
    return result;
  }
}
