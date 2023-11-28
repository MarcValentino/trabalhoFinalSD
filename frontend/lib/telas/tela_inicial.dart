// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:musica_distribuida/telas/player.dart';

Future<List> pegar_musicas() async {
  final url = Uri.parse('http://189.122.191.53:3000/get-all-mp3');
  final response =
      await http.get(url, headers: {'Content-Type': 'application/json'});
  List musicas = [];
  if (response.statusCode == 200) {
    musicas = json.decode(response.body)['result'];
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
                    var id = musicas[index]['id'];
                    return ListTile(
                      title: Text("${musicas[index]['title']}",
                          style: TextStyle(color: Colors.white)),
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => Player(id_musica: id,)));
                      },
                    );
                  });
            }
            return Container();
          }),
    );
  }
}
