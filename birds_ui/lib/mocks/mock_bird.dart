import 'package:birds_ui/models/bird_video.dart';

import '../models/bird.dart';

mixin BirdMock on Bird {
  static final List<Bird> birds = [
    Bird(
        'HOUSE FINCH',
        "The house finch (Haemorhous mexicanus) is a bird in the finch family Fringillidae. It is native to western North America and has been introduced to the eastern half of the continent and Hawaii. This species and the other \"American rosefinches\" are placed in the genus Haemorhous.",
        'https://upload.wikimedia.org/wikipedia/commons/thumb/3/30/Carpodacus_mexicanus_-Madison%2C_Wisconsin%2C_USA-8.jpg/440px-Carpodacus_mexicanus_-Madison%2C_Wisconsin%2C_USA-8.jpg',
        <BirdVideo>[
          BirdVideo("species#HOUSE FINCH", "video#2022/01/13/08-42-32.mp4",
              "2022-01-13T13:42:32.095154+00:00", 48, 43),
          BirdVideo(
              "species#HOUSE FINCH",
              "video#2022/01/14/08-02-41.mp4video#2022/01/14/08-02-41.mp4",
              "2022-01-14T13:02:41.069629+00:00",
              47,
              18)
        ]),
    Bird(
        'NORTHERN CARDINAL',
        'The northern cardinal (Cardinalis cardinalis) is a bird in the genus Cardinalis; it is also known colloquially as the redbird, common cardinal, red cardinal, or just cardinal (which was its name prior to 1985). It can be found in southeastern Canada, through the eastern United States from Maine to Minnesota to Texas, New Mexico, southern Arizona, southern California, and south through Mexico, Belize, and Guatemala. It is also an introduced species in a few locations such as Bermuda and Hawaii. Its habitat includes woodlands, gardens, shrublands, and wetlands.',
        'https://upload.wikimedia.org/wikipedia/commons/thumb/d/da/Cardinal.jpg/440px-Cardinal.jpg',
        <BirdVideo>[
          BirdVideo(
              "species#NORTHERN CARDINAL",
              "video#2022/01/20/09-42-13.mp4",
              "2022-01-20T14:42:13.425686+00:00",
              30,
              18),
          BirdVideo(
              "species#NORTHERN CARDINAL",
              "video#2022/01/21/08-03-21.mp4",
              "2022-01-21T13:03:21.348400+00:00",
              2,
              10)
        ])
  ];
  static Bird fetchOne(String birdName) {
    return birds.firstWhere((bird) => bird.birdName == birdName);
  }
}
