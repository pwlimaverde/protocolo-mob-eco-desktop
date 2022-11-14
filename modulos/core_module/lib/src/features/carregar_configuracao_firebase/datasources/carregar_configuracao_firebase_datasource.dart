import 'package:dependencies_module/dependencies_module.dart';

class CarregarConfiguracaoFirebaseDatasource
    implements Datasource<Map<String, dynamic>> {
  @override
  Future<Map<String, dynamic>> call(
      {required ParametersReturnResult parameters}) async {
    try {
      final configuracao = await dataBaseFireBase
          .collection("configuracao")
          .document("protocolo")
          .get()
          .then((value) => value.map);

      if (configuracao.isNotEmpty) {
        return configuracao;
      } else {
        throw Exception("Erro ao carregar configurações do banco de dados");
      }
    } catch (e) {
      throw Exception("Erro ao carregar configurações do banco de dados");
    }
  }
}
