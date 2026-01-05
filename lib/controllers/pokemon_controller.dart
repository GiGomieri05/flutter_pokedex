import 'package:flutter_pokedex/models/pokemon_detail.dart';
import 'package:flutter_pokedex/models/pokemon_list_item.dart';
import 'package:flutter_pokedex/services/pokemon_service.dart';

class PokemonController {
  final int limit = 10;
  int offset = 0;
  bool isLoading = false;
  // hasMore precisa começar com true, até que na API next = null
  bool hasMore = true;
  List<PokemonDetail> listaPokemons = [];

  Future<void> loadNextPage() async {
    // nao pode rodar se esta carregando ou nao tem mais dados
    if (isLoading || !hasMore) {
      return;
    }

    // precisa marcar que esta carregando (isLoading = true)
    isLoading = true;

    try {
      // chama fetchPokemonList(limit, offset) para proxima pagina
      final response = await fetchPokemonList(limit, offset);

      // se chegar no fim (response.next == null) diz que nao tem mais dados (hasMore = false)
      if (response.next == null) {
        hasMore = false;
      }
      // pra cada PokemonListItem em response.results chama o fetchPokemonDetail(item.url)
      final futures = response.results.map(
        (item) => fetchPokemonDetail(item.url),
      );

      final pokemons = await Future.wait(futures);

      listaPokemons.addAll(pokemons);

      // Avanca o offset
      offset += limit;
    } finally {
      // libera o carregamento (isLoading = false)
      isLoading = false;
    }
  }
}
