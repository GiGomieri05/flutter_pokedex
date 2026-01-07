import 'dart:convert';

import 'package:flutter_pokedex/src/models/starred_pokemon.dart';
import 'package:http/http.dart' as http;

const String backendUrl = "http://127.0.0.1:8000";

Future<List<StarredPokemon>> fetchStarred() async {
  // retorna todos os pokemons listados como favoritos
  final response = await http.get(Uri.parse('$backendUrl/api/starred/'));

  if (response.statusCode == 200) {
    // converte para List<dynamic>
    final List<dynamic> jsonList = jsonDecode(response.body);
    // retorna uma List<StarredPokemon>
    return jsonList
        .map((json) => StarredPokemon.fromJson(json as Map<String, dynamic>))
        .toList();
  } else {
    throw Exception('Erro ao carregar pokemons favoritos');
  }
}

Future<void> toggleStarred(String name) async {
  final uri = Uri.parse("$backendUrl/api/starred/");

  final response = await http.post(
    uri,
    headers: {'Content-Type': 'application/json'},
    body: jsonEncode({'name': name}),
  );

  if (response.statusCode < 200 || response.statusCode >= 300) {
    throw Exception(
      'Erro ao favoritar: ${response.statusCode} ${response.body}',
    );
  }
}
