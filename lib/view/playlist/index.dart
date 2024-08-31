import 'package:flutter/material.dart';
import 'package:for_howl/service/YoutubeHelper.dart';

class PlaylistPage extends StatelessWidget {
  const PlaylistPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('PlayList Page'),
      ),
      body: PlaylistStatefulPage(),
    );
  }
}

class PlaylistStatefulPage extends StatefulWidget {
  const PlaylistStatefulPage({super.key});

  @override
  State<PlaylistStatefulPage> createState() => _PlaylistStatefulPageState();
}

class _PlaylistStatefulPageState extends State<PlaylistStatefulPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: Row(
              children: [
                Text('PlayList Page'),
                ElevatedButton(
                    onPressed: () {
                      YoutubeHelper.extractAudioURLFromYoutubeURL("https://www.youtube.com/watch?v=l0C904QrkvY");
                    },
                    child: Text('Go to PlayList Page')
                )
              ],
            )
        )
    );
  }
}