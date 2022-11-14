import 'package:dependencies_module/dependencies_module.dart';

@Entity()
class BoletoModel {
  int id = 0;
  bool isVerificado = false;

  final remessa = ToOne<RemessaModel>();

  final int idCliente;
  final String cliente;
  final int? documento;
  final String? email;
  final int? telefoneFixo;
  final int? telefoneMovel;
  final int idContrato;

  @Property(type: PropertyType.date)
  final DateTime? dataHabilitacaoContrato;

  final String? numeroDeBoleto;
  final String? formaDeCobranca;

  @Property(type: PropertyType.date)
  final DateTime? dataVencimentoFatura;

  final double? valorFatura;

  @Property(type: PropertyType.date)
  final DateTime? dataEmissaoFatura;

  final String? arquivo;

  @Property(type: PropertyType.date)
  final DateTime? dataImpressaoFatura;

  final String? uf;
  final String? cidade;
  final String? bairro;
  final String? tipoLogradouro;
  final String? logradouro;
  final String? numero;
  final String? cep;
  final String? solicitanteDaGeracao;
  final int idFatura;
  final String? referencia;
  BoletoModel({
    required this.idCliente,
    required this.cliente,
    this.documento,
    this.email,
    this.telefoneFixo,
    this.telefoneMovel,
    required this.idContrato,
    this.dataHabilitacaoContrato,
    this.numeroDeBoleto,
    this.formaDeCobranca,
    this.dataVencimentoFatura,
    this.valorFatura,
    this.dataEmissaoFatura,
    this.arquivo,
    this.dataImpressaoFatura,
    this.uf,
    this.cidade,
    this.bairro,
    this.tipoLogradouro,
    this.logradouro,
    this.numero,
    this.cep,
    this.solicitanteDaGeracao,
    required this.idFatura,
    this.referencia,
  });

  int quantidadeBoletos = 1;

  void setQuantidadeBoletos() {
    quantidadeBoletos++;
  }

  // Map<String, dynamic> toMap() {
  //   final Map<String, dynamic> map = {
  //     'ID Remessa': idRemessa,
  //     'ID Cliente': idCliente,
  //     'Cliente': cliente,
  //     'Documento': documento,
  //     'Email': email ?? "",
  //     'Telefone Fixo': telefoneFixo,
  //     'Telefone Movel': telefoneMovel,
  //     'ID Contrato': idContrato,
  //     'Data Habilitacao contrato': dataHabilitacaoContrato,
  //     'Número de Boleto': numeroDeBoleto,
  //     'Forma de Cobrança': formaDeCobranca,
  //     'Data Vencimento Fatura': dataVencimentoFatura,
  //     'Valor Fatura': valorFatura,
  //     'Data Emissao Fatura': dataEmissaoFatura,
  //     'Arquivo': arquivo,
  //     'Data Impressão Fatura': dataImpressaoFatura,
  //     'UF': uf,
  //     'Cidade': cidade,
  //     'Bairro': bairro,
  //     'Tipo Logradouro': tipoLogradouro,
  //     'Logradouro': logradouro,
  //     'Numero ': numero,
  //     'CEP': cep,
  //     'Solicitante da Geração': solicitanteDaGeracao,
  //     'ID Fatura': idFatura,
  //     'Referencia': referencia ?? "",
  //     'Quantida de Boletos': _quantidadeBoletos,
  //   };
  //   return map;
  // }

  // List<dynamic> toListXlsx() {
  //   return [
  //     idCliente,
  //     cliente,
  //     documento,
  //     email,
  //     telefoneFixo,
  //     telefoneMovel,
  //     idContrato,
  //     dataHabilitacaoContrato != null
  //         ? dataFormatoDDMMYYYY.format(dataHabilitacaoContrato!)
  //         : "",
  //     numeroDeBoleto,
  //     formaDeCobranca,
  //     dataVencimentoFatura != null
  //         ? dataFormatoDDMMYYYY.format(dataVencimentoFatura!)
  //         : "",
  //     valorFatura != null ? "R\$ ${valorFatura!.toDouble()}" : 0.0,
  //     dataEmissaoFatura != null
  //         ? dataFormatoDDMMYYYY.format(dataEmissaoFatura!)
  //         : "",
  //     arquivo,
  //     dataImpressaoFatura != null
  //         ? dataFormatoDDMMYYYY.format(dataImpressaoFatura!)
  //         : "",
  //     uf,
  //     cidade,
  //     bairro,
  //     tipoLogradouro,
  //     logradouro,
  //     numero,
  //     cep,
  //     solicitanteDaGeracao,
  //     idFatura,
  //     referencia,
  //   ];
  // }

  // String get codigoDeBarras {
  //   final sufixo = coreModuleController.sufixo.toString().substring(0, 3);
  //   final codBoleto = numeroDeBoleto.toString();
  //   String complementoZero = "";
  //   for (var zero = 0; zero < 14 - (codBoleto.length); zero++) {
  //     complementoZero = "${complementoZero}0";
  //   }
  //   final tipo = formaDeCobranca!.contains("CARNE") ? "C" : "B";
  //   const prefixo = "MB";
  //   final padraoNovo = "$prefixo$tipo$complementoZero$codBoleto$sufixo";
  //   return padraoNovo;
  // }

