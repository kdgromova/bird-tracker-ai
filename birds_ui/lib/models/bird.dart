import 'package:birds_ui/models/bird_video.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Bird {
  final String birdName;
  final String? description;
  final String? imageUrl;
  final List<BirdVideo> videos;

  Bird(this.birdName, this.description, this.imageUrl, this.videos);

  factory Bird.fromJson(Map<String, dynamic> json) {
    Map<String, dynamic> stats = json['stats'];
    String birdName = stats['PK'].split("#")[1];
    String? description = stats['description'];
    String? url = stats['imageUrl'];
    List<BirdVideo> videos = (json['videos'] as List)
        .map((item) => BirdVideo.fromJson(item))
        .toList();
    return Bird(birdName, description, url, videos);
  }

  static Future<Bird> fetchOne(String birdName) async {
    var uri = Uri.parse(
        'https://qc9afhnyli.execute-api.us-east-1.amazonaws.com/birds/$birdName');
    final resp = await http.get(uri);

    if (resp.statusCode != 200) {
      throw (resp.body);
    }

    Map<String, dynamic> birdVideosMap = json.decode(resp.body);
    return Bird.fromJson(birdVideosMap);
  }
}
