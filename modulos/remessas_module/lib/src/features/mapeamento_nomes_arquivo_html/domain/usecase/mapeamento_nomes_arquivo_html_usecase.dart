import 'package:dependencies_module/dependencies_module.dart';

class MapeamentoNomesArquivoHtmlUsecase
    extends UseCaseImplement<List<Map<int, Uint8List>>> {
  final Datasource<List<Map<int, Uint8List>>> datasource;

  MapeamentoNomesArquivoHtmlUsecase({
    required this.datasource,
  });

  @override
  Future<ReturnSuccessOrError<List<Map<int, Uint8List>>>> call({
    required ParametersReturnResult parameters,
  }) {
    final result = returnUseCase(
      parameters: parameters,
      datasource: datasource,
    );
    return result;
  }
}
