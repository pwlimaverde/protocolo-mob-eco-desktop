import 'package:dependencies_module/dependencies_module.dart';

import '../../../utils/parametros/parametros_remessas_module.dart';

class UploadAnaliseArquivosFirebaseDatasource implements Datasource<bool> {
  @override
  Future<bool> call({required ParametersReturnResult parameters}) async {
    try {
      if (parameters is ParametrosUploadAnaliseArquivos) {
        // final model = parameters.remessaUpload;
        // print(model);
        // final mapBoleto = parameters.mapAliseArquivos;

        // await FirebaseFirestore.instance
        //     .collection("remessas")
        //     .doc(parameters.remessa.id)
        //     .update(mapBoleto);

        return true;
      } else {
        return false;
      }
    } catch (e) {
      throw Exception("Erro ao fazer o upload dos boletos no banco de dados");
    }
  }
}
