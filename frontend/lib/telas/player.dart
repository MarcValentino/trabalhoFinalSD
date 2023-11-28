// ignore_for_file: non_constant_identifier_names, prefer_const_constructors_in_immutables, prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:musica_distribuida/modelos/musica.dart';

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
        appBar: AppBar(
          title: Text("DistribuSound"),
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
              ),
            ),
            const SizedBox(height: 4),
            Text(
              musica.nome_artista,
              style: TextStyle(fontSize: 20),
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
                    Text(formatDuration(position.toString())),
                    Text(formatDuration((duration - position).toString())),
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
