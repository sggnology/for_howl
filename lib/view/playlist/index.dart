import 'package:flutter/material.dart';
import 'package:for_howl/service/audio_handler/MyAudioHandler.dart';
import 'package:for_howl/view/component/audio_player_screen/AudioPlayerScreen.dart';

class PlaylistPage extends StatelessWidget {

  PlaylistPage({
    super.key,
  });

  final _audioHandler = MyAudioHandler();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('PlayList Page'),
      ),
      body: const Row(
        children: [
          Flexible(
            fit: FlexFit.tight,
            child: AudioPlayerScreen(),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _audioHandler.setAudioSource("https://www.youtube.com/watch?v=6RQ-bBdASvk");
          // Add your onPressed code here!
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
