import 'package:flutter/material.dart';

import 'package:flutter_hooks/flutter_hooks.dart';

var check = 1;

class DataService {
  final ValueNotifier<List> tableStateNotifier = new ValueNotifier([]);
  List<String> ColumnList = [""];
  List<String> PropertyList = [""];

  void carregar(index) {
    if (index == 0) carregarCafes();
    if (index == 1) carregarCervejas();
    if (index == 2) carregarNacoes();
  }

  void carregarCafes() {
    PropertyList = [
      "id",
      "uid",
      "blend_name",
      "origin",
      "variety",
      "notes",
      "intensifier"
    ];

    ColumnList = [
      "ID",
      "UID",
      "Nome do Blend",
      "Origem",
      "Variedade",
      "Notas",
      "Intensificador"
    ];

    tableStateNotifier.value = [
      {
        "id": "5028",
        "uid": "afb487c3-b126-4d7f-9cb7-a6f5136b858e",
        "blend_name": "Express Cup",
        "origin": "Colima, Mexico",
        "variety": "Kaffa",
        "notes": "mild, smooth, passion fruit, black cherry, molasses",
        "intensifier": "complex"
      },
      {
        "id": "371",
        "uid": "d2bc1448-3064-4c18-8172-a0ebafc501c4",
        "blend_name": "Summer America",
        "origin": "Cacahuatique, El Salvador",
        "variety": "Gesha",
        "notes": "deep, watery, olive, honey, meyer lemon",
        "intensifier": "dull"
      },
      {
        "id": "2672",
        "uid": "f73069d7-9266-4709-a3df-0ac59338f661",
        "blend_name": "Captain's Town",
        "origin": "Travancore, India",
        "variety": "Villalobos",
        "notes": "crisp, coating, coconut, musty, concord grape",
        "intensifier": "rounded"
      },
      {
        "id": "4002",
        "uid": "42798097-cdda-47d9-95fa-af3a4db264a1",
        "blend_name": "Spilt Enlightenment",
        "origin": "Northern Region, Oldeani, Tanzania",
        "variety": "Gesha",
        "notes": "mild, chewy, pecan, plum, rubber",
        "intensifier": "quick"
      },
      {
        "id": "7140",
        "uid": "ee1e7cdf-f3e3-481d-a92e-c7f1b6828b35",
        "blend_name": "Thanksgiving Solstice",
        "origin": "Copan, Honduras",
        "variety": "Ethiopian Heirloom",
        "notes": "structured, round, figs, mandarin, jasmine",
        "intensifier": "bright"
      }
    ];
  }

  void carregarCervejas() {
    PropertyList = [
      "id",
      "uid",
      "brand",
      "name",
      "style",
      "hop",
      "yeast",
      "malts",
      "ibu",
      "alcohol",
      "blg"
    ];

    ColumnList = [
      "ID",
      "UID",
      "Marca",
      "Nome",
      "Estilo",
      "Lúpulo",
      "Levedura",
      "Maltes",
      "IBU",
      "Álcool",
      "BLG"
    ];

    tableStateNotifier.value = [
      {
        "id": "6105",
        "uid": "22007997-60aa-4072-8a49-a18ec437a1a7",
        "brand": "Coors lite",
        "name": "Samuel Smith’s Imperial IPA",
        "style": "German Wheat And Rye Beer",
        "hop": "Galena",
        "yeast": "2042 - Danish Lager",
        "malts": "Carapils",
        "ibu": "47 IBU",
        "alcohol": "8.2%",
        "blg": "18.3°Blg"
      },
      {
        "id": "3467",
        "uid": "d8e6bd91-7b7d-46d5-832c-e238d3827f34",
        "brand": "Samuel Adams",
        "name": "Hercules Double IPA",
        "style": "Amber Hybrid Beer",
        "hop": "Crystal",
        "yeast": "3724 - Belgian Saison",
        "malts": "Carapils",
        "ibu": "52 IBU",
        "alcohol": "6.2%",
        "blg": "12.1°Blg"
      },
      {
        "id": "8714",
        "uid": "d790d391-3e47-4817-b176-fa6cfb78794e",
        "brand": "Sierra Nevada",
        "name": "Pliny The Elder",
        "style": "Pilsner",
        "hop": "Fuggle",
        "yeast": "1388 - Belgian Strong Ale",
        "malts": "Carapils",
        "ibu": "66 IBU",
        "alcohol": "3.8%",
        "blg": "8.9°Blg"
      },
      {
        "id": "8995",
        "uid": "8d3d3c0f-5cd5-4b9e-ab74-1f310b3fc699",
        "brand": "Paulaner",
        "name": "Yeti Imperial Stout",
        "style": "English Brown Ale",
        "hop": "Columbia",
        "yeast": "3711 - French Saison",
        "malts": "Pale",
        "ibu": "45 IBU",
        "alcohol": "4.7%",
        "blg": "16.0°Blg"
      },
      {
        "id": "672",
        "uid": "b54bab78-9f46-4fdf-afa0-8b2b9bbc7a07",
        "brand": "Rolling Rock",
        "name": "90 Minute IPA",
        "style": "European Amber Lager",
        "hop": "Olympic",
        "yeast": "1388 - Belgian Strong Ale",
        "malts": "Chocolate",
        "ibu": "12 IBU",
        "alcohol": "3.0%",
        "blg": "9.8°Blg"
      }
    ];
  }

