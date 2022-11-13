import 'package:dependencies_module/dependencies_module.dart';

class ProcessamentoDadosArquivoHtmlUsecase
    extends UseCaseImplement<Map<String, List<Map<String, dynamic>>>> {
  final Datasource<Map<String, List<Map<String, dynamic>>>> datasource;

  ProcessamentoDadosArquivoHtmlUsecase({
    required this.datasource,
  });

  @override
  Future<ReturnSuccessOrError<Map<String, List<Map<String, dynamic>>>>> call({
    required ParametersReturnResult parameters,
  }) {
    final result = returnUseCase(
      parameters: parameters,
      datasource: datasource,
    );
    return result;
  }
}
