import 'package:dependencies_module/dependencies_module.dart';

class CarregarImagemModeloFirebaseUsecase extends UseCaseImplement<Uint8List> {
  final Datasource<Uint8List> datasource;

  CarregarImagemModeloFirebaseUsecase({
    required this.datasource,
  });

  @override
  Future<ReturnSuccessOrError<Uint8List>> call({
    required ParametersReturnResult parameters,
  }) {
    final result = returnUseCase(
      parameters: parameters,
      datasource: datasource,
    );
    return result;
  }
}