  void carregarNacoes() {
    PropertyList = [
      "id",
      "uid",
      "nationality",
      "language",
      "capital",
      "national_sport",
      "flag"
    ];

    ColumnList = [
      "ID",
      "UID",
      "Nacionalidade",
      "Idioma",
      "Capital",
      "Esporte Nacional",
      "Bandeira"
    ];

    tableStateNotifier.value = [
      {
        "id": "6141",
        "uid": "eb4f5c5e-8a2b-4050-abaf-c612886bcba2",
        "nationality": "Kosovo Albanians",
        "language": "Marathi",
        "capital": "Dhaka",
        "national_sport": "taekwondo",
        "flag": "🇳🇿"
      },
      {
        "id": "6995",
        "uid": "2a4c63c5-1b6a-4979-bce2-0f0bdb8dcd01",
        "nationality": "Arubans",
        "language": "Telugu",
        "capital": "Phnom Penh",
        "national_sport": "wrestling",
        "flag": "🇫🇲"
      },
      {
        "id": "1171",
        "uid": "cfaf9bc9-09b4-4fc4-9ac5-dceb1be15e3d",
        "nationality": "Slovaks",
        "language": "Portuguese",
        "capital": "Georgetown",
        "national_sport": "dandi biyo",
        "flag": "🇨🇩"
      },
      {
        "id": "6480",
        "uid": "7dcd3a45-a2e1-4f2e-892a-86b02693d4ba",
        "nationality": "Filipinos",
        "language": "Hindi",
        "capital": "Paramaribo",
        "national_sport": "oil wrestling",
        "flag": "🇬🇭"
      },
      {
        "id": "6426",
        "uid": "045da14d-59d9-42ca-8075-433862cc01ca",
        "nationality": "Iraqis",
        "language": "Romanian",
        "capital": "Colombo",
        "national_sport": "oil wrestling",
        "flag": "🇲🇼"
      }
    ];
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
            title: const Text("Dicas"),
          ),
          body: ValueListenableBuilderSelector(),
          bottomNavigationBar:
              NewNavBar(itemSelectedCallback: dataService.carregar),
        ));
  }
}

class ValueListenableBuilderSelector extends StatelessWidget {
  const ValueListenableBuilderSelector({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: dataService.tableStateNotifier,
        builder: (_, value, __) {
          if (check == 0) {
            return DataTableWidget.cafes(
                jsonObjects: value,
                propertyNames: dataService.PropertyList,
                columnNames: dataService.ColumnList);
          }
          if (check == 2) {
            return DataTableWidget.nacoes(
                jsonObjects: value,
                propertyNames: dataService.PropertyList,
                columnNames: dataService.ColumnList);
          } else {
            return DataTableWidget.cervejas(
                jsonObjects: value,
                propertyNames: dataService.PropertyList,
                columnNames: dataService.ColumnList);
          }
        });
  }
}

class NewNavBar extends HookWidget {
  var itemSelectedCallback;

  NewNavBar({this.itemSelectedCallback}) {
    itemSelectedCallback ??= (_) {};
  }

  @override
  Widget build(BuildContext context) {
    var state = useState(1);

    return BottomNavigationBar(
        onTap: (index) {
          state.value = index;
          check = index;
          itemSelectedCallback(index);
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

  DataTableWidget.cafes(
      {this.jsonObjects = const [],
      this.columnNames = const [
        "id",
        "uid",
        "blend_name",
        "origin",
        "variety",
        "notes",
        "intensifier"
      ],
      this.propertyNames = const [
        "ID",
        "UID",
        "Nome do Blend",
        "Origem",
        "Variedade",
        "Notas",
        "Intensificador"
      ]});
  DataTableWidget.cervejas(
      {this.jsonObjects = const [],
      this.columnNames = const [
        "id",
        "uid",
        "brand",
        "name",
        "style",
        "hop",
        "yeast",
        "malts",
        "ibu",
        "alcohol",
        "blg"
      ],
      this.propertyNames = const [
        "ID",
        "UID",
        "Marca",
        "Nome",
        "Estilo",
        "Lúpulo",
        "Levedura",
        "Maltes",
        "IBU",
        "Álcool",
        "BLG"
      ]});
  DataTableWidget.nacoes(
      {this.jsonObjects = const [],
      this.columnNames = const [
        "id",
        "uid",
        "nationality",
        "language",
        "capital",
        "national_sport",
        "flag"
      ],
      this.propertyNames = const [
        "ID",
        "UID",
        "Nacionalidade",
        "Idioma",
        "Capital",
        "Esporte Nacional",
        "Bandeira"
      ]});

  @override
  Widget build(BuildContext context) {
    return DataTable(
      columnSpacing: 30,
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
