import 'package:dependencies_module/dependencies_module.dart';

class CarregarRemessasFirebaseUsecase
    extends UseCaseImplement<List<RemessaModel>> {
  final Datasource<List<RemessaModel>> datasource;

  CarregarRemessasFirebaseUsecase({
    required this.datasource,
  });

  @override
  Future<ReturnSuccessOrError<List<RemessaModel>>> call({
    required ParametersReturnResult parameters,
  }) {
    final result = returnUseCase(
      parameters: parameters,
      datasource: datasource,
    );
    return result;
  }
}
