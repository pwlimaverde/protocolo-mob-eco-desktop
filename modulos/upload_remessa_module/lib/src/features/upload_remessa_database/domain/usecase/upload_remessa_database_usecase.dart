import 'package:dependencies_module/dependencies_module.dart';

class UploadRemessaDatabaseUsecase extends UseCaseImplement<RemessaModel> {
  final Datasource<RemessaModel> datasource;

  UploadRemessaDatabaseUsecase({
    required this.datasource,
  });

  @override
  Future<ReturnSuccessOrError<RemessaModel>> call({
    required ParametersReturnResult parameters,
  }) {
    final result = returnUseCase(
      parameters: parameters,
      datasource: datasource,
    );
    return result;
  }
}
