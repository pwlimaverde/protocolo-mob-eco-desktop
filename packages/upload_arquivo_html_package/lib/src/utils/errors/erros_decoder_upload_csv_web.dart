import 'package:dependencies_module/dependencies_module.dart';

class ErroUploadArquivoHtml implements AppError {
  @override
  String message;
  ErroUploadArquivoHtml({
    required this.message,
  });

  @override
  String toString() {
    return "ErroUploadArquivoHtml - $message";
  }
}
