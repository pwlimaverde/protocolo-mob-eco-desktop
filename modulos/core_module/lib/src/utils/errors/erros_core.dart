import 'package:dependencies_module/dependencies_module.dart';

class ErroCarregarConfiguracao implements AppError {
  @override
  String message;
  ErroCarregarConfiguracao({
    required this.message,
  });

  @override
  String toString() {
    return "ErroCarregarConfiguracao - $message";
  }
}
