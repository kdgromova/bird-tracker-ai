import 'package:birds_ui/models/bird_video.dart';

class Video {
  final String filename;
  final String url;
  final List<BirdVideo> birdVideos; // multiple records of bird-video pairs

  Video(this.filename, this.birdVideos)
      : url = "http://bird-feeder-videos.s3.us-east-1.amazonaws.com/$filename";
}
