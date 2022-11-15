import 'package:dependencies_module/dependencies_module.dart';

@Entity()
class RemessaModel {
  int id = 0;
  final String nomeArquivo;
  String? tipo = "";
  List<int>? arquivosInvalidos;

  @Property(type: PropertyType.date)
  final DateTime data;

  @Property(type: PropertyType.date)
  final DateTime upload;

  @Backlink()
  final boletos = ToMany<BoletoModel>();

  RemessaModel({
    required this.nomeArquivo,
    this.arquivosInvalidos,
    required this.data,
    required this.upload,
  });

  // Map<String, dynamic> toMap() {
  //   final Map<String, dynamic> map = {
  //     'nomeArquivo': nomeArquivo,
  //     'data': data,
  //     'upload': upload,
  //     'idsClientes': idsClientes,
  //     'Arquivos invalidos': arquivosInvalidos,
  //     'Protocolos ok': arquivosInvalidos,
  //     'Protocolos sem boletos': protocolosSemBoletos,
  //   };
  //   return map;
  // }

  // factory RemessaModel.fromMap(Map<String, dynamic> map) {
  //   final model = RemessaModel(
  //     nomeArquivo: map['nomeArquivo'] ?? '',
  //     data: map['data'],
  //     upload: map['upload'],
  //     idsClientes: map['idsClientes'],
  //     arquivosInvalidos: map['Arquivos invalidos'],
  //     protocolosOk: map['Protocolos ok'],
  //     protocolosSemBoletos: map['Protocolos sem boletos'],
  //   );
  //   return model;
  // }

  // String toJson() => json.encode(toMap());

  // factory RemessaModel.fromJson(String source) =>
  //     RemessaModel.fromMap(json.decode(source));

  @override
  String toString() =>
      'RemessaModel(Id: $id, Nome do arquivo: $nomeArquivo, Upload: $upload, Data: ${dataFormatoDDMMYYYY.format(data)}, Quantidade de protocolos: ${boletos.length})';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is RemessaModel &&
        other.nomeArquivo == nomeArquivo &&
        other.data == data &&
        listEquals(other.boletos, boletos);
  }

  @override
  int get hashCode => nomeArquivo.hashCode ^ data.hashCode ^ boletos.hashCode;
}
