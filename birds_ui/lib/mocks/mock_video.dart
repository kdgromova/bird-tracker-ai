import 'package:birds_ui/models/bird_video.dart';
import 'package:birds_ui/models/video.dart';

import '../models/bird.dart';

mixin VideoMock on Video {
  static final Video video = Video('2022/01/25/07-26-44.mp4', <BirdVideo>[
    BirdVideo("species#HOUSE FINCH", "video#2022/01/25/07-26-44.mp4",
        "2022-01-13T13:42:32.095154+00:00", 48, 43),
    BirdVideo("species#NORTHERN CARDINAL", "video#2022/01/25/07-26-44.mp4",
        "2022-01-13T13:42:32.095154+00:00", 48, 18)
  ]);

  static Video fetchOne(String filename) {
    return VideoMock.video;
  }
}
