import 'package:birds_ui/models/bird_video.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Video {
  final String filename;
  final String url;
  final List<BirdVideo> birdVideos; // multiple records of bird-video pairs

  Video(this.filename, this.birdVideos)
      : url = "http://bird-feeder-videos.s3.us-east-1.amazonaws.com/$filename";

  factory Video.fromJson(String filename, List<dynamic> json) {
    List<BirdVideo> videos =
        json.map((item) => BirdVideo.fromJson(item)).toList();
    return Video(filename, videos);
  }

  static Future<Video> fetchOne(String filename) async {
    String urlSafeFilename = filename.replaceAll('/', '_');
    var uri = Uri.parse(
        'https://qc9afhnyli.execute-api.us-east-1.amazonaws.com/videos/$urlSafeFilename');
    final resp = await http.get(uri);

    if (resp.statusCode != 200) {
      throw (resp.body);
    }

    List birdVideos = json.decode(resp.body)['birds'];
    return Video.fromJson(filename, birdVideos);
  }
}
