import 'package:dependencies_module/dependencies_module.dart';

class CarregarImagemModeloFirebaseDatasource implements Datasource<Uint8List> {
  @override
  Future<Uint8List> call({required ParametersReturnResult parameters}) async {
    try {
      // final gsReference =
      //     FirebaseStorage.instance.refFromURL(imagemModeloProtocolo);

      // final modelo = await gsReference.getData();
      final modelo = null;

      if (modelo != null) {
        return modelo;
      } else {
        throw Exception(
            "Erro não foi possível localizar imagem modelo no banco de dados");
      }
    } catch (e) {
      throw Exception("Erro ao carregar imagem modelo do banco de dados");
    }
  }
}