  factory BoletoModel.fromMapCsv({
    required Map<String, dynamic> map,
  }) {
    final boleto = BoletoModel(
      idCliente: int.tryParse(map['ID Cliente'].toString()) ?? 0,
      cliente: map['Cliente'].length <= 8
          ? "Cliente MOB ${int.tryParse(map['Documento'].toString()) ?? 0}"
          : map['Cliente'],
      documento: int.tryParse(map['Documento'].toString()) ?? 0,
      email: map['Email'] ?? '',
      telefoneFixo: int.tryParse(map['Telefone Fixo']) ?? 0,
      telefoneMovel: int.tryParse(map['Telefone Movel']) ?? 0,
      idContrato: int.tryParse(map['ID Contrato'].toString()) ?? 0,
      dataHabilitacaoContrato: map['Data Habilitacao contrato'] != "."
          ? DateTime.parse(map['Data Habilitacao contrato'].split(" ")[0])
          : DateTime.now(),
      numeroDeBoleto: map['Número de Boleto'] ?? '',
      formaDeCobranca: map['Forma de Cobrança'] ?? '',
      dataVencimentoFatura: DateTime.parse(
          "${map['Data Vencimento Fatura'].toString().replaceAll("/", "-").substring(6, 10)}-${map['Data Vencimento Fatura'].toString().replaceAll("/", "-").substring(3, 5)}-${map['Data Vencimento Fatura'].toString().replaceAll("/", "-").substring(0, 2)}"),
      valorFatura: double.tryParse(
          map['Valor Fatura'].split(" ")[1].toString().replaceAll(",", ".")),
      dataEmissaoFatura: DateTime.parse(
        "${map['Data Emissao Fatura'].toString().substring(6, 10)}-${map['Data Emissao Fatura'].toString().substring(3, 5)}-${map['Data Emissao Fatura'].toString().substring(0, 2)}",
      ),
      arquivo: map['Arquivo'] ?? '',
      dataImpressaoFatura: DateTime.parse(
        "${map['Data Impressão Fatura'].toString().substring(6, 10)}-${map['Data Impressão Fatura'].toString().substring(3, 5)}-${map['Data Impressão Fatura'].toString().substring(0, 2)}",
      ),
      uf: map['UF'] ?? '',
      cidade: map['Cidade'] ?? '',
      bairro: map['Bairro'] ?? '',
      tipoLogradouro: map['Tipo Logradouro'] ?? '',
      logradouro: map['Logradouro'] ?? '',
      numero: map['Numero ']?.toString() ?? 's/n',
      cep: map['CEP'] ?? '',
      solicitanteDaGeracao: map['Solicitante da Geração'] ?? '',
      idFatura: int.tryParse(map['ID Fatura'].toString()) ?? 0,
      referencia: map['Referencia'] ?? '',
    );
    return boleto;
  }

  factory BoletoModel.fromMapXlsx({
    required Map<String, dynamic> map,
  }) {
    final boleto = BoletoModel(
      idCliente: int.tryParse(map['ID Cliente'].toString()) ?? 0,
      cliente: map['Cliente'],
      documento: int.tryParse(map['Documento'].toString()) ?? 0,
      email: map['Email'] ?? '',
      telefoneFixo: int.tryParse(map['Telefone Fixo']) ?? 0,
      telefoneMovel: int.tryParse(map['Telefone Movel']) ?? 0,
      idContrato: int.tryParse(map['ID Contrato'].toString()) ?? 0,
      dataHabilitacaoContrato: map['Data Habilitacao contrato'] != "."
          ? DateTime.parse(map['Data Habilitacao contrato'].split(" ")[0])
          : DateTime.now(),
      numeroDeBoleto: map['Número de Boleto'] ?? '',
      formaDeCobranca: map['Forma de Cobrança'] ?? '',
      dataVencimentoFatura:
          DateTime.parse(map['Data Vencimento Fatura'].split(" ")[0]),
      valorFatura: double.tryParse(map['Valor Fatura']),
      dataEmissaoFatura: DateTime.parse(
        "${map['Data Emissao Fatura'].toString().substring(6, 10)}-${map['Data Emissao Fatura'].toString().substring(3, 5)}-${map['Data Emissao Fatura'].toString().substring(0, 2)}",
      ),
      arquivo: map['Arquivo'] ?? '',
      dataImpressaoFatura: DateTime.parse(
        "${map['Data Impressão Fatura'].toString().substring(6, 10)}-${map['Data Impressão Fatura'].toString().substring(3, 5)}-${map['Data Impressão Fatura'].toString().substring(0, 2)}",
      ),
      uf: map['UF'] ?? '',
      cidade: map['Cidade'] ?? '',
      bairro: map['Bairro'] ?? '',
      tipoLogradouro: map['Tipo Logradouro'] ?? '',
      logradouro: map['Logradouro'] ?? '',
      numero: map['Numero ']?.toString() ?? 's/n',
      cep: map['CEP'] ?? '',
      solicitanteDaGeracao: map['Solicitante da Geração'] ?? '',
      idFatura: int.tryParse(map['ID Fatura'].toString()) ?? 0,
      referencia: map['Referencia'] ?? '',
    );
    return boleto;
  }

