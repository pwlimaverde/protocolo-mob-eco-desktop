import 'package:dependencies_module/dependencies_module.dart';

import '../../../utils/parametros/parametros_upload_remessa_module.dart';

class UploadRemessaFirebaseDatasource implements Datasource<bool> {
  @override
  Future<bool> call({required ParametersReturnResult parameters}) async {
    try {
      if (parameters is ParametrosUploadRemessa) {
        // final model = parameters.remessaUpload;
        // print(model);
        // final mapRemessa = parameters.remessaUpload.toMap();

        // await FirebaseFirestore.instance
        //     .collection("remessas")
        //     .doc(parameters.remessaUpload.id)
        //     .set(mapRemessa);

        return true;
      } else {
        return false;
      }
    } catch (e) {
      throw Exception("Erro ao fazer o upload das remessas no banco de dados");
    }
  }
}
