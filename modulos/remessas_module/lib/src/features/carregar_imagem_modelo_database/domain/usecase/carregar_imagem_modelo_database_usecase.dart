import 'package:dependencies_module/dependencies_module.dart';

class CarregarImagemModeloDatabaseUsecase
    extends UseCaseImplement<ImagemModeloModel> {
  final Datasource<ImagemModeloModel> datasource;

  CarregarImagemModeloDatabaseUsecase({
    required this.datasource,
  });

  @override
  Future<ReturnSuccessOrError<ImagemModeloModel>> call({
    required ParametersReturnResult parameters,
  }) {
    final result = returnUseCase(
      parameters: parameters,
      datasource: datasource,
    );
    return result;
  }
}
