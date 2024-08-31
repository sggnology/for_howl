import 'package:youtube_explode_dart/youtube_explode_dart.dart';

class YoutubeHelper {

  static Future<String> extractAudioURLFromYoutubeURL(String youtubeURL) async {

    // YoutubeExplode 인스턴스를 생성합니다.
    var yt = YoutubeExplode();

    try{
      var videoID = VideoId(youtubeURL).value;

      // 비디오 정보를 가져옵니다.
      var video = await yt.videos.get(VideoId(youtubeURL));

      print('Video title: ${video.title}');

      // 오디오 스트림을 가져옵니다.
      var manifest = await yt.videos.streamsClient.getManifest(videoID);
      var audioStreamInfo = manifest.audioOnly.withHighestBitrate();

      print("Audio Stream URL 추출 성공: ${audioStreamInfo.url}");

      return audioStreamInfo.url.toString();
    }
    on ArgumentError catch(e) {
      print('Invalid URL: $e');
    }
    catch(e) {
      print('Error: $e');
      print("Audio Stream URL 추출 실패");
    }
    finally {
      // YoutubeExplode 인스턴스를 닫습니다.
      yt.close();
    }

    return "";
  }
}