import 'dart:io';

import 'package:archive/archive.dart';
import 'package:dependencies_module/dependencies_module.dart';
import 'package:flutter/material.dart';
import 'package:remessas_module/src/utils/errors/erros_remessas.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';
import 'utils/parametros/parametros_remessas_module.dart';

class RemessasController extends GetxController
    with GetSingleTickerProviderStateMixin {
  final CarregarImagemModeloDatabaseUsecase carregarImagemModeloDatabaseUsecase;
  final UploadArquivoHtmlPresenter uploadArquivoHtmlPresenter;
  final CarregarRemessasDatabaseUsecase carregarRemessasDatabaseUsecase;
  final RemoverRemessaDatabaseUsecase removerRemessaDatabaseUsecase;
  final TipoRemessaDatabaseUsecase tipoRemessaDatabaseUsecase;
  final MapeamentoNomesArquivoHtmlUsecase mapeamentoNomesArquivoHtmlUsecase;
  final LimparAnaliseArquivosFirebaseUsecase
      limparAnaliseArquivosFirebaseUsecase;
  final UploadAnaliseArquivosFirebaseUsecase
      uploadAnaliseArquivosFirebaseUsecase;
  RemessasController({
    required this.carregarImagemModeloDatabaseUsecase,
    required this.uploadArquivoHtmlPresenter,
    required this.carregarRemessasDatabaseUsecase,
    required this.removerRemessaDatabaseUsecase,
    required this.tipoRemessaDatabaseUsecase,
    required this.mapeamentoNomesArquivoHtmlUsecase,
    required this.limparAnaliseArquivosFirebaseUsecase,
    required this.uploadAnaliseArquivosFirebaseUsecase,
  });

  final List<Tab> myTabs = <Tab>[
    const Tab(text: "Todas Remessas"),
  ];

  final List<Tab> myTabsSmall = <Tab>[
    const Tab(text: "Remessas"),
  ];

  late TabController _tabController;

  TabController get tabController => _tabController;

  @override
  void onInit() async {
    super.onInit();
    _tabController = TabController(vsync: this, length: myTabs.length);
  }

  @override
  void onReady() {
    super.onReady();
    _carregarImagemModelo();
    _carregarRemessas();
  }

  @override
  InternalFinalCallback<void> get onDelete {
    _clearLists();
    return super.onDelete;
  }

  final _imagemModelo = Rxn<Uint8List>();

  Uint8List? get imagemModelo => _imagemModelo.value;

  final _listTadasRemessas = <RemessaModel>[].obs;

  Future<void> _carregarImagemModelo() async {
    final modelo = await carregarImagemModeloDatabaseUsecase(
      parameters: NoParams(
        error: ErroUploadArquivo(
          message: "Erro ao Erro ao carregar os arquivos.",
        ),
        showRuntimeMilliseconds: true,
        nameFeature: "Carregamento de Arquivo",
      ),
    );
    if (modelo.status == StatusResult.success) {
      final image = modelo.result as ImagemModeloModel;
      _imagemModelo(image.arquivo);
    }
  }

  List<RemessaModel> get listTadasRemessas => _listTadasRemessas
    ..sort(
      (a, b) => b.data.compareTo(a.data),
    );

  void _clearLists() {
    listTadasRemessas.clear();
  }

  Future<void> removerRemessa({required int idRemessa}) async {
    await removerRemessaDatabaseUsecase(
      parameters: ParametrosRemoverRemessa(
        idRemessa: idRemessa,
        error: ErroRemoveRemessa(message: "Erro ao remover a remessa"),
        showRuntimeMilliseconds: true,
        nameFeature: "Remover Remessa",
      ),
    );
  }

  Future<void> tipoRemessa({required int idRemessa}) async {
    await tipoRemessaDatabaseUsecase(
      parameters: ParametrosAlterarRemessa(
        idRemessa: idRemessa,
        error: ErroRemoveRemessa(message: "Erro ao alterar a remessa"),
        showRuntimeMilliseconds: true,
        nameFeature: "Tipo Remessa",
      ),
    );
  }

  Future<void> setUploadNomesArquivos({required RemessaModel remessa}) async {
    designSystemController.setLoading(value: 0.0001);
    await _uploadNomesArquivos(
      arquivosDaRemessa:
          await compute(_mapeamentoDadosArquivo, await _carregarArquivos()),
      remessa: remessa,
    );
    designSystemController.setLoading(value: 1.0);
    Future.delayed(const Duration(seconds: 2))
        .then((value) => designSystemController.setLoading(value: 0.0));
  }

  Future<void> limparAnalise({
    required String idRemessa,
  }) async {
    await limparAnaliseArquivosFirebaseUsecase(
      parameters: ParametrosLimparAnaliseArquivos(
        error: ErroUploadArquivo(
            message:
                "Erro ao fazer o upload da Remessa para o banco de dados!"),
        showRuntimeMilliseconds: true,
        nameFeature: "upload firebase",
        idRemessa: idRemessa,
      ),
    );
  }

  Future<void> _uploadNomesArquivos({
    required List<Map<int, Uint8List>> arquivosDaRemessa,
    required RemessaModel remessa,
  }) async {
    try {
      designSystemController.setLoading(value: 0.26);
      final boletosOrdenados = remessa.boletos;

      if (arquivosDaRemessa.isNotEmpty) {
        List<dynamic> idsArquivosRemessa = [];
        List<Uint8List> arquivos = [];
        List<Map<String, dynamic>> arquivosOk = [];
        int indexArquivoOk = 0;
        List<int> idsOk = [];
        List<int> idsError = [];
        // List<dynamic> idsCliente = remessa.idsClientes;
        List<int> arquivosInvalidos = [];

        // final testeOK = remessa.protocolosOk;

        // if (testeOK != null) {
        //   for (dynamic element in testeOK) {
        //     idsOk.add(element);
        //   }
        // }

        for (Map<int, Uint8List> element in arquivosDaRemessa) {
          idsArquivosRemessa.add(element.keys.first);
        }

        for (BoletoModel boleto in boletosOrdenados) {
          final idCompare = int.tryParse(boleto.idCliente.toString());
          final compare = arquivosDaRemessa
              .where((element) => element.keys.first == idCompare)
              .map((arquivo) => arquivo.values.first)
              .toList();
          arquivos.addAll(compare);
          if (idCompare != null) {
            if (compare.isNotEmpty) {
              final compareOk =
                  idsOk.where((element) => element == idCompare).length == 1;
              if (!compareOk) {
                idsOk.add(idCompare);
                for (Uint8List pdf in compare) {
                  arquivosOk.add({
                    "ID Cliente": idCompare,
                    "Cliente": boleto.cliente,
                    "Arquivo": pdf,
                    "Index": indexArquivoOk,
                  });
                  indexArquivoOk++;
                }
              }
            } else {
              final compareError =
                  idsOk.where((element) => element == idCompare).length == 1;
              if (!compareError) {
                idsError.add(idCompare);
              }
            }
          }
        }

        // for (int arquivo in idsArquivosRemessa) {
        //   final compare =
        //       idsCliente.where((element) => element == arquivo).length == 1;
        //   if (!compare) {
        //     arquivosInvalidos.add(arquivo);
        //   }
        // }

        idsOk.sort(
          (a, b) => a.compareTo(b),
        );

        final Map<String, List<int>> result = {
          "Protocolos ok": idsOk,
          "Protocolos sem boletos": idsError,
          "Arquivos invalidos": arquivosInvalidos
        };
        designSystemController.setLoading(value: 0.30);
        _enviarNovaAnalise(
          analise: result,
          model: remessa,
        );
        designSystemController.setLoading(value: 0.35);
        _processamentoPdf(
            arquivosPdfOk: arquivosOk, nomeRemessa: remessa.nomeArquivo);
      }
    } catch (e) {
      designSystemController.setLoading(value: 0.0);
      designSystemController.message(
        MessageModel.error(
          title: 'Upload de Remessa',
          message: 'Erro ao fazer o Upload da Remessa!',
        ),
      );
      throw Exception("Erro ao fazer o Upload da Remessa!");
    }
  }

  Future<void> _processamentoPdf({
    required List<Map<String, dynamic>> arquivosPdfOk,
    required String nomeRemessa,
  }) async {
    designSystemController.setLoading(value: 0.55);
    final Iterable<Future<Map<String, Uint8List>>> salvarPdfFuturo =
        arquivosPdfOk.map((arquivo) => compute(_salvarPdf, arquivo));

    final Future<Iterable<Map<String, Uint8List>>> waitedRemessas =
        Future.wait(salvarPdfFuturo);

    final pdfs = await waitedRemessas.then((value) => value.toList());
    designSystemController.setLoading(value: 0.70);

    compute(_downloadFilesAsZIP, {"files": pdfs, "nomeRemessa": nomeRemessa});
    designSystemController.setLoading(value: 0.95);
  }

  Future<Map<String, Uint8List>> _salvarPdf(
    Map<String, dynamic> mapArquivoPdf,
  ) async {
    final PdfDocument document =
        PdfDocument(inputBytes: mapArquivoPdf["Arquivo"]);
    document.pageSettings.margins = PdfMargins()..all = 5;
    final List<int> bytes = document.saveSync();
    Map<String, Uint8List> map = {
      '${mapArquivoPdf["Index"] + 1} - ${mapArquivoPdf["ID Cliente"]} - ${mapArquivoPdf["Cliente"]}.pdf':
          Uint8List.fromList(bytes)
    };
    return map;
  }

  Future<void> saveAndLaunchFile(
      Uint8List bytes, String fileName, String remessaNome) async {
    Directory docDir = await getApplicationDocumentsDirectory();
    var pathList = docDir.path.split("\\");
    pathList[3] = "Downloads";
    var downloadPath = pathList.getRange(0, 4).join("\\");
    var testeFile = await File(join(downloadPath, remessaNome, fileName))
        .create(recursive: true);
    await testeFile.writeAsBytes(bytes);
  }

  _downloadFilesAsZIP(Map<String, dynamic> zips) {
    final files = zips["files"];
    final nomeRemessa = zips["nomeRemessa"];
    const tamanhoDownload = 500;
    final quantidadeDePdfs = files.length;
    final quantidadeDeZips =
        ((quantidadeDePdfs / tamanhoDownload) + 0.4999).round();
    var filesPart = files;

    for (int i = 0; i < quantidadeDeZips; i++) {
      final testeLoading = ((i + 1) * 100) / quantidadeDeZips;
      final testeLoading2 = (testeLoading * 25) / 100;
      designSystemController.setLoading(
          value: 0.7 + (testeLoading2 / 100).round());
      print(0.7 + (testeLoading2 / 100));
      final teste = filesPart.take(tamanhoDownload);
      var encoder = ZipEncoder();
      var archive = Archive();

      for (Map<String, Uint8List> file in teste) {
        ArchiveFile archiveFiles = ArchiveFile.noCompress(file.keys.first,
            file.values.first.lengthInBytes, file.values.first);
        archive.addFile(archiveFiles);
      }

      final outputStream = OutputStream(
        byteOrder: LITTLE_ENDIAN,
      );
      final bytes = encoder.encode(archive,
          level: Deflate.BEST_COMPRESSION, output: outputStream);

      // saveAndLaunchFile(bytes!,
      //     "${i + 1} de $quantidadeDeZips - Remessa ordenada - $nomeRemessa.zip");

      if (filesPart.length > tamanhoDownload) {
        filesPart.removeRange(0, tamanhoDownload);
      }
    }
  }

  Future<bool> _enviarNovaAnalise({
    required RemessaModel model,
    required Map<String, List<int>> analise,
  }) async {
    final uploadFirebase = await compute(
        _uploadAnalise,
        ParametrosUploadAnaliseArquivos(
          error: ErroUploadArquivo(
              message:
                  "Erro ao fazer o upload da Remessa para o banco de dados!"),
          showRuntimeMilliseconds: true,
          nameFeature: "upload firebase",
          mapAliseArquivos: analise,
          remessa: model,
        ));
    // final uploadFirebase2 = await uploadAnaliseArquivosFirebaseUsecase(
    //   parameters: ParametrosUploadAnaliseArquivos(
    //     error: ErroUploadArquivo(
    //         message:
    //             "Erro ao fazer o upload da Remessa para o banco de dados!"),
    //     showRuntimeMilliseconds: true,
    //     nameFeature: "upload firebase",
    //     mapAliseArquivos: analise,
    //     remessa: model,
    //   ),
    // );
    if (uploadFirebase.status == StatusResult.success) {
      return true;
    } else {
      designSystemController.setLoading(value: 0.0);
      designSystemController.message(
        MessageModel.error(
          title: 'Upload de Analise Firebase',
          message: 'Erro enviar o Analise para o banco de dados!',
        ),
      );
      throw Exception("Erro enviar a Analise para o banco de dados!");
    }
  }

  Future<ReturnSuccessOrError<bool>> _uploadAnalise(
      ParametrosUploadAnaliseArquivos parametros) async {
    final result = await uploadAnaliseArquivosFirebaseUsecase(
      parameters: parametros,
    );
    return result;
  }

  Future<List<Map<int, Uint8List>>> _mapeamentoDadosArquivo(
      List<Map<String, Uint8List>> listaMapBytes) async {
    designSystemController.setLoading(value: 0.05);
    final mapeamento = await mapeamentoNomesArquivoHtmlUsecase(
      parameters: ParametrosMapeamentoArquivoHtml(
        error: ErroUploadArquivo(
          message: "Erro ao mapear os arquivos.",
        ),
        nameFeature: 'Mapeamento Arquivo',
        showRuntimeMilliseconds: true,
        listaMapBytes: listaMapBytes,
      ),
    );
    if (mapeamento.status == StatusResult.success) {
      designSystemController.setLoading(value: 0.2);
      return mapeamento.result;
    } else {
      designSystemController.setLoading(value: 0.0);
      designSystemController.message(
        MessageModel.error(
          title: 'Mapeamento de arquivos',
          message: 'Erro ao mapear os arquivos.',
        ),
      );
      throw Exception("Erro ao mapear os arquivos.");
    }
  }

  Future<List<Map<String, Uint8List>>> _carregarArquivos() async {
    designSystemController.setLoading(value: 0.001);
    final arquivos = await uploadArquivoHtmlPresenter(
      parameters: NoParams(
        error: ErroUploadArquivo(
          message: "Erro ao Erro ao carregar os arquivos.",
        ),
        showRuntimeMilliseconds: true,
        nameFeature: "Carregamento de Arquivo",
      ),
    );
    designSystemController.setLoading(value: 0.01);
    if (arquivos.status == StatusResult.success) {
      return arquivos.result;
    } else {
      designSystemController.setLoading(value: 0.0);
      designSystemController.message(
        MessageModel.error(
          title: 'Carregamento de arquivos',
          message: 'Erro ao carregar os arquivos',
        ),
      );
      throw Exception("Erro ao carregar os arquivos");
    }
  }

  Future<void> _carregarRemessas() async {
    _clearLists();
    final uploadFirebase = await carregarRemessasDatabaseUsecase(
      parameters: NoParams(
        error: ErroUploadArquivo(message: "Error ao carregar as remessas"),
        showRuntimeMilliseconds: true,
        nameFeature: "Carregar Remessas",
      ),
    );

    if (uploadFirebase.status == StatusResult.success) {
      _listTadasRemessas.bindStream(uploadFirebase.result);
    }
  }
}
