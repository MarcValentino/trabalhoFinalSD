// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:musica_distribuida/modelos/musica.dart';
import 'dart:convert';

import 'package:musica_distribuida/telas/player.dart';

Future<List> pegar_musicas() async {
  final url = Uri.parse('http://189.122.191.53:3000/get-all-mp3');
  final response =
      await http.get(url, headers: {'Content-Type': 'application/json'});
  List musicas = [];
  if (response.statusCode == 200) {
    List musicas_json = json.decode(response.body)['result'];
    for (var musica_atual in musicas_json) {
      Musica musica = Musica(
          id: musica_atual['id'],
          nome_musica: musica_atual['title'],
          nome_artista: musica_atual['artist_name']);
      musicas.add(musica);
    }
  }

  return musicas;
}

class TelaInicial extends StatefulWidget {
  const TelaInicial({super.key});

  @override
  State<TelaInicial> createState() => _TelaInicialState();
}

class _TelaInicialState extends State<TelaInicial> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text("DistribuSound"),
      ),
      body: FutureBuilder(
          future: pegar_musicas(),
          builder: (contex, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Erro: ${snapshot.error}'));
            } else if (snapshot.hasData) {
              List musicas = snapshot.data as List;
              return ListView.builder(
                  itemCount: musicas.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text("${musicas[index].nome_musica}",
                          style: TextStyle(color: Colors.white)),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Player(
                                      musica: musicas[index],
                                    )));
                      },
                    );
                  });
            }
            return Container();
          }),
    );
  }
}
