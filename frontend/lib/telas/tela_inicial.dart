import 'package:DistribuSound/modelos/musica.dart';
import 'package:DistribuSound/telas/player.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

Future<List<Musica>> pegarMusicas() async {
  final url = Uri.parse('http://189.122.191.53:3000/get-all-mp3');
  final response = await http.get(url, headers: {'Content-Type': 'application/json'});
  
  if (response.statusCode == 200) {
    List<dynamic> musicasJson = json.decode(response.body)['result'];
    List<Musica> musicas = musicasJson.map((musicaJson) {
      return Musica(
        id: musicaJson['id'],
        nome_musica: musicaJson['title'],
        nome_artista: musicaJson['artist_name'],
      );
    }).toList();

    return musicas;
  } else {
    throw Exception('Falha ao carregar músicas');
  }
}

class TelaInicial extends StatefulWidget {
  const TelaInicial({Key? key}) : super(key: key);

  @override
  State<TelaInicial> createState() => _TelaInicialState();
}

class _TelaInicialState extends State<TelaInicial> {
  late Future<List<Musica>> futureMusicas;

  @override
  void initState() {
    super.initState();
    futureMusicas = pegarMusicas();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text("DistribuSound", style: TextStyle(color: Colors.white),),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Text(
              "Musicas",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w500,
                fontSize: 30,
              ),
            ),
            SizedBox(height: 20,),
            Expanded(
              child: FutureBuilder<List<Musica>>(
                future: futureMusicas,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Erro: ${snapshot.error}'));
                  } else if (snapshot.hasData) {
                    return MusicGrid(musicas: snapshot.data!);
                  }
                  return Container();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MusicGrid extends StatelessWidget {
  final List<Musica> musicas;

  MusicGrid({required this.musicas});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 8.0,
        mainAxisSpacing: 8.0,
      ),
      itemCount: musicas.length,
      itemBuilder: (context, index) {
        return MusicTile(musica: musicas[index]);
      },
    );
  }
}

class MusicTile extends StatelessWidget {
  final Musica musica;

  MusicTile({required this.musica});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Player(musica: musica),
          ),
        );
      },
      child: Card(
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              musica.nome_musica,
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 4),
            Text(
              musica.nome_artista,
              style: TextStyle(color: Colors.black),
            ),
            SizedBox(height: 4),
            Icon(Icons.music_note, color: Colors.black),
          ],
        ),
      ),
    );
  }
}
