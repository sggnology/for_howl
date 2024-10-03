import 'package:audio_service/audio_service.dart';
import 'package:just_audio/just_audio.dart';

class MyAudioHandler extends BaseAudioHandler {
  final _audioPlayer = AudioPlayer();

  MyAudioHandler() {
    // 플레이백 상태 업데이트
    _audioPlayer.playbackEventStream.listen((event) {
      playbackState.add(_transformEvent(event));
    });
  }

  Future<void> setAudioSource(String url) async {
    await _audioPlayer.setUrl(url);
    // final duration = _audioPlayer.duration;

    final currentMediaItem = mediaItem.valueOrNull;

    // MediaItem 중복 확인
    // - 중복되는 값에 대해 UI 업데이트를 방지하기 위함
    if(currentMediaItem == null || currentMediaItem.id != url) {
      mediaItem.add(MediaItem(
        id: url,
        title: "Audio Title",
        artist: "Artist Name",
        duration: _audioPlayer.duration,
      ));
    }
  }

  PlaybackState _transformEvent(PlaybackEvent event) {
    return PlaybackState(
      controls: [
        MediaControl.play,
        MediaControl.pause,
        MediaControl.stop,
      ],
      androidCompactActionIndices: const [0, 1, 2],
      processingState: _convertProcessingState(_audioPlayer.processingState),
      playing: _audioPlayer.playing,
      updatePosition: _audioPlayer.position,
      bufferedPosition: _audioPlayer.bufferedPosition,
      speed: _audioPlayer.speed,
      systemActions: const {
        MediaAction.seekForward,
        MediaAction.seekBackward,
        MediaAction.seek,
      },
    );
  }

  AudioProcessingState _convertProcessingState(ProcessingState state) {
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

  @override
  Future<void> play() => _audioPlayer.play();

  @override
  Future<void> pause() => _audioPlayer.pause();

  @override
  Future<void> stop() => _audioPlayer.stop();

  @override
  Future<void> seek(Duration position) => _audioPlayer.seek(position);
}