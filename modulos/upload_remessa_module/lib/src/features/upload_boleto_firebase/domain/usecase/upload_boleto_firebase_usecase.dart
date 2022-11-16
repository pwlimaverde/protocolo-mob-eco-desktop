import 'package:dependencies_module/dependencies_module.dart';

class UploadBoletoFirebaseUsecase extends UseCaseImplement<bool> {
  final Datasource<bool> datasource;

  UploadBoletoFirebaseUsecase({
    required this.datasource,
  });

  @override
  Future<ReturnSuccessOrError<bool>> call({
    required ParametersReturnResult parameters,
  }) {
    final result = returnUseCase(
      parameters: parameters,
      datasource: datasource,
    );
    return result;
  }
}
