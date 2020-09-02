import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'package:cached_network_image/cached_network_image.dart';

import '../models/pokemon.dart';

class PokeCard extends StatefulWidget {
  final String pokeURL;

  const PokeCard({Key key, this.pokeURL}) : super(key: key);

  @override
  _PokeCardState createState() => _PokeCardState();
}

class _PokeCardState extends State<PokeCard> {
  Pokemon pokemon;

  _fetchPokemon() async {
    final res = await http.get(widget.pokeURL);
    final decode = jsonDecode(res.body);
    final data = Pokemon.fromJson(decode);
    setState(() => pokemon = data);
  }

  @override
  void initState() {
    super.initState();
    _fetchPokemon();
  }

  @override
  void setState(fn) {
    if (this.mounted) {
      super.setState(fn);
    }
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
                Expanded(
                  flex: 3,
                  child: CachedNetworkImage(
                    imageUrl: pokemon.sprites.frontDefault,
                    placeholder: (context, url) => Image(
                      image: AssetImage('assets/pokeball.png'),
                    ),
                    errorWidget: (context, url, error) => Icon(Icons.error),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Text(
                    toBeginningOfSentenceCase(pokemon.name),
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.headline6,
                  ),
                ),
              ],
            ),
    );
  }
}
