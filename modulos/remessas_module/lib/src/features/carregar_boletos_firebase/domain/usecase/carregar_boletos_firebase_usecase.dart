import 'package:dependencies_module/dependencies_module.dart';

class CarregarBoletosFirebaseUsecase
    extends UseCaseImplement<List<BoletoModel>> {
  final Datasource<List<BoletoModel>> datasource;

  CarregarBoletosFirebaseUsecase({
    required this.datasource,
  });

  @override
  Future<ReturnSuccessOrError<List<BoletoModel>>> call({
    required ParametersReturnResult parameters,
  }) {
    final result = returnUseCase(
      parameters: parameters,
      datasource: datasource,
    );
    return result;
  }
}
