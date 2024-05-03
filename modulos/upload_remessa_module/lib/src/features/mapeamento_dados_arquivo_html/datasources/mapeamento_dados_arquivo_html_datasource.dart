import 'package:dependencies_module/dependencies_module.dart';
import 'package:flutter_excel/excel.dart' as flutterexcel;
import 'dart:convert' as convert;

import '../../../utils/parametros/parametros_upload_remessa_module.dart';

class MapeamentoDadosArquivoHtmlDatasource
    implements Datasource<List<Map<String, Map<String, dynamic>>>> {
  @override
  Future<List<Map<String, Map<String, dynamic>>>> call(
      {required ParametersReturnResult parameters}) async {
    if (parameters is ParametrosMapeamentoArquivoHtml) {
      List<Map<String, Uint8List>> mapBytes = parameters.listaMapBytes;

      if (mapBytes.isNotEmpty) {
        List<Map<String, Map<String, dynamic>>> listaArquivos = [];
        for (Map<String, Uint8List> map in mapBytes) {
          final Map<String, Map<String, dynamic>> mapArquivo = {
            "arquivo": _listaProcessada(map: map),
          };
          listaArquivos.add(mapArquivo);
        }
        return listaArquivos;
      } else {
        throw Exception(
            "Erro ao mapear as informaões do arquivo - ${parameters.error}");
      }
    } else {
      throw Exception(
          "Erro ao mapear as informaões do arquivo - - ${parameters.error}");
    }
  }

  Map<String, dynamic> _listaProcessada({
    required Map<String, Uint8List> map,
  }) {
    if (map.keys.first.contains(".csv")) {
      if (map.keys.first.contains("Carnê")) {
        return _processamentoCsv(
          map: map,
        );
      } else {
        return _processamentoCsvNovo(
          map: map,
        );
      }
    } else if (map.keys.first.contains(".xlsx")) {
      return _processamentoXlsx(
        map: map,
      );
    } else {
      throw Exception("Arquivo carregado precisa ter extenção xlsx ou csv");
    }
  }

  Map<String, dynamic> _processamentoXlsx({
    required Map<String, Uint8List> map,
  }) {
    try {
      var excel = flutterexcel.Excel.decodeBytes(map.values.first);
      flutterexcel.Sheet sheetObject = excel[excel.getDefaultSheet()!];
      Map<String, dynamic> mapXlsx = {};
      List<Map<String, String>> mapBoletos = [];
      List<int> idsClienteList = [];

      mapXlsx.addAll({"nome do arquivo": map.keys.first.split(".xlsx")[0]});
      final dataProcessada = DateTime.parse(sheetObject.rows[0][24]?.value);
      mapXlsx.addAll({"data da remessa": dataProcessada});

      mapXlsx.addAll({"tipo do arquivo": "xlsx"});

      if (sheetObject.rows.isNotEmpty) {
        final cabecario = sheetObject.rows[1];
        sheetObject.removeRow(0);
        sheetObject.removeRow(0);

        for (List<flutterexcel.Data?> row in sheetObject.rows) {
          Map<String, String> boletoModelJason = {};
          for (flutterexcel.Data? celula in row) {
            int indexL = row.indexOf(celula);
            boletoModelJason.addAll(
                {"${cabecario[indexL]?.value}": "${celula?.value ?? "."}"});
          }
          final key1 = boletoModelJason.keys.first;
          final value1 =
              int.tryParse(boletoModelJason['ID Cliente'].toString());
          if (key1 == 'ID Cliente' && value1 != null && value1 > 0) {
            final boletoDuplicado = mapBoletos
                    .where((element) =>
                        element['ID Cliente'] == boletoModelJason['ID Cliente'])
                    .length ==
                1;
            if (boletoDuplicado) {
              idsClienteList.add(int.parse(boletoModelJason['ID Cliente']!));
            } else {
              idsClienteList.add(int.parse(boletoModelJason['ID Cliente']!));
              mapBoletos.add(boletoModelJason);
            }
          }
        }
      }
      mapXlsx.addAll({"boletos": mapBoletos});
      mapXlsx.addAll({"ID Clientes": idsClienteList});

      return mapXlsx;
    } catch (e) {
      Map<String, dynamic> mapCatch = {
        "nome do arquivo": map.keys.first.split(".")[0],
        "data da remessa": DateTime.now(),
        "boletos": <Map<String, String>>[],
        "ID Clientes": <Map<String, String>>[],
      };
      return mapCatch;
    }
  }

  Map<String, dynamic> _processamentoCsv({
    required Map<String, Uint8List> map,
  }) {
    try {
      final decoderByte = convert.latin1.decode(map.values.first);
      List<List<dynamic>> listCsv = [];
      List<List<dynamic>> listaDados = [];
      Map<String, dynamic> mapCsv = {};
      List<Map<String, String>> mapBoletos = [];
      List<int> idsClienteList = [];

      listCsv.addAll(
          const CsvToListConverter(fieldDelimiter: ";").convert(decoderByte));

      mapCsv.addAll(
          {"nome do arquivo": "Carnê - ${map.keys.first.split(".csv")[0]}"});
      final DateTime dataProcessada = DateTime.parse(
        "${listCsv[0].last.substring(6, 10)}-${listCsv[0].last.substring(3, 5)}-${listCsv[0].last.substring(0, 2)}",
      );
      mapCsv.addAll({"data da remessa": dataProcessada});
      mapCsv.addAll({"tipo do arquivo": "csv"});

      listaDados.addAll(listCsv);
      listaDados.removeRange(0, 2);
      if (listaDados.isNotEmpty) {
        List<dynamic> cabecario = listCsv[1];
        for (List<dynamic> lista in listaDados) {
          Map<String, String> boletoModelJason = {};
          int index = 0;
          for (dynamic item in lista) {
            boletoModelJason
                .addAll({"${cabecario[index]}": item != "" ? "$item" : "."});
            index++;
          }
          final key1 = boletoModelJason.keys.first;
          final value1 =
              int.tryParse(boletoModelJason['ID Cliente'].toString());
          if (key1 == 'ID Cliente' && value1 != null && value1 > 0) {
            final boletoDuplicado = mapBoletos
                    .where((element) =>
                        element['ID Cliente'] == boletoModelJason['ID Cliente'])
                    .length ==
                1;
            if (boletoDuplicado) {
              idsClienteList.add(int.parse(boletoModelJason['ID Cliente']!));
            } else {
              idsClienteList.add(int.parse(boletoModelJason['ID Cliente']!));
              mapBoletos.add(boletoModelJason);
            }
          }
        }
      }
      mapCsv.addAll({"boletos": mapBoletos});
      mapCsv.addAll({"ID Clientes": idsClienteList});

      return mapCsv;
    } catch (e) {
      Map<String, dynamic> mapCatch = {
        "nome do arquivo": map.keys.first.split(".")[0],
        "data da remessa": DateTime.now(),
        "boletos": <Map<String, String>>[],
        "ID Clientes": <Map<String, String>>[],
      };
      return mapCatch;
    }
  }

  Map<String, dynamic> _processamentoCsvNovo({
    required Map<String, Uint8List> map,
  }) {
    try {
      final decoderByte = convert.latin1.decode(map.values.first);
      List<List<dynamic>> listCsv = [];
      List<List<dynamic>> listaDados = [];
      Map<String, dynamic> mapCsv = {};
      List<Map<String, String>> mapBoletos = [];
      List<int> idsClienteList = [];

      listCsv.addAll(
          const CsvToListConverter(fieldDelimiter: ";").convert(decoderByte));

      mapCsv.addAll(
          {"nome do arquivo": "Boleto - ${map.keys.first.split(".csv")[0]}"});

      final DateTime dataProcessada = DateTime.now();
      mapCsv.addAll({"data da remessa": dataProcessada});
      mapCsv.addAll({"tipo do arquivo": "csv"});

      listaDados.addAll(listCsv);
      listaDados.removeRange(0, 1);

      if (listaDados.isNotEmpty) {
        List<dynamic> cabecario = listCsv[0];
        for (List<dynamic> lista in listaDados) {
          Map<String, String> boletoModelJason = {};
          int index = 0;
          for (dynamic item in lista) {
            if ("${cabecario[index]}" == "ï»¿ID_contrato_AIR") {
              boletoModelJason
                  .addAll({"ID_contrato_AIR": item != "" ? "$item" : "."});
              index++;
            } else {
              boletoModelJason
                  .addAll({"${cabecario[index]}": item != "" ? "$item" : "."});
              index++;
            }
          }
          final key1 = boletoModelJason.keys.first;

          final value1 =
              int.tryParse(boletoModelJason['ID_contrato_AIR'].toString());

          if (key1 == 'ID_contrato_AIR' && value1 != null && value1 > 0) {
            final boletoDuplicado = mapBoletos
                    .where((element) =>
                        element['ID_contrato_AIR'] ==
                        boletoModelJason['ID_contrato_AIR'])
                    .length ==
                1;

            if (boletoDuplicado) {
              idsClienteList
                  .add(int.parse(boletoModelJason['ID_contrato_AIR']!));
            } else {
              idsClienteList
                  .add(int.parse(boletoModelJason['ID_contrato_AIR']!));
              mapBoletos.add(boletoModelJason);
            }
          }
        }
      }
      mapCsv.addAll({"boletos": mapBoletos});

      mapCsv.addAll({"ID Clientes": idsClienteList});

      return mapCsv;
    } catch (e) {
      Map<String, dynamic> mapCatch = {
        "nome do arquivo": map.keys.first.split(".")[0],
        "data da remessa": DateTime.now(),
        "boletos": <Map<String, String>>[],
        "ID Clientes": <Map<String, String>>[],
      };
      return mapCatch;
    }
  }
}
