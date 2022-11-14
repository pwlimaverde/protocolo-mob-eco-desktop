import 'dart:io';

import 'package:dependencies_module/dependencies_module.dart';

class CarregarArquivoHtmlUsecase extends UseCaseImplement<List<File>> {
  final Datasource<List<File>> datasource;

  CarregarArquivoHtmlUsecase({
    required this.datasource,
  });

  @override
  Future<ReturnSuccessOrError<List<File>>> call({
    required ParametersReturnResult parameters,
  }) {
    final result = returnUseCase(
      parameters: parameters,
      datasource: datasource,
    );
    return result;
  }
}
