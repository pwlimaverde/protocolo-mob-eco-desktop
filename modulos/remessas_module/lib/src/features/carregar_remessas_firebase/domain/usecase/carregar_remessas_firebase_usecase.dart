import 'package:dependencies_module/dependencies_module.dart';

class CarregarRemessasFirebaseUsecase
    extends UseCaseImplement<Stream<List<RemessaModel>>> {
  final Datasource<Stream<List<RemessaModel>>> datasource;

  CarregarRemessasFirebaseUsecase({
    required this.datasource,
  });

  @override
  Future<ReturnSuccessOrError<Stream<List<RemessaModel>>>> call({
    required ParametersReturnResult parameters,
  }) {
    final result = returnUseCase(
      parameters: parameters,
      datasource: datasource,
    );
    return result;
  }
}
