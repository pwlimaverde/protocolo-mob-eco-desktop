import 'package:dependencies_module/dependencies_module.dart';

import '../../../utils/parametros/parametros_upload_remessa_module.dart';

class UploadBoletoFirebaseDatasource implements Datasource<bool> {
  @override
  Future<bool> call({required ParametersReturnResult parameters}) async {
    try {
      if (parameters is ParametrosUploadBoleto) {
        // final model = parameters.remessaUpload;
        // print(model);
        // final mapBoleto = parameters.boletoUpload.toMap();

        // await FirebaseFirestore.instance
        //     .collection("remessas")
        //     .doc(parameters.boletoUpload.idRemessa)
        //     .collection("boletos")
        //     .doc(parameters.boletoUpload.idCliente.toString())
        //     .set(mapBoleto);

        return true;
      } else {
        return false;
      }
    } catch (e) {
      throw Exception("Erro ao fazer o upload dos boletos no banco de dados");
    }
  }
}
