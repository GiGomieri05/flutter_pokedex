import 'package:flutter/material.dart';

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
  final List<String> pokemons = [
    "Bulbasaur",
    "Charmander",
    "Squirtle",
    "Pikachu",
    "Eevee",
  ];

  final List<String> habilidades = <String>[
    "Overgrow",
    "Blaze",
    "Torrent",
    "Static",
    "Run Away, Adaptability",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Container(
        child: ListView.builder(
          itemBuilder: (context, index) {
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
                          child: Image.asset(
                            'assets/images/${pokemons[index].toLowerCase()}.png',
                          ),
                        ),
                        const SizedBox(width: 20),
                        Text(
                          pokemons[index],
                          style: const TextStyle(
                            fontSize: 24,
                            color: Colors.white,
                          ),
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
                        spacing: 0,
                        children: [
                          const Text(
                            'Habilidade(s):',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w900,
                              color: Colors.blueGrey,
                            ),
                          ),
                          const SizedBox(width: 20),
                          Text(
                            habilidades[index],
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                              color: Colors.blueGrey,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
          itemCount: pokemons.length,
        ),
      ),
    );
  }
}
