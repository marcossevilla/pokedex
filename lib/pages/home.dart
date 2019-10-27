import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../widgets/poke_card.dart';
import '../models/simple_pokemon.dart';

class Home extends StatefulWidget {
  static const String url = 'https://pokeapi.co/api/v2/pokemon/';

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Pokemons pokemons;

  _fetchData() async {
    final res = await http.get(Home.url);
    final decode = jsonDecode(res.body);
    final data = Pokemons.fromJson(decode['results']);
    setState(() => pokemons = data);
  }

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Image(image: AssetImage('assets/pikachu.png')),
            SizedBox(width: 10.0),
            Text(
              'Pokédex',
              style: Theme.of(context)
                  .textTheme
                  .display1
                  .copyWith(color: Colors.white),
            ),
          ],
        ),
      ),
      backgroundColor: Colors.red,
      body: pokemons == null
          ? Center(child: CircularProgressIndicator())
          : GridView.count(
              crossAxisCount: 2,
              children: List.generate(
                pokemons.pokemons.length,
                (index) => Padding(
                  padding: EdgeInsets.all(10.0),
                  child: PokeCard(
                    pokeURL: pokemons.pokemons[index].url,
                  ),
                ),
              ),
            ),
    );
  }
}
