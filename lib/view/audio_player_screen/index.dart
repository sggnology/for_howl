import 'package:audio_service/audio_service.dart';
import 'package:flutter/material.dart';
import 'package:for_howl/service/audio_handler/MyAudioHandler.dart';

class AudioPlayerScreen extends StatefulWidget {
  const AudioPlayerScreen({super.key});

  @override
  _AudioPlayerScreenState createState() => _AudioPlayerScreenState();
}

class _AudioPlayerScreenState extends State<AudioPlayerScreen> {

  final _audioHandler = MyAudioHandler();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // MediaItem 스트림 구독하여 UI에 표시
        StreamBuilder<MediaItem?>(
          stream: _audioHandler.mediaItem,
          builder: (context, snapshot) {
            final mediaItem = snapshot.data;
            return Text(mediaItem?.title ?? 'No media');
          },
        ),
        // MediaItem 스트림 구독하여 UI에 표시
        StreamBuilder<MediaItem?>(
          stream: _audioHandler.mediaItem,
          builder: (context, snapshot) {
            final mediaItem = snapshot.data;
            return Text(mediaItem?.artist ?? 'No media');
          },
        ),
        // PlaybackState 스트림 구독하여 UI에 표시
        StreamBuilder<PlaybackState>(
          stream: _audioHandler.playbackState,
          builder: (context, snapshot) {
            final playbackState = snapshot.data;
            final playing = playbackState?.playing ?? false;
            return IconButton(
              icon: Icon(playing ? Icons.pause : Icons.play_arrow),
              onPressed: () {
                if (playing) {
                  _audioHandler.pause();
                } else {
                  _audioHandler.play();
                }
              },
            );
          },
        ),
        // 현재 재생 위치 표시
        StreamBuilder<Duration>(
          stream: _audioHandler.playbackState
              .map((state) => state.updatePosition)
              .distinct(),
          builder: (context, snapshot) {
            final position = snapshot.data ?? Duration.zero;
            return Text("Position: ${position.inSeconds} seconds");
          },
        ),
        // 시크바
        StreamBuilder<Duration?>(
          stream: _audioHandler.mediaItem
              .map((item) => item?.duration)
              .distinct(),
          builder: (context, snapshot) {
            final duration = snapshot.data ?? Duration.zero;
            return StreamBuilder<Duration>(
              stream: _audioHandler.playbackState
                  .map((state) => state.updatePosition)
                  .distinct(),
              builder: (context, positionSnapshot) {
                final position = positionSnapshot.data ?? Duration.zero;
                return Slider(
                  min: 0,
                  max: duration.inSeconds.toDouble(),
                  value: position.inSeconds.toDouble(),
                  onChanged: (value) {
                    _audioHandler.seek(Duration(seconds: value.toInt()));
                  },
                );
              },
            );
          },
        ),
      ],
    );
  }
}
