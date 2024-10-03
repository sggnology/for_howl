import 'package:audio_service/audio_service.dart';
import 'package:flutter/material.dart';
import 'package:for_howl/service/YoutubeHelper.dart';
import 'package:for_howl/service/audio_handler/MyAudioHandler.dart';

class AudioPlayerScreen extends StatefulWidget {
  const AudioPlayerScreen({super.key});

  @override
  _AudioPlayerScreenState createState() => _AudioPlayerScreenState();
}

class _AudioPlayerScreenState extends State<AudioPlayerScreen> {
  late MyAudioHandler _audioHandler;

  @override
  void initState() {
    super.initState();
  }

  Future<void> _initAudioHandler() async {
    _audioHandler = await AudioService.init(
      builder: () => MyAudioHandler(),
      config: const AudioServiceConfig(
        androidNotificationChannelId: 'com.example.app.channel.audio',
        androidNotificationChannelName: 'Audio Playback',
        androidNotificationOngoing: true,
      ),
    );

    var audioURL = await YoutubeHelper.extractAudioURLFromYoutubeURL("https://www.youtube.com/watch?v=3_9ZrX1Rn7Y");

    // 오디오 소스 설정
    await _audioHandler.setAudioSource(audioURL);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _initAudioHandler(),
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return const Center(
              child: SizedBox(
                width: 30,
                height: 30,
                child: CircularProgressIndicator(),
              ),
            );
          }

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
        });
  }
}
