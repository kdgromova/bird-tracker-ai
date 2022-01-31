import 'package:intl/intl.dart';

class BirdVideo {
  final String birdName;
  final String filename;
  final DateTime createdAt;
  final int processedFrames;
  final int speciesCount;

  BirdVideo(String PK, String SK, String createdAt, this.processedFrames, this.speciesCount)
      : birdName = PK.split("#")[1],
        filename = SK.split('#')[1],
        createdAt =
            DateFormat("yyyy-MM-ddTHH:mm:ss").parse(createdAt, true).toLocal();
}
