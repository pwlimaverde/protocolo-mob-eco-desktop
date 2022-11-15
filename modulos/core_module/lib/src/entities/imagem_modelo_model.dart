import 'package:dependencies_module/dependencies_module.dart';

@Entity()
class ImagemModeloModel {
  int id = 0;

  @Property(type: PropertyType.byteVector)
  Uint8List arquivo;

  ImagemModeloModel(this.arquivo);

  @override
  String toString() {
    return 'ImagemModeloModel(id: $id)';
  }
}
