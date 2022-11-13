import 'package:dependencies_module/dependencies_module.dart';
import 'features/mapeamento_dados_arquivo_html/datasources/mapeamento_dados_arquivo_html_datasource.dart';
import 'features/mapeamento_dados_arquivo_html/domain/usecase/mapeamento_dados_arquivo_html_usecase.dart';
import 'features/processamento_dados_arquivo_html/datasources/processamento_dados_arquivo_html_datasource.dart';
import 'features/processamento_dados_arquivo_html/domain/usecase/processamento_dados_arquivo_html_usecase.dart';
import 'features/upload_boleto_firebase/datasources/upload_boleto_firebase_datasource.dart';
import 'features/upload_boleto_firebase/domain/usecase/upload_boleto_firebase_usecase.dart';
import 'features/upload_remessa_firebase/datasources/upload_remessa_firebase_datasource.dart';
import 'features/upload_remessa_firebase/domain/usecase/upload_remessa_firebase_usecase.dart';

class UploadRemessaBiding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<UploadRemessaController>(() {
      return UploadRemessaController(
        uploadArquivoHtmlPresenter: UploadArquivoHtmlPresenter(),
        uploadRemessaFirebaseUsecase: UploadRemessaFirebaseUsecase(
          datasource: UploadRemessaFirebaseDatasource(),
        ),
        mapeamentoDadosArquivoHtmlUsecase: MapeamentoDadosArquivoHtmlUsecase(
          datasource: MapeamentoDadosArquivoHtmlDatasource(),
        ),
        processamentoDadosArquivoHtmlUsecase:
            ProcessamentoDadosArquivoHtmlUsecase(
          datasource: ProcessamentoDadosArquivoHtmlDatasource(),
        ),
        uploadBoletoFirebaseUsecase: UploadBoletoFirebaseUsecase(
          datasource: UploadBoletoFirebaseDatasource(),
        ),
      );
    });
  }
}
