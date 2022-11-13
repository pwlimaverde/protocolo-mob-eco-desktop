import 'package:dependencies_module/dependencies_module.dart';

class LeituraArquivoHtmlUsecase
    extends UseCaseImplement<List<Map<String, Uint8List>>> {
  final Datasource<List<Map<String, Uint8List>>> datasource;

  LeituraArquivoHtmlUsecase({
    required this.datasource,
  });

  @override
  Future<ReturnSuccessOrError<List<Map<String, Uint8List>>>> call({
    required ParametersReturnResult parameters,
  }) {
    final result = returnUseCase(
      parameters: parameters,
      datasource: datasource,
    );
    return result;
  }
}
