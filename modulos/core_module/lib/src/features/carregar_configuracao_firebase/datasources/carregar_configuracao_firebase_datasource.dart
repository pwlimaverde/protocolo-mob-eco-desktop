import 'package:dependencies_module/dependencies_module.dart';

class CarregarConfiguracaoFirebaseDatasource
    implements Datasource<Map<String, dynamic>> {
  @override
  Future<Map<String, dynamic>> call(
      {required ParametersReturnResult parameters}) async {
    try {
      // final reference = await FirebaseFirestore.instance
      //     .collection("configuracao")
      //     .doc("protocolo")
      //     .get();
      // final configuracao = reference.data();
      // if (configuracao != null) {
      //   return configuracao;
      // } else {
      throw Exception("Erro ao carregar configurações do banco de dados");
      // }
    } catch (e) {
      throw Exception("Erro ao carregar configurações do banco de dados");
    }
  }
}
