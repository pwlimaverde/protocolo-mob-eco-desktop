import 'package:dependencies_module/dependencies_module.dart';
import 'package:flutter/material.dart';
import 'package:flutter_excel/excel.dart';

// ignore: must_be_immutable
class BodyHomeWidget extends StatelessWidget {
  BodyHomeWidget({Key? key}) : super(key: key);

  int rows = 5;

  void exportExel() {
    var excel = Excel.createExcel();
    Sheet sheetObject = excel[excel.getDefaultSheet()!];

    for (var row = 0; row < rows; row++) {
      sheetObject
          .cell(CellIndex.indexByColumnRow(columnIndex: 0, rowIndex: row))
          .value = "Sec";
      sheetObject
          .cell(CellIndex.indexByColumnRow(columnIndex: 0, rowIndex: row))
          .value = 1;
      sheetObject
          .cell(CellIndex.indexByColumnRow(columnIndex: 0, rowIndex: row))
          .value = 2;
      sheetObject
          .cell(CellIndex.indexByColumnRow(columnIndex: 0, rowIndex: row))
          .value = 3;
      sheetObject
          .cell(CellIndex.indexByColumnRow(columnIndex: 0, rowIndex: row))
          .value = 4;
    }

    // for (var table in excel.tables.keys) {
    //   print(table); //sheet Name
    //   print(excel.tables[table]?.maxCols);
    //   print(excel.tables[table]?.maxRows);
    //   for (var row in excel.tables[table]!.rows) {
    //     print("$row");
    //   }
    // }

    // excel.save(fileName: "teste.xlsx");
  }

  @override
  Widget build(BuildContext context) {
    exportExel();
    return SizedBox(
      height: coreModuleController.sizeH,
      child: Container(
        color: Colors.black12,
        child: const Center(
          child: Text(
            "Bem vindo.",
            style: TextStyle(fontSize: 30),
          ),
        ),
      ),
    );
  }
}
