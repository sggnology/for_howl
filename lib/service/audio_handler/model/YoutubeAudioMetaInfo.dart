import 'package:for_howl/service/audio_handler/model/AudioMetaInfo.dart';

class YoutubeAudioMetaInfo extends AudioMetaInfo {
  final String url;
  final String title;
  final String artist;
  final Duration duration;
  String? thumbnailUrl;

  YoutubeAudioMetaInfo({
    required this.url,
    required this.title,
    required this.artist,
    required this.duration,
    this.thumbnailUrl,
  }): super(
    url: url,
    title: title,
    artist: artist,
    duration: duration,
  );

  @override
  String toString() {
    return 'YoutubeAudioMetaInfo{url: $url, title: $title, artist: $artist, duration: $duration, thumbnailUrl: $thumbnailUrl}';
  }
}