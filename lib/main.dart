import 'package:flutter/material.dart';
import 'package:flutter_pokedex/controllers/pokemon_controller.dart';
import 'package:flutter_pokedex/models/pokemon_list_response.dart';
import 'package:http/http.dart' as http;

import 'models/pokemon_detail.dart';
import 'services/pokemon_service.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(colorScheme: .fromSeed(seedColor: Colors.red)),
      home: const MyHomePage(title: 'Flutter Pokedex'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final PokemonController controller = PokemonController();

  @override
  void initState() {
    super.initState();
    _loadInitial();
  }

  // initState nao pode ser async, entao dividi em um metodo separado
  // entra no lugar do FutureBuilder
  Future<void> _loadInitial() async {
    await controller.loadNextPage();
    if (mounted) setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final itemCount =
        controller.listaPokemons.length + (controller.hasMore ? 1 : 0);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: ListView.builder(
        itemCount: itemCount,
        itemBuilder: (BuildContext context, int index) {
          // ainda eh um pokemon
          if (index < controller.listaPokemons.length) {
            final pokemon = controller.listaPokemons[index];

            // carrega mais ao chegar no fim
            if (index == controller.listaPokemons.length - 1) {
              controller.loadNextPage().then((_) {
                if (mounted) setState(() {});
              });
            }
            return _buildPokemonCard(pokemon);
          }

          // loader
          return const Padding(
            padding: EdgeInsets.all(24),
            child: Center(child: CircularProgressIndicator()),
          );
        },
      ),
    );
  }

  Widget _buildPokemonCard(PokemonDetail pokemon) {
    return Center(
      child: Container(
        height: 250,
        padding: const EdgeInsets.all(20),
        margin: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.redAccent.shade200,
          border: Border.all(color: Colors.red.shade800, width: 2),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                SizedBox(
                  width: 100,
                  height: 100,
                  child: pokemon.imageUrl != null
                      ? Image.network(pokemon.imageUrl!)
                      : const Icon(Icons.image_not_supported_rounded, size: 60),
                ),
                const SizedBox(width: 20),
                Text(
                  pokemon.name,
                  style: const TextStyle(fontSize: 24, color: Colors.white),
                ),
              ],
            ),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              height: 70,
              padding: const EdgeInsets.all(20),
              margin: const EdgeInsets.only(top: 20),
              child: Row(
                children: [
                  const Text(
                    'Habilidade(s): ',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w900,
                      color: Colors.blueGrey,
                    ),
                  ),
                  Expanded(
                    child: Text(
                      pokemon.abilities.join(', '),
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: Colors.blueGrey,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
