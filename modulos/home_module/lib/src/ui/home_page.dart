import 'package:dependencies_module/dependencies_module.dart';
import 'package:flutter/material.dart';
import '../home_controller.dart';
import 'widgets/bodyhome/bodyhome_widget.dart';

class HomePage extends GetView<HomeController> {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final boletoTeste = BoletoModel(
      idCliente: 1234,
      cliente: "Teste Cliente 1",
      idContrato: 5678,
      idFatura: 9123,
    );
    final boletoTeste2 = BoletoModel(
        idCliente: 2234,
        cliente: "Teste Cliente 2",
        idContrato: 5678,
        idFatura: 9123);
    final boletoTeste3 = BoletoModel(
        idCliente: 3234,
        cliente: "Teste Cliente 3",
        idContrato: 5678,
        idFatura: 9123);
    final boletoTeste4 = BoletoModel(
        idCliente: 4234,
        cliente: "Teste Cliente 4",
        idContrato: 5678,
        idFatura: 9123);
    final boletoTeste5 = BoletoModel(
        idCliente: 5234,
        cliente: "Teste Cliente 5",
        idContrato: 5678,
        idFatura: 9123);
    final boletoTeste6 = BoletoModel(
        idCliente: 6234,
        cliente: "Teste Cliente 6",
        idContrato: 5678,
        idFatura: 9123);

    final boletos = [
      boletoTeste,
      boletoTeste2,
      boletoTeste3,
      boletoTeste4,
      boletoTeste5,
      boletoTeste6,
    ];

    final id = dataBaseRemessa.get(5) as RemessaModel;
    // boxBoleto.removeAll();
    // id.boletos.addAll(boletos);
    final teste = id.boletos as List<BoletoModel>;

    // final Box<BoletoModel> teste1 = dataBaseBoleto.put();
    // final teste2 = boxBoleto.put(teste[0]);
    // final teste3 = boxRemessa.put(id);
    // final b1 = boxBoleto.get(3) as BoletoModel;

    // final teste2 = b1.remessa.target;

    // id.boletos.add(b1);
    // boxBoleto.put(boletoTeste2);
    // boxBoleto.put(boletoTeste3);
    // boxBoleto.put(boletoTeste4);
    // boxBoleto.put(boletoTeste5);
    // boxBoleto.put(boletoTeste6);
    // id.boletos.add(boletoTeste);
    // id.boletos.add(boletoTeste2);
    // id.boletos.add(boletoTeste3);

    print(teste[0].id);
    print(teste[0].isVerificado);
    print(id);
    return Container(
      color: Colors.white,
      child: SizedBox(
        height: 100,
        width: 100,
        child: Text("Teste - $id"),
      ),
    );
    // return designSystemController.scaffold(
    //   body: BodyHomeWidget(),
    //   page: 0,
    //   context: context,
    // );
  }
}
