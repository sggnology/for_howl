import 'package:flutter/material.dart';

import '../audio_player_screen/index.dart';

class PlaylistPage extends StatelessWidget {
  const PlaylistPage({super.key});

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
    );
  }
}
