import 'package:flutter/material.dart';
import 'package:for_howl/service/audio_handler/MyAudioHandler.dart';
import 'package:for_howl/view/component/audio_player_screen/AudioPlayerScreen.dart';
import 'package:for_howl/view/component/date_picker/DatePicker.dart';

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
      body: const Column(
        children: [
          DatePicker(),
          Expanded(
            flex: 1,
            child: AudioPlayerScreen(),
          ),
          // const Expanded(
          //   flex: 1,
          //   child: Text('hi'),
          // ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _audioHandler
              .setAudioSource("https://www.youtube.com/watch?v=6RQ-bBdASvk");
          // Add your onPressed code here!
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
