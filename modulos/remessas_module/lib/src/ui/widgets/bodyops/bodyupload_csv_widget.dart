import 'package:dependencies_module/dependencies_module.dart';
import 'package:flutter/material.dart';

class BodyUploadRemessaWidget extends StatelessWidget {
  const BodyUploadRemessaWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: coreModuleController.sizeH,
      child: Container(
        color: Colors.black12,
        child: Center(
          child: Obx(() {
            return Column(
              children: <Widget>[
                _tabBar(),
                _tabBarView(),
              ],
            );
          }),
        ),
      ),
    );
  }
}

_tabBar() {
  return Container(
    height: tabHeight,
    color: Colors.red[200],
    child: TabBar(
      controller: remessasController.tabController,
      labelColor: Colors.white,
      indicatorColor: Colors.grey[800],
      labelStyle: const TextStyle(
        color: Colors.white,
        fontSize: 13,
      ),
      tabs: coreModuleController.showMenu
          ? remessasController.myTabsSmall
          : remessasController.myTabs,
    ),
  );
}

_tabBarView() {
  return SizedBox(
    width: coreModuleController.sizeW,
    height: coreModuleController.sizeH - tabHeight,
    child: TabBarView(
      controller: remessasController.tabController,
      children: [
        // Center(),
        _todasRemessasList()
      ],
    ),
  );
}

_todasRemessasList() {
  final filtro = remessasController.listTadasRemessas;

  return Obx(
    () => Center(
      child: ListView.builder(
        itemCount: filtro.length,
        itemBuilder: (context, index) {
          final remessaModel = filtro[index];
          String nomeRemessa = remessaModel.nomeArquivo.length >= 100
              ? remessaModel.nomeArquivo.substring(0, 100)
              : remessaModel.nomeArquivo;
          return Center(
            child: Dismissible(
              key: Key(remessaModel.id.toString()),
              direction: DismissDirection.endToStart,
              onDismissed: (direction) => {
                remessasController.removerRemessa(idRemessa: remessaModel.id),
              },
              background: Container(
                alignment: AlignmentDirectional.centerEnd,
                color: Colors.redAccent,
                child: const Padding(
                  padding: EdgeInsets.fromLTRB(0.0, 0.0, 10.0, 0.0),
                  child: Icon(
                    Icons.delete,
                    color: Colors.white,
                  ),
                ),
              ),
              child: GestureDetector(
                onLongPress: () =>
                    remessasController.tipoRemessa(idRemessa: remessaModel.id),
                child: Card(
                  color: remessaModel.tipo == "RE"
                      ? const Color.fromARGB(255, 247, 196, 130)
                      : remessaModel.nomeArquivo.contains("Boleto")
                          ? Colors.grey[300]
                          : Colors.white,
                  elevation: 0.5,
                  child: SizedBox(
                    width: 900,
                    child: ListTile(
                      title: remessaModel.tipo == "RE"
                          ? Text("RENOVAÇÃO - $nomeRemessa")
                          : Text(nomeRemessa),
                      subtitle: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Data da Remessa: ${dataFormatoDDMMYYYY.format(remessaModel.data)}",
                          ),
                          Text(
                            "Data de Upload: ${dataFormatoDDMMYYYY.format(remessaModel.upload)}",
                          ),
                          Text(
                            "Quantidade de Protocolos: ${remessaModel.boletos.length.toString()}",
                          ),
                          remessaModel.arquivosInvalidos.isNotEmpty
                              ? Text(
                                  "Arquivos inválidos: ${remessaModel.arquivosInvalidos.toString()}",
                                  style: const TextStyle(color: Colors.red),
                                )
                              : Container(),
                          // Padding(
                          //   padding: const EdgeInsets.all(15.0),
                          //   child: LinearPercentIndicator(
                          //     animation: true,
                          //     lineHeight: 20.0,
                          //     animationDuration: 2000,
                          //     percent: posicao.value,
                          //     center: Text("${posicao * 100} %"),
                          //     progressColor: Colors.greenAccent,
                          //   ),
                          // ),
                        ],
                      ),
                      trailing: SizedBox(
                        width: 300,
                        height: 100,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            designSystemController.botaoPrintProtocolo(
                              filtro: remessaModel.boletos,
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            designSystemController.botaoDownloadXlsx(
                              filtro: remessaModel,
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            designSystemController.botaoAnalisePdf(
                              filtro: remessaModel,
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            designSystemController.botaoDownloadRelatorio(
                              filtro: remessaModel,
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            designSystemController.botaoLimparAnalise(
                              filtro: remessaModel,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    ),
  );
}
