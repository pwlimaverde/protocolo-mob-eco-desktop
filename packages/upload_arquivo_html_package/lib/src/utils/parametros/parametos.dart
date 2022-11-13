import 'package:dependencies_module/dependencies_module.dart';
// ignore: avoid_web_libraries_in_flutter
import 'dart:html' as html;

class ParametrosLeituraArquivoHtml implements ParametersReturnResult {
  final List<html.File> listaArquivosHtml;
  @override
  final AppError error;
  @override
  final bool showRuntimeMilliseconds;
  @override
  final String nameFeature;

  ParametrosLeituraArquivoHtml({
    required this.listaArquivosHtml,
    required this.error,
    required this.showRuntimeMilliseconds,
    required this.nameFeature,
  });
}

class ParametrosLeituraArquivoFilePicker implements ParametersReturnResult {
  final List<Uint8List> listaArquivosFilePicker;
  @override
  final AppError error;
  @override
  final bool showRuntimeMilliseconds;
  @override
  final String nameFeature;

  ParametrosLeituraArquivoFilePicker({
    required this.listaArquivosFilePicker,
    required this.error,
    required this.showRuntimeMilliseconds,
    required this.nameFeature,
  });
}
