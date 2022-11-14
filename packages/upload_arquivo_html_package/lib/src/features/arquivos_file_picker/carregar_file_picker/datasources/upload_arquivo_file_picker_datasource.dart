import 'package:dependencies_module/dependencies_module.dart';
import 'package:file_picker/file_picker.dart';

class UploadArquivoFilePickerDatasource
    implements Datasource<List<Map<String, Uint8List>>> {
  @override
  Future<List<Map<String, Uint8List>>> call(
      {required ParametersReturnResult parameters}) async {
    try {
      FilePickerResult? result =
          await FilePicker.platform.pickFiles(allowMultiple: true);
      if (result != null) {
        final fileBytes = result.files.map((file) {
          return {file.name: file.bytes!};
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
