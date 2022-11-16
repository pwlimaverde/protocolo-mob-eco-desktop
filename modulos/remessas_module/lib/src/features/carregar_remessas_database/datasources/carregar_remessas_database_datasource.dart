import 'package:dependencies_module/dependencies_module.dart';

class CarregarRemessasDatabaseDatasource
    implements Datasource<Stream<List<RemessaModel>>> {
  @override
  Future<Stream<List<RemessaModel>>> call(
      {required ParametersReturnResult parameters}) async {
    try {
      final todasTemessas = dataBaseRemessa
          .query()
          .watch(triggerImmediately: true)
          .map((query) => query.find());

      return todasTemessas;
    } catch (e) {
      throw Exception(
          "Erro ao carregar os dados das remessas no banco de dados");
    }
  }
}
