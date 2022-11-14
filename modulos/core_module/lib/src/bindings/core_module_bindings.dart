import 'package:core_module/src/entities/imagem_modelo_model.dart';
import 'package:dependencies_module/dependencies_module.dart';

import '../features/carregar_configuracao_firebase/datasources/carregar_configuracao_firebase_datasource.dart';
import '../features/carregar_configuracao_firebase/domain/usecase/carregar_configuracao_firebase_usecase.dart';

class CoreModuleBindings implements Bindings {
  @override
  void dependencies() {
    Get.put<CoreModuleController>(
      CoreModuleController(
        carregarConfiguracaoFirebaseUsecase:
            CarregarConfiguracaoFirebaseUsecase(
          datasource: CarregarConfiguracaoFirebaseDatasource(),
        ),
      ),
      permanent: true,
    );
    Get.put<Box<RemessaModel>>(
      dataBase.box<RemessaModel>(),
      permanent: true,
    );
    Get.put<Box<BoletoModel>>(
      dataBase.box<BoletoModel>(),
      permanent: true,
    );
    Get.put<Box<ImagemModeloModel>>(
      dataBase.box<ImagemModeloModel>(),
      permanent: true,
    );
    Get.put<DesignSystemController>(
      DesignSystemController(),
      permanent: true,
    );
    Get.put<RemessasController>(
      RemessasController(
        carregarRemessasFirebaseUsecase: CarregarRemessasFirebaseUsecase(
          datasource: CarregarRemessasFirebaseDatasource(),
        ),
        carregarBoletosFirebaseUsecase: CarregarBoletosFirebaseUsecase(
          datasource: CarregarBoletosFirebaseDatasource(),
        ),
        mapeamentoNomesArquivoHtmlUsecase: MapeamentoNomesArquivoHtmlUsecase(
          datasource: MapeamentoNomesArquivoHtmlDatasource(),
        ),
        uploadArquivoHtmlPresenter: UploadArquivoHtmlPresenter(),
        uploadAnaliseArquivosFirebaseUsecase:
            UploadAnaliseArquivosFirebaseUsecase(
          datasource: UploadAnaliseArquivosFirebaseDatasource(),
        ),
        limparAnaliseArquivosFirebaseUsecase:
            LimparAnaliseArquivosFirebaseUsecase(
          datasource: LimparAnaliseArquivosFirebaseDatasource(),
        ),
        carregarImagemModeloDatabaseUsecase:
            CarregarImagemModeloDatabaseUsecase(
          datasource: CarregarImagemModeloDatabaseDatasource(),
        ),
      ),
      permanent: true,
    );
  }
}
