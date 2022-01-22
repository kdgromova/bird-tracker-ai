import 'package:birds_ui/models/bird_short.dart';

mixin MockBirdShort on BirdShort {
  static final List<BirdShort> birds = [
    BirdShort('species#HOUSE FINCH', 50, '2022-01-20T21:25:22.444127+00:00'),
    BirdShort(
        'species#NORTHERN CARDINAL', 1, '2022-01-19T21:00:22.444127+00:00')
  ];
  static List<BirdShort> fetchAll() {
    return birds;
  }
}
