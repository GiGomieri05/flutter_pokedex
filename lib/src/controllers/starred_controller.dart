import 'package:flutter_pokedex/src/services/starred_service.dart';

class StarredController {
  Set<String> listaFavoritos = {};
  bool isLoading = false;

  Future<void> loadStarred() async {
    if (isLoading) {
      return;
    }

    isLoading = true;

    try {
      final response = await fetchStarred();

      // a lista de modelos tem que tornar um set de nomes
      listaFavoritos = response.map((p) => p.name).toSet();
    } finally {
      isLoading = false;
    }
  }

  bool isStarred(String name) {
    return listaFavoritos.contains(name);
  }

  Future<void> toggle(String name) async {
    // chama o servico do backend
    await toggleStarred(name);

    // atualiza local
    if (listaFavoritos.contains(name)) {
      listaFavoritos.remove(name);
    } else {
      listaFavoritos.add(name);
    }
  }
}
