import 'package:dependencies_module/dependencies_module.dart';
import 'package:flutter/services.dart';

class CarregarImagemModeloDatabaseDatasource
    implements Datasource<ImagemModeloModel> {
  @override
  Future<ImagemModeloModel> call(
      {required ParametersReturnResult parameters}) async {
    try {
      final linkModelo = await dataBaseFireBase
          .collection("configuracao")
          .document("protocolo")
          .get()
          .then((value) => value["linkmodelo"]);

      final ByteData imageData =
          await NetworkAssetBundle(Uri.parse(linkModelo)).load("");

      final Uint8List bytes = imageData.buffer.asUint8List();
      
      if (bytes.isNotEmpty) {
        final image = dataBaseImagem.get(1)??ImagemModeloModel(bytes);
        image.arquivo = bytes;
        dataBaseImagem.put(image);
        return image;
      } else {
        final image = dataBaseImagem.get(1) as ImagemModeloModel;
        return image;
      }
    } catch (e) {
      throw Exception("Erro ao carregar imagem modelo do banco de dados");
    }
  }
}
