import 'package:dependencies_module/dependencies_module.dart';

class CarregarConfiguracaoFirebaseUsecase
    extends UseCaseImplement<Map<String, dynamic>> {
  final Datasource<Map<String, dynamic>> datasource;

  CarregarConfiguracaoFirebaseUsecase({
    required this.datasource,
  });

  @override
  Future<ReturnSuccessOrError<Map<String, dynamic>>> call({
    required ParametersReturnResult parameters,
  }) {
    final result = returnUseCase(
      parameters: parameters,
      datasource: datasource,
    );
    return result;
  }
}
