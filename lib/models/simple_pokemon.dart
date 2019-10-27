// To parse this JSON data, do
//
//     final simplePokemon = simplePokemonFromJson(jsonString);

import 'dart:convert';

SimplePokemon simplePokemonFromJson(String str) =>
    SimplePokemon.fromJson(json.decode(str));

String simplePokemonToJson(SimplePokemon data) => json.encode(data.toJson());

class Pokemons {
  List<SimplePokemon> pokemons = List();

  Pokemons.fromJson(List<dynamic> json) {
    if (json == null) return;

    json.forEach((item) {
      final pokemon = SimplePokemon.fromJson(item);
      pokemons.add(pokemon);
    });
  }
}

class SimplePokemon {
  String name;
  String url;

  SimplePokemon({
    this.name,
    this.url,
  });

  factory SimplePokemon.fromJson(Map<String, dynamic> json) => SimplePokemon(
        name: json["name"],
        url: json["url"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "url": url,
      };
}
