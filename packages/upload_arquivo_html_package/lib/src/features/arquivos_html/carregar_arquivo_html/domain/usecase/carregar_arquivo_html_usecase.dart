import 'package:dependencies_module/dependencies_module.dart';
// ignore: avoid_web_libraries_in_flutter
import 'dart:html' as html;

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
