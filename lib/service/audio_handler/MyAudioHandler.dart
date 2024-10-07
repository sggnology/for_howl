import 'package:audio_service/audio_service.dart';
import 'package:for_howl/service/YoutubeHelper.dart';
import 'package:just_audio/just_audio.dart';

import 'model/YoutubeAudioMetaInfo.dart';

class MyAudioHandler extends BaseAudioHandler {
  static MyAudioHandler _instance = MyAudioHandler._internal();

  factory MyAudioHandler() {
    return _instance;
  }

  late AudioPlayer _audioPlayer;

  //region Constructor & Helper of Constructor
  MyAudioHandler._internal() {
    _audioPlayer = AudioPlayer();

    _audioPlayer.playbackEventStream.listen((event) {
      playbackState.add(_transformEvent(event));
    });

    _audioPlayer.processingStateStream.listen((state) {
      if(state == ProcessingState.loading){
        pause();
      }
      else if(state == ProcessingState.ready){
        play();
      }
    });
  }

  static PlaybackState _transformEvent(PlaybackEvent event) {
    return PlaybackState(
      controls: [
        MediaControl.play,
        MediaControl.pause,
        MediaControl.stop,
      ],
      androidCompactActionIndices: const [0, 1, 2],
      processingState:
          _convertProcessingState(_instance._audioPlayer.processingState),
      playing: _instance._audioPlayer.playing,
      updatePosition: _instance._audioPlayer.position,
      bufferedPosition: _instance._audioPlayer.bufferedPosition,
      speed: _instance._audioPlayer.speed,
      systemActions: const {
        MediaAction.seekForward,
        MediaAction.seekBackward,
        MediaAction.seek,
      },
    );
  }

  static AudioProcessingState _convertProcessingState(ProcessingState state) {
    switch (state) {
      case ProcessingState.idle:
        return AudioProcessingState.idle;
      case ProcessingState.loading:
        return AudioProcessingState.loading;
      case ProcessingState.buffering:
        return AudioProcessingState.buffering;
      case ProcessingState.ready:
        return AudioProcessingState.ready;
      case ProcessingState.completed:
        return AudioProcessingState.completed;
      default:
        throw Exception("Invalid state: $state");
    }
  }

  //endregion

  Future<void> init() async {
    _instance = await AudioService.init(
      builder: () => MyAudioHandler(),
      config: const AudioServiceConfig(
        androidNotificationChannelId: 'com.example.app.channel.audio',
        androidNotificationChannelName: 'Audio Playback',
        androidNotificationOngoing: true,
      ),
    );
  }

  Future<void> setAudioSource(String url) async {
    YoutubeAudioMetaInfo youtubeAudioMetaInfo =
        await YoutubeHelper.extractAudioMetaInfoFromURL(url);

    // 오디오 스트림을 설정합니다.
    Duration? audioDuration =
        await _instance._audioPlayer.setUrl(youtubeAudioMetaInfo.url);

    final currentMediaItem = mediaItem.valueOrNull;

    // MediaItem 중복 확인
    // - 중복되는 값에 대해 UI 업데이트를 방지하기 위함
    if (currentMediaItem == null || currentMediaItem.id != url) {
      Map<String, dynamic> map = <String, dynamic>{};
      map.putIfAbsent("audioDuration",
          () => audioDuration?.inSeconds ?? Duration.zero.inSeconds);

      mediaItem.add(
        MediaItem(
          id: youtubeAudioMetaInfo.url,
          title: youtubeAudioMetaInfo.title,
          artist: youtubeAudioMetaInfo.artist,
          duration: _audioPlayer.duration,
          extras: map,
        ),
      );
    }
  }

  @override
  Future<void> play() => _audioPlayer.play();

  @override
  Future<void> pause() => _audioPlayer.pause();

  @override
  Future<void> stop() => _audioPlayer.stop();

  @override
  Future<void> seek(Duration position) => _audioPlayer.seek(position);
}
