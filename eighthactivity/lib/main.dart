import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_hooks/flutter_hooks.dart';

var propertys = [
  ["blend_name", "origin", "variety"],
  ["name", "style", "ibu"],
  ["nationality", "language", "capital"]
];
var columns = [
  ["Nome do Blend", "Origem", "Variedade"],
  ["Nome", "Estilo", "IBU"],
  ["Nacionalidade", "Lingua", "Capital"]
];
var indexOUT = 0;
var size = 5;

class DataService {
  final ValueNotifier<List> tableStateNotifier = new ValueNotifier([]);
  var paths = [
    'api/coffee/random_coffee',
    'api/beer/random_beer',
    'api/nation/random_nation',
  ];

  void carregar(index) {
    var res = null;
    var ChoosedUri = Uri(
        scheme: 'https',
        host: 'random-data-api.com',
        path: paths[index],
        queryParameters: {'size': size.toString()});
    res = carregarURI(ChoosedUri);
  }

  Future<void> carregarURI(var ChoosedUri) async {
    var jsonString = await http.read(ChoosedUri);

    var APIJson = jsonDecode(jsonString);

    tableStateNotifier.value = APIJson;
  }
}

final dataService = DataService();

void main() {
  MyApp app = MyApp();

  runApp(app);
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(primarySwatch: Colors.deepPurple),
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          appBar: AppBar(
            actions: <Widget>[
              PopupMenuButton<String>(
                onSelected: handleClick,
                itemBuilder: (BuildContext context) {
                  return {'5', '10', '15'}
                      .map((String choice) {
                    return PopupMenuItem<String>(
                      value: choice,
                      child: Text(choice),
                    );
                  }).toList();
                },
              ),
            ],
          ),
          body: ValueListenableBuilder(
              valueListenable: dataService.tableStateNotifier,
              builder: (_, value, __) {
                return DataTableWidget(
                    jsonObjects: value,
                    propertyNames: propertys[indexOUT],
                    columnNames: columns[indexOUT]);
              }),
          bottomNavigationBar:
              NewNavBar(itemSelectedCallback: dataService.carregar),
        ));
  }

  void handleClick(String value) {
    size = int.parse(value);
  }
}

class NewNavBar extends HookWidget {
  final _itemSelectedCallback;

  NewNavBar({itemSelectedCallback})
      : _itemSelectedCallback = itemSelectedCallback ?? (int) {}

  @override
  Widget build(BuildContext context) {
    var state = useState(1);

    return BottomNavigationBar(
        onTap: (index) {
          state.value = index;
          indexOUT = index;
          _itemSelectedCallback(index);
        },
        currentIndex: state.value,
        items: const [
          BottomNavigationBarItem(
            label: "Cafés",
            icon: Icon(Icons.coffee_outlined),
          ),
          BottomNavigationBarItem(
              label: "Cervejas", icon: Icon(Icons.local_drink_outlined)),
          BottomNavigationBarItem(
              label: "Nações", icon: Icon(Icons.flag_outlined))
        ]);
  }
}

class DataTableWidget extends StatelessWidget {
  final List jsonObjects;

  final List<String> columnNames;

  final List<String> propertyNames;

  DataTableWidget(
      {this.jsonObjects = const [],
      this.columnNames = const ["", "", ""],
      this.propertyNames = const ["", "", ""]});

  @override
  Widget build(BuildContext context) {
    return DataTable(
        columns: columnNames
            .map((name) => DataColumn(
                label: Expanded(
                    child: Text(name,
                        style: TextStyle(fontStyle: FontStyle.italic)))))
            .toList(),
        rows: jsonObjects
            .map((obj) => DataRow(
                cells: propertyNames
                    .map((propName) => DataCell(Text(obj[propName])))
                    .toList()))
            .toList());
  }
}
