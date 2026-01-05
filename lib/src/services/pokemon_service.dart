import 'dart:convert';
import 'package:flutter_pokedex/src/models/pokemon_detail.dart';
import 'package:flutter_pokedex/src/models/pokemon_list_response.dart';
import 'package:http/http.dart' as http;

Future<PokemonListResponse> fetchPokemonList(int limit, int offset) async {
  // montar a url com limit e offset
  final response = await http.get(
    // fazer http.get
    Uri.parse('https://pokeapi.co/api/v2/pokemon?limit=$limit&offset=$offset'),
  );

  // verificar statusCode
  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    // retornar PokemonListResponse.fromJson
    return PokemonListResponse.fromJson(
      // jsonDecode
      jsonDecode(response.body) as Map<String, dynamic>,
    );
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Erro ao carregar Lista de Pokemons');
  }
}

Future<PokemonDetail> fetchPokemonDetail(String url) async {
  final response = await http.get(Uri.parse(url));

  if (response.statusCode == 200) {
    return PokemonDetail.fromJson(
      jsonDecode(response.body) as Map<String, dynamic>,
    );
  } else {
    throw Exception('Erro ao carregar Detalhes do Pokemon');
  }
}
