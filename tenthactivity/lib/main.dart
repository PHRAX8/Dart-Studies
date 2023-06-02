import 'package:flutter/material.dart';

import 'package:flutter_hooks/flutter_hooks.dart';

import 'package:http/http.dart' as http;

import 'dart:convert';

enum TableStatus { idle, loading, ready, error }

enum ItemType { beer, coffee, nation, none }

int count = 0;
String appTitle = "Dicas(${count} Itens)";

extension ParseToString on ItemType {
  String toShortString() {
    return this.toString().split('.').last;
  }
}

class DataService {
  final ValueNotifier<Map<String, dynamic>> tableStateNotifier = ValueNotifier({
    'status': TableStatus.idle,
    'dataObjects': [],
    'itemType': ItemType.none
  });

  void carregar(index) {
    final funcoes = [carregarCafes, carregarCervejas, carregarNacoes];

    funcoes[index]();
  }

  void carregarCafes() {
    if (tableStateNotifier.value['status'] == TableStatus.loading) return;

    if (tableStateNotifier.value['itemType'] != ItemType.coffee) {
      tableStateNotifier.value = {
        'status': TableStatus.loading,
        'dataObjects': [],
        'itemType': ItemType.coffee
      };
    }

    carregaritens(tableStateNotifier.value['itemType'],
        ["blend_name", "origin", "variety"], ["Nome", "Origem", "Tipo"]);
  }

  void carregarNacoes() {
    if (tableStateNotifier.value['status'] == TableStatus.loading) return;

    if (tableStateNotifier.value['itemType'] != ItemType.nation) {
      tableStateNotifier.value = {
        'status': TableStatus.loading,
        'dataObjects': [],
        'itemType': ItemType.nation
      };
    }
    carregaritens(
        tableStateNotifier.value['itemType'],
        ["nationality", "capital", "language", "national_sport"],
        ["Nome", "Capital", "Idioma", "Esporte"]);
  }

  void carregarCervejas() {
    if (tableStateNotifier.value['status'] == TableStatus.loading) return;

    if (tableStateNotifier.value['itemType'] != ItemType.beer) {
      tableStateNotifier.value = {
        'status': TableStatus.loading,
        'dataObjects': [],
        'itemType': ItemType.beer
      };
    }

    carregaritens(tableStateNotifier.value['itemType'],
        ["name", "style", "ibu"], ["Nome", "Estilo", "IBU"]);
  }

  void carregaritens(
      ItemType type, List<String> propertys, List<String> columns) {
    var itemUri = Uri(
        scheme: 'https',
        host: 'random-data-api.com',
        path: 'api/${type.toShortString()}/random_${type.toShortString()}',
        queryParameters: {'size': '10'});

    http.read(itemUri).then((jsonString) {
      var itemJson = jsonDecode(jsonString);

      if (tableStateNotifier.value['status'] != TableStatus.loading)
        itemJson = [...tableStateNotifier.value['dataObjects'], ...itemJson];

      tableStateNotifier.value = {
        'itemType': type,
        'status': TableStatus.ready,
        'dataObjects': itemJson,
        'propertyNames': propertys,
        'columnNames': columns
      };
    });
  }
}

final dataService = DataService();

void main() {
  MyApp app = MyApp();

  runApp(app);
}

class MyApp extends HookWidget {
  final functionsMap = {
    ItemType.beer: dataService.carregarCervejas,
    ItemType.coffee: dataService.carregarCafes,
    ItemType.nation: dataService.carregarNacoes
  };

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(primarySwatch: Colors.deepPurple),
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          appBar: AppBar(
            title: Text(appTitle),
          ),
          body: ValueListenableBuilder(
              valueListenable: dataService.tableStateNotifier,
              builder: (_, value, __) {
                switch (value['status']) {
                  case TableStatus.idle:
                    return Center(child: Text("Toque algum botão, abaixo..."));

                  case TableStatus.loading:
                    return Center(child: CircularProgressIndicator());

                  case TableStatus.ready:
                    return ListWidget(
                      jsonObjects: value['dataObjects'],
                      propertyNames: value['propertyNames'],
                      scrollEndedCallback: functionsMap[value['itemType']],
                    );

                  case TableStatus.error:
                    return Text("Erro");
                }

                return Text("...");
              }),
          bottomNavigationBar:
              NewNavBar(itemSelectedCallback: dataService.carregar),
        ));
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
          _itemSelectedCallback(index);
          count = 10;
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

class ListWidget extends HookWidget {
  final dynamic _scrollEndedCallback;

  final List jsonObjects;

  final List<String> propertyNames;

  ListWidget(
      {this.jsonObjects = const [],
      this.propertyNames = const [],
      void Function()? scrollEndedCallback})
      : _scrollEndedCallback = scrollEndedCallback ?? false;

  @override
  Widget build(BuildContext context) {
    var controller = useScrollController();

    useEffect(() {
      controller.addListener(
        () {
          if (controller.position.pixels ==
              controller.position.maxScrollExtent) {
            count += 10;
            if (_scrollEndedCallback is Function) _scrollEndedCallback();
          }
        },
      );
    }, [controller]);

    return ListView.separated(
      controller: controller,
      padding: EdgeInsets.all(10),
      separatorBuilder: (_, __) => Divider(
        height: 5,
        thickness: 2,
        indent: 10,
        endIndent: 10,
        color: Theme.of(context).primaryColor,
      ),
      itemCount: jsonObjects.length + 1,
      itemBuilder: (_, index) {
        if (index == jsonObjects.length)
          return Center(child: LinearProgressIndicator());

        var title = jsonObjects[index][propertyNames[0]];

        var content = propertyNames
            .sublist(1)
            .map((prop) => jsonObjects[index][prop])
            .join(" - ");

        return Card(
            shadowColor: Theme.of(context).primaryColor,
            child: Column(children: [
              SizedBox(height: 10),
              Text("${title}\n", style: TextStyle(fontWeight: FontWeight.bold)),
              Text(content),
              SizedBox(height: 10)
            ]));
      },
    );
  }
}
