import 'package:dependencies_module/dependencies_module.dart';
import '../features/arquivos_file_picker/carregar_file_picker/datasources/upload_arquivo_file_picker_datasource.dart';
import '../features/arquivos_file_picker/carregar_file_picker/domain/usecase/carregar_arquivo_file_picker_usecase.dart';
import '../utils/errors/erros_decoder_upload_csv_web.dart';

class UploadArquivoHtmlPresenter
    implements Presenter<List<Map<String, Uint8List>>> {
  @override
  Future<ReturnSuccessOrError<List<Map<String, Uint8List>>>> call(
      {required ParametersReturnResult parameters}) async {
    final remessa = _leituraArquivoFilePicker();

    return remessa;
  }

  Future<ReturnSuccessOrError<List<Map<String, Uint8List>>>>
      _leituraArquivoFilePicker() async {
    final leitura = await CarregarArquivoFilePickerUsecase(
      datasource: UploadArquivoFilePickerDatasource(),
    )(
        parameters: NoParams(
      error: ErroUploadArquivoHtml(
        message: 'Teste Error',
      ),
      showRuntimeMilliseconds: true,
      nameFeature: "Teste FilePicker",
    ));
    return leitura;
  }
}
