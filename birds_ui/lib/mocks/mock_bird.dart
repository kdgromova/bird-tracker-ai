import '../models/bird.dart';

mixin BirdMock on Bird {
  static final List<Bird> birds = [
    Bird(
        'HOUSE FINCH',
        "The house finch (Haemorhous mexicanus) is a bird in the finch family Fringillidae. It is native to western North America and has been introduced to the eastern half of the continent and Hawaii. This species and the other \"American rosefinches\" are placed in the genus Haemorhous.",
        'https://upload.wikimedia.org/wikipedia/commons/thumb/3/30/Carpodacus_mexicanus_-Madison%2C_Wisconsin%2C_USA-8.jpg/440px-Carpodacus_mexicanus_-Madison%2C_Wisconsin%2C_USA-8.jpg'),
    Bird(
        'NORTHERN CARDINAL',
        'The northern cardinal (Cardinalis cardinalis) is a bird in the genus Cardinalis; it is also known colloquially as the redbird, common cardinal, red cardinal, or just cardinal (which was its name prior to 1985). It can be found in southeastern Canada, through the eastern United States from Maine to Minnesota to Texas, New Mexico, southern Arizona, southern California, and south through Mexico, Belize, and Guatemala. It is also an introduced species in a few locations such as Bermuda and Hawaii. Its habitat includes woodlands, gardens, shrublands, and wetlands.',
        'https://upload.wikimedia.org/wikipedia/commons/thumb/d/da/Cardinal.jpg/440px-Cardinal.jpg')
  ];
  static Bird fetchOne(String birdName) {
    return birds.firstWhere((bird) => bird.birdName == birdName);
  }
}
