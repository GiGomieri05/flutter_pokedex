import 'pokemon_list_item.dart';

class PokemonListResponse {
  final int count;
  final String? next; // se estiver no fim da pokedex, next = null
  final String? previous; // se estiver no inicio da pokedex, previous = null
  final List<PokemonListItem> results;

  const PokemonListResponse({
    required this.count,
    required this.next,
    required this.previous,
    required this.results,
  });

  factory PokemonListResponse.fromJson(Map<String, dynamic> json) {
    final count = json['count'] as int;
    final next = json['next'] as String?;
    final previous = json['previous'] as String?;
    final resultsJson = json['results'] as List<dynamic>;

    final results = resultsJson
        .map(
          (result) => PokemonListItem.fromJson(result as Map<String, dynamic>),
        )
        .toList();

    return PokemonListResponse(
      count: count,
      next: next,
      previous: previous,
      results: results,
    );
  }
}
