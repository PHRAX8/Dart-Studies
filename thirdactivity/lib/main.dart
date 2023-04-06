import 'package:flutter/material.dart';
import 'package:cross_scroll/cross_scroll.dart';
void main() {
  MaterialApp app = MaterialApp(
      theme: ThemeData(primarySwatch: Colors.deepOrange),
      home: Scaffold(
        appBar: AppBar(title: Text("Cervejas")),
        body: CrossScroll(child: newTable()),
      ));
  runApp(app);
}

class newTable extends StatelessWidget {
  const newTable({super.key});

  @override
  Widget build(BuildContext context) {
    return DataTable(
      columns: <DataColumn>[
        newColumn("Consubstanciado"),
        newColumn("Encarecidamente"),
        newColumn("Intangibilidade"),
        newColumn("Extracurricular"),
        newColumn("Interdependente"),
        newColumn("Antropocêntrico"),
        newColumn("Ressocialização"),
        newColumn("Especificamente"),
        newColumn("Fundamentalista"),
      ],
      rows: <DataRow>[
        newDataNineRowCells("65","65","65","65","65","65","65","65","65"),
        newDataNineRowCells("65","65","65","65","65","65","65","65","65"),
        newDataNineRowCells("65","65","65","65","65","65","65","65","65"),
        newDataNineRowCells("65","65","65","65","65","65","65","65","65"),
        newDataNineRowCells("65","65","65","65","65","65","65","65","65"),
        newDataNineRowCells("65","65","65","65","65","65","65","65","65"),
        newDataNineRowCells("65","65","65","65","65","65","65","65","65"),
        newDataNineRowCells("65","65","65","65","65","65","65","65","65"),
        newDataNineRowCells("65","65","65","65","65","65","65","65","65"),
        newDataNineRowCells("65","65","65","65","64","65","65","65","65"),
        newDataNineRowCells("65","65","65","65","65","65","65","65","65"),
        newDataNineRowCells("65","65","65","65","65","65","65","65","65"),
        newDataNineRowCells("65","65","65","65","65","65","65","65","65"),
        newDataNineRowCells("65","65","65","65","65","65","65","65","65"),
        newDataNineRowCells("65","65","65","65","65","65","65","65","65"),
        newDataNineRowCells("65","65","65","65","65","65","65","65","65"),
      ],
    );
  }

  DataRow newDataNineRowCells(String cell1, cell2, cell3, cell4, cell5, cell6, cell7, cell8, cell9) {
    return DataRow(
        cells: <DataCell>[
          DataCell(Text('$cell1')),
          DataCell(Text('$cell2')),
          DataCell(Text('$cell3')),
          DataCell(Text('$cell4')),
          DataCell(Text('$cell5')),
          DataCell(Text('$cell6')),
          DataCell(Text('$cell7')),
          DataCell(Text('$cell8')),
          DataCell(Text('$cell9')),
        ],
      );
  }

  DataColumn newColumn(String text) {
    return DataColumn(
        label: Expanded(
          child: Text(
            '$text',
            style: TextStyle(fontStyle: FontStyle.italic),
          ),
        ),
      );
  }
}