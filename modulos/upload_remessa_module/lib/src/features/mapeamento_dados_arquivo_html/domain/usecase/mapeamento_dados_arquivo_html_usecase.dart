import 'package:dependencies_module/dependencies_module.dart';

class MapeamentoDadosArquivoHtmlUsecase
    extends UseCaseImplement<List<Map<String, Map<String, dynamic>>>> {
  final Datasource<List<Map<String, Map<String, dynamic>>>> datasource;

  MapeamentoDadosArquivoHtmlUsecase({
    required this.datasource,
  });

  @override
  Future<ReturnSuccessOrError<List<Map<String, Map<String, dynamic>>>>> call({
    required ParametersReturnResult parameters,
  }) {
    final result = returnUseCase(
      parameters: parameters,
      datasource: datasource,
    );
    return result;
  }
}