  // factory BoletoModel.fromMap(Map<String, dynamic> map) {
  //   final boleto = BoletoModel(
  //     idRemessa: map['ID Remessa'],
  //     idCliente: int.tryParse(map['ID Cliente'].toString()) ?? 0,
  //     cliente: map['Cliente'],
  //     documento: int.tryParse(map['Documento'].toString()) ?? 0,
  //     email: map['Email'] ?? '',
  //     telefoneFixo: map['Telefone Fixo'] ?? 0,
  //     telefoneMovel: map['Telefone Movel'] ?? 0,
  //     idContrato: int.tryParse(map['ID Contrato'].toString()) ?? 0,
  //     dataHabilitacaoContrato: map['Data Habilitacao contrato'],
  //     numeroDeBoleto: map['Número de Boleto'] ?? '',
  //     formaDeCobranca: map['Forma de Cobrança'] ?? '',
  //     dataVencimentoFatura: map['Data Vencimento Fatura'],
  //     valorFatura: double.tryParse(map['Valor Fatura'].toString()),
  //     dataEmissaoFatura: map['Data Emissao Fatura'],
  //     arquivo: map['Arquivo'] ?? '',
  //     dataImpressaoFatura: map['Data Impressão Fatura'],
  //     uf: map['UF'] ?? '',
  //     cidade: map['Cidade'] ?? '',
  //     bairro: map['Bairro'] ?? '',
  //     tipoLogradouro: map['Tipo Logradouro'] ?? '',
  //     logradouro: map['Logradouro'] ?? '',
  //     numero: map['Numero ']?.toString() ?? 's/n',
  //     cep: map['CEP'] ?? '',
  //     solicitanteDaGeracao: map['Solicitante da Geração'] ?? '',
  //     idFatura: int.tryParse(map['ID Fatura'].toString()) ?? 0,
  //     referencia: map['Referencia'] ?? '',
  //   );
  //   boleto._quantidadeBoletos = map['Quantida de Boletos'];
  //   return boleto;
  // }

  // String toJson() => json.encode(toMap());

  // factory BoletoModel.fromJson(String source) =>
  //     BoletoModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'BoletoModel(id: $id, remessa: ${remessa.target != null ? remessa.target!.nomeArquivo : "Sem Vinculo"}, idContrato: $idContrato, idCliente: $idCliente, cliente: $cliente, numeroDeBoleto: $numeroDeBoleto, quantidadeDeBoletos: $quantidadeBoletos)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is BoletoModel &&
        other.remessa == remessa &&
        other.idCliente == idCliente &&
        other.cliente == cliente &&
        other.documento == documento &&
        other.email == email &&
        other.telefoneFixo == telefoneFixo &&
        other.telefoneMovel == telefoneMovel &&
        other.idContrato == idContrato &&
        other.dataHabilitacaoContrato == dataHabilitacaoContrato &&
        other.numeroDeBoleto == numeroDeBoleto &&
        other.formaDeCobranca == formaDeCobranca &&
        other.dataVencimentoFatura == dataVencimentoFatura &&
        other.valorFatura == valorFatura &&
        other.dataEmissaoFatura == dataEmissaoFatura &&
        other.arquivo == arquivo &&
        other.dataImpressaoFatura == dataImpressaoFatura &&
        other.uf == uf &&
        other.cidade == cidade &&
        other.bairro == bairro &&
        other.tipoLogradouro == tipoLogradouro &&
        other.logradouro == logradouro &&
        other.numero == numero &&
        other.cep == cep &&
        other.solicitanteDaGeracao == solicitanteDaGeracao &&
        other.idFatura == idFatura &&
        other.referencia == referencia;
  }

  @override
  int get hashCode {
    return remessa.hashCode ^
        idCliente.hashCode ^
        cliente.hashCode ^
        documento.hashCode ^
        email.hashCode ^
        telefoneFixo.hashCode ^
        telefoneMovel.hashCode ^
        idContrato.hashCode ^
        dataHabilitacaoContrato.hashCode ^
        numeroDeBoleto.hashCode ^
        formaDeCobranca.hashCode ^
        dataVencimentoFatura.hashCode ^
        valorFatura.hashCode ^
        dataEmissaoFatura.hashCode ^
        arquivo.hashCode ^
        dataImpressaoFatura.hashCode ^
        uf.hashCode ^
        cidade.hashCode ^
        bairro.hashCode ^
        tipoLogradouro.hashCode ^
        logradouro.hashCode ^
        numero.hashCode ^
        cep.hashCode ^
        solicitanteDaGeracao.hashCode ^
        idFatura.hashCode ^
        referencia.hashCode;
  }
}
