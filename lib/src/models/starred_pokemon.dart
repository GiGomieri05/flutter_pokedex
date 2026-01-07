class StarredPokemon {
  final String name;
  // final bool starred;

  const StarredPokemon({required this.name});

  factory StarredPokemon.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {'name': String name} => StarredPokemon(name: name),
      _ => throw const FormatException('Failed to load Starred Pokemons'),
    };
  }
}
