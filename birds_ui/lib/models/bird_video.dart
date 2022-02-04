import 'package:intl/intl.dart';

class BirdVideo {
  final String birdName;
  final String filename;
  final DateTime createdAt;
  final int processedFrames;
  final int speciesCount;

  BirdVideo(String PK, String SK, String createdAt, this.processedFrames,
      this.speciesCount)
      : birdName = PK.split("#")[1],
        filename = SK.split('#')[1],
        createdAt =
            DateFormat("yyyy-MM-ddTHH:mm:ss").parse(createdAt, true).toLocal();

  factory BirdVideo.fromJson(Map<String, dynamic> json) {
    return BirdVideo(json['PK'], json['SK'], json['created_at'],
        json['stats']['processed_frames'], json['stats']['species_count']);
  }
}
