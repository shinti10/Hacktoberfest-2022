import 'package:flutter/material.dart';
import 'package:flutter_pokemon/Pokemon%20Api/pokemon_api.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Pokemon Api',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const PokemonApi(),
    );
  }
}
