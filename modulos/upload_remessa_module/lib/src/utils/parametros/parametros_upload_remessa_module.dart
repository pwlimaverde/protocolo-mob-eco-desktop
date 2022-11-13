import 'package:dependencies_module/dependencies_module.dart';

class ParametrosUploadRemessa implements ParametersReturnResult {
  final RemessaModel remessaUpload;
  @override
  final AppError error;
  @override
  final bool showRuntimeMilliseconds;
  @override
  final String nameFeature;

  ParametrosUploadRemessa({
    required this.remessaUpload,
    required this.error,
    required this.showRuntimeMilliseconds,
    required this.nameFeature,
  });
}

class ParametrosUploadBoleto implements ParametersReturnResult {
  final BoletoModel boletoUpload;
  @override
  final AppError error;
  @override
  final bool showRuntimeMilliseconds;
  @override
  final String nameFeature;

  ParametrosUploadBoleto({
    required this.boletoUpload,
    required this.error,
    required this.showRuntimeMilliseconds,
    required this.nameFeature,
  });
}

class ParametrosMapeamentoArquivoHtml implements ParametersReturnResult {
  final List<Map<String, Uint8List>> listaMapBytes;
  @override
  final AppError error;
  @override
  final bool showRuntimeMilliseconds;
  @override
  final String nameFeature;

  ParametrosMapeamentoArquivoHtml({
    required this.listaMapBytes,
    required this.error,
    required this.showRuntimeMilliseconds,
    required this.nameFeature,
  });
}

class ParametrosProcessamentoArquivoHtml implements ParametersReturnResult {
  final List<Map<String, Map<String, dynamic>>> listaMapBruta;
  @override
  final AppError error;
  @override
  final bool showRuntimeMilliseconds;
  @override
  final String nameFeature;

  ParametrosProcessamentoArquivoHtml({
    required this.listaMapBruta,
    required this.error,
    required this.showRuntimeMilliseconds,
    required this.nameFeature,
  });
}
