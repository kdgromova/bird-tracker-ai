import 'package:intl/intl.dart';

class BirdShort {
  final String birdName;
  final int counter;
  final DateTime lastSeen;

  BirdShort(String PK, this.counter, String lastSeen)
      : birdName = PK.split("#")[1],
        lastSeen =
            DateFormat("yyyy-MM-ddTHH:mm:ss").parse(lastSeen, true).toLocal();
}
