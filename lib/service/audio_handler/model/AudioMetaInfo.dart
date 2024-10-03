abstract class AudioMetaInfo {

  String url;
  String title;
  String artist;
  Duration duration;

  AudioMetaInfo({
    required this.url,
    required this.title,
    required this.artist,
    required this.duration,
  });
}