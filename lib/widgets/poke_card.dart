import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

import '../models/pokemon.dart';

class PokeCard extends StatefulWidget {
  final String pokeURL;

  const PokeCard({Key key, this.pokeURL}) : super(key: key);

  @override
  _PokeCardState createState() => _PokeCardState();
}

class _PokeCardState extends State<PokeCard> {
  Pokemon pokemon;

  fetchPokemon() async {
    final res = await http.get(widget.pokeURL);
    final decode = jsonDecode(res.body);
    final data = Pokemon.fromJson(decode);
    setState(() => pokemon = data);
  }

  @override
  void initState() {
    super.initState();
    fetchPokemon();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5.0,
      child: pokemon == null
          ? Center(child: CircularProgressIndicator())
          : Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  height: 100,
                  width: 100,
                  child: FadeInImage(
                    placeholder: AssetImage('assets/pokeball.png'),
                    image: NetworkImage(pokemon.sprites.frontDefault),
                  ),
                ),
                Text(
                  toBeginningOfSentenceCase(pokemon.name),
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.title,
                ),
              ],
            ),
    );
  }
}
