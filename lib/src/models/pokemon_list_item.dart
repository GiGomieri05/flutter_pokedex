class PokemonListItem {
  final String name;
  final String url;

  const PokemonListItem({required this.name, required this.url});

  factory PokemonListItem.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {'name': String name, 'url': String url} => PokemonListItem(
        name: name,
        url: url,
      ),
      _ => throw const FormatException('Failed to load Pokemon List Item.'),
    };
  }
}
