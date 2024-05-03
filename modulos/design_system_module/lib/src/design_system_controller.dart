import 'dart:convert';
import 'package:core_module/src/services/service/database/db/objectbox.g.dart';

import 'package:dependencies_module/dependencies_module.dart';
import 'package:design_system_module/src/mixins/ui/loading/loading_mixin.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_excel/excel.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/pdf.dart';
import 'package:printing/printing.dart';

import 'mixins/ui/loader/loader_mixin.dart';
import 'mixins/ui/messages/messages_mixin.dart';
import 'widgets/botoes/botao_analise_pdf/botao_analise_pdf_widget.dart';
import 'widgets/botoes/botao_download_relatorio/botao_download_relatorio_widget.dart';
import 'widgets/botoes/botao_download_xlsx/botao_download_xlsx_widget.dart';
import 'widgets/botoes/botao_limpar_analise/botao_limpar_analise_widget.dart';
import 'widgets/botoes/botao_print_protocolo/botao_print_protocolo_widget.dart';
import 'widgets/botoes/botao_upload/botao_upload_widget.dart';
import 'widgets/header/header_widget.dart';
import 'widgets/menu/menu_widget.dart';
import 'widgets/right/right_widget.dart';

class DesignSystemController extends GetxController
    with LoaderMixin, LoadingMixin, MessagesMixin {
  @override
  void onInit() {
    super.onInit();
    loaderListener(
      statusLoad: statusLoad,
    );
    loaingListener(
      loadingValue: _loadValue,
    );
    messageListener(
      message: message,
    );
  }

  //Controller de Loading
  final statusLoad = false.obs;

  final _loadValue = 0.0.obs;

  void setLoading({required double value}) {
    _loadValue(value);
  }

  //Controller de Messages
  final message = Rxn<MessageModel>();

  //Widgets Pages
  Scaffold scaffold({
    required Widget body,
    required int page,
    required BuildContext context,
  }) {
    coreModuleController.getQuery(context: context);

    return Scaffold(
      drawer: coreModuleController.showMenu
          ? Drawer(
              child: MenuWidget(
                page: page,
              ),
            )
          : null,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(hederHeight),
        child: HeaderWidget(
          titulo: "Sistema Protocolos MOB - ECO",
          subtitulo: versaoAtual,
          actions: coreModuleController.pageAtual.value == 2
              ? <Widget>[
                  // _iconButtonSearch(),
                  // _iconButtonPrint(),
                ]
              : coreModuleController.pageAtual.value == 1
                  ? <Widget>[
                      _iconButtonUpload(),
                    ]
                  : [],
        ),
      ),
      backgroundColor: Get.theme.primaryColor,
      body: Column(
        children: <Widget>[
          Obx(() {
            return _body(
              body: body,
              page: page,
            );
          }),
        ],
      ),
    );
  }

  Widget _body({
    required Widget body,
    required int page,
  }) {
    return SizedBox(
      width: coreModuleController.size,
      height: coreModuleController.sizeH,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          coreModuleController.showMenu
              ? RightWidget(
                  widget: SizedBox(
                    width: coreModuleController.sizeW,
                    height: coreModuleController.sizeH,
                    child: body,
                  ),
                  menuWidth: menuWidth,
                  showMenu: coreModuleController.showMenu,
                  sizeW: coreModuleController.sizeW,
                )
              : Row(
                  children: <Widget>[
                    MenuWidget(
                      page: page,
                    ),
                    RightWidget(
                      widget: SizedBox(
                        width: coreModuleController.sizeW,
                        height: coreModuleController.sizeH,
                        child: body,
                      ),
                      menuWidth: menuWidth,
                      showMenu: coreModuleController.showMenu,
                      sizeW: coreModuleController.sizeW,
                    ),
                  ],
                )
        ],
      ),
    );
  }

  Widget botaoPrintProtocolo({required List<BoletoModel> filtro}) {
    return BotaoPrintProtocolo(
      ativo: true,
      size: 40,
      onPressed: () async {
        setLoading(value: 0.001);
        await Future.delayed(const Duration(milliseconds: 500));
        // await _downloadProtocolos(protocolos: filtro);
        setLoading(value: 1);
        await Future.delayed(const Duration(seconds: 1));
        setLoading(value: 0.0);
      },
    );
  }

  Widget botaoDownloadXlsx({required RemessaModel filtro}) {
    return BotaoDownloadXlsx(
      ativo: true,
      size: 40,
      onPressed: () async {
        setLoading(value: 0.001);
        await Future.delayed(const Duration(milliseconds: 500));
        // await _downloadXlsx(filtro: filtro);
        setLoading(value: 1);
        await Future.delayed(const Duration(seconds: 1));
        setLoading(value: 0.0);
      },
    );
  }

  Widget botaoAnalisePdf({required RemessaModel filtro}) {
    return BotaoAnalisePdf(
      ativo: filtro.isOk,
      height: 100,
      width: 100,
      size: 20,
      onPressed: () async {
        setLoading(value: 0.001);
        await Future.delayed(const Duration(milliseconds: 500));
        await _setUploadAnalisePdf(remessa: filtro);
        setLoading(value: 1);
        await Future.delayed(const Duration(seconds: 1));
        setLoading(value: 0.0);
      },
    );
  }

  Future<void> _setUploadAnalisePdf({required RemessaModel remessa}) async {
    if (!remessa.isOk) {
      await remessasController.setUploadNomesArquivos(remessa: remessa);
    } else {
      designSystemController.message(MessageModel.info(
        title: "Analise de Arquivos",
        message: "Arquivos OK!",
      ));
    }
  }

  Widget botaoDownloadRelatorio({required RemessaModel filtro}) {
    return BotaoDownloadRelatorio(
      alerta: filtro.protocolosSemBoletos.isNotEmpty &&
          filtro.protocolosComBoletos.isNotEmpty,
      ativo: filtro.isOk,
      height: 100,
      width: 100,
      size: 20,
      onPressed: () async {
        setLoading(value: 0.001);
        await Future.delayed(const Duration(milliseconds: 500));
        await _downloadAnalise(filtro: filtro);
        setLoading(value: 1);
        await Future.delayed(const Duration(seconds: 1));
        setLoading(value: 0.0);
      },
    );
  }

  Widget botaoLimparAnalise({required RemessaModel filtro}) {
    return BotaoLimparAnalise(
      ativo: filtro.protocolosComBoletos.isNotEmpty ||
          filtro.arquivosInvalidos.isNotEmpty,
      height: 100,
      width: 100,
      size: 20,
      onPressed: () => _limparAnalise(filtro: filtro),
    );
  }

  void _limparAnalise({required RemessaModel filtro}) {
    if (filtro.protocolosComBoletos.isNotEmpty ||
        filtro.arquivosInvalidos.isNotEmpty) {
      remessasController.limparAnalise(idRemessa: filtro.id);
      designSystemController.message(MessageModel.info(
        title: "Limpesa da Analise",
        message: "Dados limpos!",
      ));
    } else {
      designSystemController.message(MessageModel.info(
        title: "Limpesa da Analise",
        message: "Sem dados para limpar!",
      ));
    }
  }

  Widget _iconButtonUpload() {
    return BotaoUpload(
      size: 20,
      onPressed: _setUpload,
    );
  }

  void _setUpload() {
    uploadRemessaController.setUploadRemessas();
  }

  Future<void> _downloadAnalise({required RemessaModel filtro}) async {
    if (!filtro.isOk &&
        filtro.protocolosSemBoletos.isNotEmpty &&
        filtro.protocolosComBoletos.isNotEmpty) {
      final boletos = filtro.protocolosSemBoletos;

      const camposKeys = <String>[
        "ID Cliente",
        "Cliente",
        "Documento",
        "Email",
        "Telefone Fixo",
        "Telefone Movel",
        "ID Contrato",
        "Tipo",
        "Data Habilitacao contrato",
        "Número de Boleto",
        "Forma de Cobrança",
        "Data Vencimento Fatura",
        "Valor Fatura",
        "Data Emissao Fatura",
        "Arquivo",
        "Data Impressão Fatura",
        "UF",
        "Cidade",
        "Bairro",
        "Tipo Logradouro",
        "Logradouro",
        "Numero",
        "CEP",
        "Solicitante da Geração",
        "ID Fatura",
        "Referencia",
      ];

      var excel = Excel.createExcel();

      Sheet sheetObject = excel[excel.getDefaultSheet()!];
      CellStyle cellStyleTitulos = CellStyle(
        horizontalAlign: HorizontalAlign.Center,
        bold: true,
      );

      sheetObject.merge(
          CellIndex.indexByString("A1"), CellIndex.indexByString("X1"),
          customValue:
              "SISTEMA DE REGISTRO DE PROTOCOLO - PROTOCOLOS SEM ARQUIVOS DE BOLETO - ${filtro.nomeArquivo}");

      var titulo = sheetObject
          .cell(CellIndex.indexByColumnRow(columnIndex: 0, rowIndex: 0));
      titulo.cellStyle = cellStyleTitulos;

      var emissao = sheetObject
          .cell(CellIndex.indexByColumnRow(columnIndex: 24, rowIndex: 0));
      emissao.value = "Data Emissão :";
      emissao.cellStyle = cellStyleTitulos;

      var dataEmissao = sheetObject
          .cell(CellIndex.indexByColumnRow(columnIndex: 25, rowIndex: 0));
      dataEmissao.value = dataFormatoDDMMYYYY.format(filtro.data);
      dataEmissao.cellStyle = cellStyleTitulos;

      for (var coluna = 0; coluna < camposKeys.length; coluna++) {
        var cell = sheetObject
            .cell(CellIndex.indexByColumnRow(columnIndex: coluna, rowIndex: 1));
        cell.value = camposKeys[coluna];
        cell.cellStyle = cellStyleTitulos;
      }

      for (BoletoModel boleto in boletos) {
        int indexBoleto = boletos.indexOf(boleto) + 2;
        final listValores = boleto.toListXlsx();
        int indexValor = 0;
        for (dynamic valor in listValores) {
          sheetObject
              .cell(CellIndex.indexByColumnRow(
                  columnIndex: indexValor, rowIndex: indexBoleto))
              .value = valor;
          indexValor++;
        }
      }

      sheetObject.setColWidth(0, 10);
      sheetObject.setColAutoFit(1);
      sheetObject.setColWidth(2, 0);
      sheetObject.setColWidth(3, 0);
      sheetObject.setColWidth(4, 0);
      sheetObject.setColWidth(5, 0);
      sheetObject.setColAutoFit(6);
      sheetObject.setColWidth(7, 0);
      sheetObject.setColWidth(8, 0);
      sheetObject.setColWidth(9, 0);
      sheetObject.setColAutoFit(10);
      sheetObject.setColWidth(11, 0);
      sheetObject.setColWidth(12, 0);
      sheetObject.setColWidth(13, 0);
      sheetObject.setColWidth(14, 0);
      for (var coluna = 15; coluna < camposKeys.length; coluna++) {
        sheetObject.setColAutoFit(coluna);
      }
      sheetObject.setColWidth(17, 30);
      sheetObject.setColWidth(18, 0);
      sheetObject.setColWidth(22, 0);
      sheetObject.setColWidth(24, 12);

      final planilha =
          excel.save(fileName: "${filtro.nomeArquivo} - ERRO FILTRO.xlsx");

      if (planilha != null) {
        await remessasController.saveAndLaunchFile(
            planilha as Uint8List,
            "${filtro.nomeArquivo} - ERRO FILTRO.xlsx",
            boletos[0].remessa.target!.nomeArquivo);
      }
    } else if (!filtro.isOk) {
      designSystemController.message(MessageModel.error(
        title: "Analise de Arquivos",
        message: "Faça o upload dos arquivos em pdf para verificação!",
      ));
    } else {
      designSystemController.message(MessageModel.info(
        title: "Analise de Arquivos",
        message: "Arquivos OK!",
      ));
    }
  }

  Future<void> _downloadXlsx({required RemessaModel filtro}) async {
    final boletos = filtro.boletos;
    const camposKeys = <String>[
      "ID Cliente",
      "Cliente",
      "Documento",
      "Email",
      "Telefone Fixo",
      "Telefone Movel",
      "ID Contrato",
      "Tipo",
      "Data Habilitacao contrato",
      "Número de Boleto",
      "Forma de Cobrança",
      "Data Vencimento Fatura",
      "Valor Fatura",
      "Data Emissao Fatura",
      "Arquivo",
      "Data Impressão Fatura",
      "UF",
      "Cidade",
      "Bairro",
      "Tipo Logradouro",
      "Logradouro",
      "Numero",
      "CEP",
      "Solicitante da Geração",
      "ID Fatura",
      "Referencia",
      "Cód. De Barras",
    ];

    var excel = Excel.createExcel();

    Sheet sheetObject = excel[excel.getDefaultSheet()!];
    CellStyle cellStyleTitulos = CellStyle(
      horizontalAlign: HorizontalAlign.Center,
      bold: true,
    );
    sheetObject.merge(
        CellIndex.indexByString("A1"), CellIndex.indexByString("Y1"),
        customValue:
            "SISTEMA DE REGISTRO DE PROTOCOLO - ${filtro.nomeArquivo}");

    var titulo = sheetObject
        .cell(CellIndex.indexByColumnRow(columnIndex: 0, rowIndex: 0));
    titulo.cellStyle = cellStyleTitulos;

    var emissao = sheetObject
        .cell(CellIndex.indexByColumnRow(columnIndex: 25, rowIndex: 0));
    emissao.value = "Data Emissão :";
    emissao.cellStyle = cellStyleTitulos;

    var dataEmissao = sheetObject
        .cell(CellIndex.indexByColumnRow(columnIndex: 26, rowIndex: 0));
    dataEmissao.value = dataFormatoDDMMYYYY.format(filtro.data);
    dataEmissao.cellStyle = cellStyleTitulos;
    for (var coluna = 0; coluna < camposKeys.length; coluna++) {
      var cell = sheetObject
          .cell(CellIndex.indexByColumnRow(columnIndex: coluna, rowIndex: 1));
      cell.value = camposKeys[coluna];
      cell.cellStyle = cellStyleTitulos;
    }
    for (BoletoModel boleto in boletos) {
      int indexBoleto = boletos.indexOf(boleto) + 2;
      final listValores = boleto.toListXlsx();
      int indexValor = 0;
      for (dynamic valor in listValores) {
        // print(valor);
        sheetObject
            .cell(CellIndex.indexByColumnRow(
                columnIndex: indexValor, rowIndex: indexBoleto))
            .value = valor;
        indexValor++;
      }
      sheetObject
          .cell(CellIndex.indexByColumnRow(
              columnIndex: indexValor, rowIndex: indexBoleto))
          .value = boleto.codigoDeBarras;
    }

    sheetObject.setColWidth(0, 10);
    sheetObject.setColAutoFit(1);
    sheetObject.setColWidth(2, 0);
    sheetObject.setColWidth(3, 0);
    sheetObject.setColWidth(4, 0);
    sheetObject.setColWidth(5, 0);
    sheetObject.setColAutoFit(6);
    sheetObject.setColAutoFit(7);
    sheetObject.setColAutoFit(8);
    sheetObject.setColWidth(9, 0);
    sheetObject.setColWidth(10, 0);
    sheetObject.setColAutoFit(11);
    sheetObject.setColWidth(12, 0);
    sheetObject.setColWidth(13, 0);
    sheetObject.setColWidth(14, 0);
    sheetObject.setColWidth(15, 0);
    for (var coluna = 16; coluna < camposKeys.length; coluna++) {
      sheetObject.setColAutoFit(coluna);
    }
    sheetObject.setColWidth(17, 30);
    sheetObject.setColWidth(18, 30);
    sheetObject.setColWidth(19, 0);
    sheetObject.setColWidth(23, 0);
    sheetObject.setColWidth(25, 25);
    sheetObject.setColWidth(26, 25);

    final planilha =
        excel.save(fileName: "${filtro.nomeArquivo} - FILTRO.xlsx");

    if (planilha != null) {
      await remessasController.saveAndLaunchFile(
          planilha as Uint8List,
          "${filtro.nomeArquivo} - FILTRO.xlsx",
          boletos[0].remessa.target!.nomeArquivo);
    }
  }

  Future<void> _downloadProtocolos(
      {required List<BoletoModel> protocolos}) async {
    final List<BoletoModel> boletos = [];

    for (BoletoModel value in protocolos) {
      boletos.add(value);
    }

    const tamanhoDownload = 1000;
    final quantidadeDeboletos = boletos.length;
    final quantidadeDeArquivos =
        ((quantidadeDeboletos / tamanhoDownload) + 0.4999).round();
    var boletosPart = boletos;

    for (int i = 0; i < quantidadeDeArquivos; i++) {
      final boletosTake = boletosPart.take(tamanhoDownload);
      await _generatePdf2(
          boletos: boletosTake.toList(),
          part: "${i + 1} de $quantidadeDeArquivos");

      if (boletosPart.length > tamanhoDownload) {
        boletosPart.removeRange(0, tamanhoDownload);
      }
    }
  }

  Future<pw.Widget> _protocolosListPrintWidget({
    required String nomeRemessa,
    required List<BoletoModel> boletos,
    required dynamic netImage,
  }) async {
    return pw.SizedBox(
      width: coreModuleController.getSizeProporcao(
        size: coreModuleController.size,
        proporcao: 55,
      ),
      child: pw.ListView.builder(
          itemCount: boletos.length,
          itemBuilder: (context, index) {
            final boletoModel = boletos[index];
            return pw.Container(
              // color: PdfColors.amber,
              width: coreModuleController.getSizeProporcao(
                size: coreModuleController.size,
                proporcao: 50,
              ),
              height: 195,
              child: pw.Stack(
                children: [
                  pw.Center(
                    child: pw.Image(netImage),
                  ),
                  pw.Padding(
                    padding: const pw.EdgeInsets.fromLTRB(0, 0, 3, 8),
                    child: pw.Align(
                      alignment: pw.Alignment.bottomRight,
                      child: pw.Text(
                        nomeRemessa,
                        style: const pw.TextStyle(fontSize: 5.5),
                      ),
                    ),
                  ),
                  pw.Padding(
                    padding: const pw.EdgeInsets.fromLTRB(152, 35, 22, 10),
                    child: pw.Container(
                      width: 325,
                      // color: PdfColors.red,
                      child: pw.Text(
                        "${boletoModel.cliente.toString()} - B. ${boletoModel.bairro.toString()} - ${boletoModel.cidade.toString()} / ${boletoModel.uf.toString()} ${boletoModel.tipoLogradouro.toString()} ${boletoModel.logradouro.toString()}, N.:${boletoModel.numero.toString()} - CEP: ${boletoModel.cep.toString()}",
                        style: const pw.TextStyle(fontSize: 9),
                      ),
                    ),
                  ),
                  _codigoDeBarras(
                    data: boletoModel.codigoDeBarras,
                  ),
                  pw.Padding(
                    padding: const pw.EdgeInsets.fromLTRB(0, 8, 3, 0),
                    child: pw.Align(
                      alignment: pw.Alignment.topRight,
                      child: pw.Text(
                        "${boletoModel.idContrato.toString()} - ${boletoModel.quantidadeBoletos < 10 ? "0${boletoModel.quantidadeBoletos.toString()}" : boletoModel.quantidadeBoletos.toString()} b",
                        style: const pw.TextStyle(fontSize: 8),
                      ),
                    ),
                  ),
                  pw.Padding(
                    padding: const pw.EdgeInsets.fromLTRB(15, 60, 22, 10),
                    child: pw.Align(
                      alignment: pw.Alignment.topRight,
                      child: pw.Text(
                        dataFormatoDDMMYYYY.format(
                          boletoModel.dataVencimentoFatura!,
                        ),
                        style: const pw.TextStyle(fontSize: 9),
                      ),
                    ),
                  ),
                  pw.Padding(
                    padding: const pw.EdgeInsets.fromLTRB(6, 35, 5, 10),
                    child: pw.Align(
                      alignment: pw.Alignment.bottomLeft,
                      child: pw.Container(
                        width: 127,
                        // color: PdfColors.amber,
                        child: pw.Column(
                          children: [
                            pw.Text(
                              boletoModel.idCliente.toString(),
                              style: const pw.TextStyle(fontSize: 10),
                            ),
                            pw.Text(
                              "${boletoModel.cliente.toString()} - B. ${boletoModel.bairro.toString()} - ${boletoModel.cidade.toString()} / ${boletoModel.uf.toString()} ${boletoModel.tipoLogradouro.toString()} ${boletoModel.logradouro.toString()}, N.:${boletoModel.numero.toString()} - CEP: ${boletoModel.cep.toString()}${boletoModel.referencia.toString() != "null" ? " - REF.:${boletoModel.referencia}" : ""}",
                              style: const pw.TextStyle(fontSize: 8),
                            ),
                            pw.Text(
                              "Remetente:\nMOBTELECOM\nAV. Abolição, 4140 - Mucuripe\nFortaleza - CE\n60165-082",
                              style: const pw.TextStyle(fontSize: 8),
                            ),
                          ],
                          crossAxisAlignment: pw.CrossAxisAlignment.start,
                          mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          }),
    );
  }

  pw.Widget _codigoDeBarras({
    required String data,
  }) {
    final double larguraCodigoDeBarras =
        (data.toString().length * 10.5).toDouble();
    return pw.Padding(
      padding: const pw.EdgeInsets.fromLTRB(10, 10, 10, 83),
      child: pw.Container(
        // color: PdfColors.red100,
        child: pw.Row(
          children: [
            pw.Align(
                alignment: pw.Alignment.bottomLeft,
                child: pw.SizedBox(
                  child: pw.BarcodeWidget(
                    data: data.toString(),
                    width: larguraCodigoDeBarras,
                    height: 45,
                    barcode: pw.Barcode.code128(),
                    drawText: true,
                  ),
                  width: larguraCodigoDeBarras,
                  height: 45,
                )),
            pw.SizedBox(width: 10),
            pw.SizedBox(
              child: pw.BarcodeWidget(
                data: data.toString(),
                width: 45,
                height: 45,
                barcode: pw.Barcode.qrCode(),
                drawText: false,
              ),
              width: 45,
              height: 45,
            ),
            pw.SizedBox(width: 126),
          ],
          crossAxisAlignment: pw.CrossAxisAlignment.end,
          mainAxisAlignment: pw.MainAxisAlignment.end,
        ),
      ),
    );
  }

  Future<pw.Widget> _listaConferenciaPrintWidget({
    required List<BoletoModel> boletos,
  }) async {
    return pw.SizedBox(
      width: coreModuleController.getSizeProporcao(
        size: coreModuleController.size,
        proporcao: 55,
      ),
      child: pw.ListView.builder(
          itemCount: boletos.length,
          itemBuilder: (context, index) {
            final boletoModel = boletos[index];
            return pw.Container(
              decoration: pw.BoxDecoration(
                color: (index % 2) == 0 ? PdfColors.white : PdfColors.grey200,
                border: const pw.Border(
                  top: pw.BorderSide(width: 0.5, color: PdfColors.black),
                  bottom: pw.BorderSide(width: 0.5, color: PdfColors.black),
                ),
              ),
              width: coreModuleController.getSizeProporcao(
                size: coreModuleController.size,
                proporcao: 50,
              ),
              height: 12,
              child: pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                children: [
                  pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.spaceAround,
                    children: [
                      pw.SizedBox(
                        width: 25,
                        child: pw.Container(
                            alignment: pw.Alignment.centerRight,
                            child: pw.Text(
                              "${(index + 1)}",
                              style: const pw.TextStyle(fontSize: 10),
                            )),
                      ),
                      pw.SizedBox(
                        width: 10,
                      ),
                      pw.SizedBox(
                        width: 270,
                        child: pw.Container(
                            child: pw.Text(
                          boletoModel.cliente,
                          style: const pw.TextStyle(fontSize: 10),
                        )),
                      ),
                    ],
                  ),
                  pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.spaceAround,
                    children: [
                      pw.SizedBox(
                        width: 100,
                        child: pw.Container(
                            child: pw.Text(
                          "ID Cliente: ${boletoModel.idCliente.toString()}",
                          style: const pw.TextStyle(fontSize: 9),
                        )),
                      ),
                      pw.SizedBox(
                        width: 100,
                        child: pw.Container(
                            child: pw.Text(
                          "ID Contrato: ${boletoModel.idContrato.toString()}",
                          style: const pw.TextStyle(fontSize: 9),
                        )),
                      ),
                      pw.SizedBox(
                        width: 35,
                        child: pw.Container(
                            alignment: pw.Alignment.centerRight,
                            child: pw.Text(
                              "Boletos: ",
                              style: const pw.TextStyle(fontSize: 9),
                            )),
                      ),
                      pw.SizedBox(
                        width: 15,
                        child: pw.Container(
                            alignment: pw.Alignment.centerLeft,
                            child: pw.Text(
                              boletoModel.quantidadeBoletos < 10
                                  ? "0${boletoModel.quantidadeBoletos.toString()}"
                                  : boletoModel.quantidadeBoletos.toString(),
                              style: const pw.TextStyle(fontSize: 9),
                            )),
                      ),
                    ],
                  ),
                ],
              ),
            );
          }),
    );
  }

  Future<void> _generatePdf2(
      {required List<BoletoModel> boletos, required String part}) async {
    final pdf = pw.Document(version: PdfVersion.pdf_1_5, compress: true);

    final netImage = pw.MemoryImage(
      remessasController.imagemModelo!,
    );

    final testeFuturo = <Future<pw.Widget>>[
      _protocolosListPrintWidget(
        nomeRemessa: boletos[0].remessa.target!.nomeArquivo,
        netImage: netImage,
        boletos: boletos,
      ),
      _listaConferenciaPrintWidget(boletos: boletos)
    ];

    final Iterable<Future<pw.Widget>> processarWidgetFuturo =
        testeFuturo.map((arquivo) => arquivo);

    final Future<Iterable<pw.Widget>> waitedWidget =
        Future.wait(processarWidgetFuturo);

    final widgetPdfs = await waitedWidget.then((value) => value.toList());

    pdf.addPage(
      pw.MultiPage(
        maxPages: 260,
        pageFormat: PdfPageFormat.a4.copyWith(
          marginBottom: 10,
          marginLeft: 20,
          marginRight: 20,
          marginTop: 20,
        ),
        build: (context) {
          return [
            pw.SizedBox(height: 10),
            widgetPdfs[0],
            pw.SizedBox(height: 10),
          ];
        },
      ),
    );

    pdf.addPage(
      pw.MultiPage(
        maxPages: 20,
        pageFormat: PdfPageFormat.a4.copyWith(
          marginBottom: 10,
          marginLeft: 20,
          marginRight: 20,
          marginTop: 20,
        ),
        build: (context) => [
          pw.SizedBox(height: 10),
          pw.Text(
            "Lista para conferencia - ${boletos[0].remessa.target!.nomeArquivo} - $part",
            style: const pw.TextStyle(fontSize: 10),
          ),
          pw.SizedBox(height: 10),
          widgetPdfs[1],
        ],
      ),
    );

    final protocolosPdf = await pdf.save();

    await remessasController.saveAndLaunchFile(
        protocolosPdf,
        "$part - ${boletos[0].remessa.target!.nomeArquivo} - Protocolos.pdf",
        boletos[0].remessa.target!.nomeArquivo);
  }
}
