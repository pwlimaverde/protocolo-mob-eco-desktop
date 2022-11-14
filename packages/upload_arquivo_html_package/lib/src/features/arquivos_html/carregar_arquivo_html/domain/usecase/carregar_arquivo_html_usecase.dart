import 'package:dependencies_module/dependencies_module.dart';

class CarregarArquivoHtmlUsecase extends UseCaseImplement<List<html.File>> {
  final Datasource<List<html.File>> datasource;

  CarregarArquivoHtmlUsecase({
    required this.datasource,
  });

  @override
  Future<ReturnSuccessOrError<List<html.File>>> call({
    required ParametersReturnResult parameters,
  }) {
    final result = returnUseCase(
      parameters: parameters,
      datasource: datasource,
    );
    return result;
  }
}
