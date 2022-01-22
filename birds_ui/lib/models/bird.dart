import 'package:birds_ui/models/video_short.dart';

class Bird {
  final String birdName;
  final String description;
  final String imageUrl;
  //TODO add video list
  final List<VideoShort> videos;

  Bird(this.birdName, this.description, this.imageUrl, this.videos);
}
