import 'package:dependencies_module/dependencies_module.dart';

import '../../../utils/parametros/parametros_remessas_module.dart';

class CarregarBoletosFirebaseDatasource
    implements Datasource<List<BoletoModel>> {
  @override
  Future<List<BoletoModel>> call(
      {required ParametersReturnResult parameters}) async {
    try {
      if (parameters is ParametrosCarregarBoletos) {
        final getBoletos = FirebaseFirestore.instance
            .collection("remessas")
            .doc(parameters.remessaCarregada.id)
            .collection("boletos")
            .get();

        final boletos = getBoletos.then((value) {
          List<BoletoModel> list =
              value.docs.map((e) => BoletoModel.fromMap(e.data())).toList();
          return list;
        });

        // teste3.listen((event) {
        //   print("******");
        //   print(event);
        //   print("******");
        // });

        return boletos;
      } else {
        throw Exception(
            "Erro ao carregar os dados dos boletos do banco de dados");
      }
    } catch (e) {
      throw Exception(
          "Erro ao carregar os dados dos boletos do banco de dados");
    }
  }
}
