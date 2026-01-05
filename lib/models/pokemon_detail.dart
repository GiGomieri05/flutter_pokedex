class PokemonDetail {
  final String name;
  final List<String> abilities;
  final String? imageUrl; // pode ser que a imagem desenhada nao exista

  const PokemonDetail({
    required this.name,
    required this.abilities,
    required this.imageUrl,
  });

  factory PokemonDetail.fromJson(Map<String, dynamic> json) {
    // extraindo os dados em variáveis intermediarias primeiro
    // pegar o nome
    final name = json['name'] as String;

    // pegar a lista de habilidades
    final abilitiesJson = json['abilities'] as List<dynamic>;
    final abilities = <String>[];

    for (final ability in abilitiesJson) {
      // use ability e pegue o nome
      final aMap = ability as Map<String, dynamic>;
      final aInfo = aMap['ability'] as Map<String, dynamic>;
      final s = aInfo['name'] as String;

      abilities.add(s);
    }

    // pegar a imagem do caminho sprites -> other -> official-artwork -> front default
    final imageUrl =
        json['sprites']['other']['official-artwork']['front_default']
            as String?;

    return PokemonDetail(name: name, abilities: abilities, imageUrl: imageUrl);
  }
}
