import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../util/ordenador.dart';

enum TableStatus { idle, loading, ready, error }

enum ItemType {
  credit_cards,
  users,
  addresses,
  none;

  String get asString => '$name';
  List<String> get columns => this == users
      ? ["Nome de Usuário", "E-mail", "Número de Telefone"]
      : this == credit_cards
          ? ["Número do Cartão", "Validade", "Tipo"]
          : this == addresses
              ? ["Cidade", "Bairro", "Rua", "CEP"]
              : [];
  List<String> get properties => this == users
      ? ["username", "email", "phone_number"]
      : this == credit_cards
          ? ["credit_card_number", "credit_card_expiry_date", "credit_card_type"]
          : this == addresses
              ? ["city", "street_name", "street_address", "zip_code"]
              : [];
}

class DataService {
  static const MAX_N_ITEMS = 15;
  static const MIN_N_ITEMS = 3;
  static const DEFAULT_N_ITEMS = 7;
  int _numberOfItems = DEFAULT_N_ITEMS;
  int get getNumberOfItems => _numberOfItems;

  set numberOfItems(n) {
    _numberOfItems = n < 0
        ? MIN_N_ITEMS
        : n > MAX_N_ITEMS
            ? MAX_N_ITEMS
            : n;
  }

  final ValueNotifier<Map<String, dynamic>> tableStateNotifier = ValueNotifier({
    'status': TableStatus.idle,
    'dataObjects': [],
    'itemType': ItemType.none
  });

  void carregarJson(String pathType, List<String> propertyList,
      List<String> columnList, ItemType) {
    if (tableStateNotifier.value['status'] == TableStatus.loading) return;

    if (tableStateNotifier.value['itemType'] != ItemType) {
      tableStateNotifier.value = {
        'itemType': ItemType,
        'status': TableStatus.loading,
        'dataObjects': []
      };
    }
  }

  Uri montarUri(ItemType) {
    return Uri(
        scheme: 'https',
        host: 'random-data-api.com',
        path: 'api/v2/${ItemType.asString}',
        queryParameters: {'size': '$_numberOfItems'});
  }

  Future<List<dynamic>> acessarApi(Uri uri) async {
    var jsonString = await http.read(uri);

    var json = jsonDecode(jsonString);

    json = [...tableStateNotifier.value['dataObjects'], ...json];

    return json;
  }

  void emitirEstadoOrdenado(List objetosOrdenados, String propriedade) {
    var estado = Map<String, dynamic>.from(tableStateNotifier.value);

    estado['dataObjects'] = objetosOrdenados;

    estado['sortCriteria'] = propriedade;

    estado['ascending'] = true;

    tableStateNotifier.value = estado;
  }

  void emitirEstadoCarregando(ItemType) {
    tableStateNotifier.value = {
      'status': TableStatus.loading,
      'dataObjects': [],
      'itemType': ItemType
    };
  }

  void emitirEstadoPronto(ItemType, var json) {
    tableStateNotifier.value = {
      'itemType': ItemType,
      'status': TableStatus.ready,
      'dataObjects': json,
      'propertyNames': ItemType.properties,
      'columnNames': ItemType.columns
    };
  }

  bool temRequisicaoEmCurso() =>
      tableStateNotifier.value['status'] == TableStatus.loading;

  bool mudouTipoDeItemRequisitado(ItemType) =>
      tableStateNotifier.value['itemType'] != ItemType;

  void carregarPorTipo(ItemType) async {
    if (temRequisicaoEmCurso()) return;

    if (mudouTipoDeItemRequisitado(ItemType)) {
      emitirEstadoCarregando(ItemType);
    }

    var uri = montarUri(ItemType);

    var json = await acessarApi(uri);

    emitirEstadoPronto(ItemType, json);
  }

  void carregar(index) {
    final params = [ItemType.users, ItemType.credit_cards, ItemType.addresses];

    carregarPorTipo(params[index]);
  }

  void ordenarEstadoAtual(String propriedade) {
    List objetos = tableStateNotifier.value['dataObjects'] ?? [];

    if (objetos == []) return;

    Ordenador ord = Ordenador();

    Decididor d = DecididorJSON(propriedade);

    var objetosOrdenados = ord.ordenarFuderoso(objetos, d);

    emitirEstadoOrdenado(objetosOrdenados, propriedade);
  }
}

class DecididorCervejaNomeCrescente extends Decididor {
  @override
  bool precisaTrocarAtualPeloProximo(atual, proximo) {
    try {
      return atual["name"].compareTo(proximo["name"]) > 0;
    } catch (error) {
      return false;
    }
  }
}

class DecididorCervejaEstiloCrescente extends Decididor {
  @override
  bool precisaTrocarAtualPeloProximo(atual, proximo) {
    try {
      return atual["style"].compareTo(proximo["style"]) > 0;
    } catch (error) {
      return false;
    }
  }
}

class DecididorCervejaNomeDecrescente extends Decididor {
  @override
  bool precisaTrocarAtualPeloProximo(atual, proximo) {
    try {
      return atual["name"].compareTo(proximo["name"]) < 0;
    } catch (error) {
      return false;
    }
  }
}

class DecididorCervejaEstiloDecrescente extends Decididor {
  @override
  bool precisaTrocarAtualPeloProximo(atual, proximo) {
    try {
      return atual["style"].compareTo(proximo["style"]) < 0;
    } catch (error) {
      return false;
    }
  }
}

final dataService = DataService();
