import 'package:dependencies_module/dependencies_module.dart';

class ErroUploadRemessa implements AppError {
  @override
  String message;
  ErroUploadRemessa({
    required this.message,
  });

  @override
  String toString() {
    return "ErroUploadRemessa - $message";
  }
}

class ErroUploadBoleto implements AppError {
  @override
  String message;
  ErroUploadBoleto({
    required this.message,
  });

  @override
  String toString() {
    return "ErroUploadBoleto - $message";
  }
}

class ErroUploadArquivo implements AppError {
  @override
  String message;
  ErroUploadArquivo({
    required this.message,
  });

  @override
  String toString() {
    return "ErroUploadRemessa - $message";
  }
}
