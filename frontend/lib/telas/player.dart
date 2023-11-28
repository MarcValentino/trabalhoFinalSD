// ignore_for_file: non_constant_identifier_names, prefer_const_constructors_in_immutables, prefer_const_constructors, use_build_context_synchronously
import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import '../modelos/musica.dart';
import 'tela_inicial.dart';

class Player extends StatefulWidget {
  Musica musica;
  Player({Key? key, required this.musica}) : super(key: key);

  @override
  State<Player> createState() => _PlayerState();
}

class _PlayerState extends State<Player> {
  final audioPlayer = AudioPlayer();
  bool isPlaying = false;
  Duration duration = Duration.zero;
  Duration position = Duration.zero;
  _PlayerState() {
    audioPlayer.onPlayerStateChanged.listen((state) {
      setState(() {
        isPlaying = state == PlayerState.playing;
      });
    });

    audioPlayer.onDurationChanged.listen((newDuration) {
      setState(() {
        duration = newDuration;
      });
    });

    audioPlayer.onPositionChanged.listen((newPosition) {
      setState(() {
        position = newPosition;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    Musica musica = widget.musica;
    return Scaffold(
      backgroundColor: Colors.black,
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: Text('DistribuSound', style: TextStyle(color: Colors.white)),
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.white,),
            onPressed: () async {
              // Adicione sua ação personalizada aqui
              await audioPlayer.pause();
              Navigator.pop(context);
            },
          ),
        ),
        body: Padding(
          padding: EdgeInsets.all(20),
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.network(
                'https://classic.exame.com/wp-content/uploads/2016/10/size_960_16_9_fones-de-ouvido.png?w=960',
                width: double.infinity,
                height: 350,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 32),
            Text(
              musica.nome_musica,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white
              ),
            ),
            const SizedBox(height: 4),
            Text(
              musica.nome_artista,
              style: TextStyle(fontSize: 20, color: Colors.white),
            ),
            Slider(
                min: 0,
                max: duration.inSeconds.toDouble(),
                value: position.inSeconds.toDouble(),
                onChanged: (value) async {
                  final newPosition = Duration(seconds: value.toInt());
                  await audioPlayer.seek(newPosition);
                  await audioPlayer.resume();
                }),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(formatDuration(position.toString()), style: TextStyle(color: Colors.white,)),
                    Text(formatDuration((duration - position).toString()), style: TextStyle(color: Colors.white,)),
                  ]),
            ),
            CircleAvatar(
              radius: 35,
              child: IconButton(
                icon: Icon(isPlaying ? Icons.pause : Icons.play_arrow),
                iconSize: 50,
                onPressed: () async {
                  if (isPlaying) {
                    await audioPlayer.pause();
                  } else {
                    try {
                      await audioPlayer.play(UrlSource(
                          "http://189.122.191.53:3000/stream-mp3/${musica.id}"));
                    } catch (e) {
                      print("Erro ao reproduzir áudio: $e");
                    }
                  }
                },
              ),
            )
          ]),
        ));
  }
}

String formatDuration(String position) {
  List<String> parts = position.split(':');

  int minutes = int.parse(parts[1]);
  int seconds = int.parse(parts[2].split('.')[0]);

  return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
}
