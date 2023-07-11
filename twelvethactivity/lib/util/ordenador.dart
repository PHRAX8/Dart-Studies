class Ordenador {
  List ordenarFuderoso(List objetos, Decididor decididor) {
    List objetosOrdenados = List.of(objetos);
    bool trocouAoMenosUm;
    do {
      trocouAoMenosUm = false;
      for (int i = 0; i < objetosOrdenados.length - 1; i++) {
        var atual = objetosOrdenados[i];
        var proximo = objetosOrdenados[i + 1];
        if (decididor.precisaTrocarAtualPeloProximo(atual, proximo)) {
          var aux = objetosOrdenados[i];
          objetosOrdenados[i] = objetosOrdenados[i + 1];
          objetosOrdenados[i + 1] = aux;
          trocouAoMenosUm = true;
        }
      }
    } while (trocouAoMenosUm);

    return objetosOrdenados;
  }
}

abstract class Decididor {
  bool precisaTrocarAtualPeloProximo(dynamic atual, dynamic proximo);
}

class DecididorJSON extends Decididor {
  final String propriedade;

  final bool crescente;

  DecididorJSON(this.propriedade, [this.crescente = true]);

  @override
  bool precisaTrocarAtualPeloProximo(atual, proximo) {
    try {
      final ordemCorreta = crescente ? [atual, proximo] : [proximo, atual];

      return ordemCorreta[0][propriedade]
              .compareTo(ordemCorreta[1][propriedade]) >
          0;
    } catch (error) {
      return false;
    }
  }
}
