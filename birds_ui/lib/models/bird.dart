import 'package:birds_ui/models/bird_video.dart';

class Bird {
  final String birdName;
  final String description;
  final String imageUrl;
  final List<BirdVideo> videos;

  Bird(this.birdName, this.description, this.imageUrl, this.videos);
}
