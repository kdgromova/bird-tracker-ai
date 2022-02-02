import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class BirdShort {
  final String birdName;
  final int counter;
  final DateTime lastSeen;

  BirdShort(String PK, this.counter, String lastSeen)
      : birdName = PK.split("#")[1],
        lastSeen =
            DateFormat("yyyy-MM-ddTHH:mm:ss").parse(lastSeen, true).toLocal();

  factory BirdShort.fromJson(Map<String, dynamic> json) {
    return BirdShort(json['PK'], json['cnt'], json['last_seen']);
  }

  static Future<List<BirdShort>> fetchAll() async {
    var uri = Uri.parse(
        'https://qc9afhnyli.execute-api.us-east-1.amazonaws.com/birds');
    final resp = await http.get(uri);

    if (resp.statusCode != 200) {
      throw (resp.body);
    }
    List<BirdShort> list = <BirdShort>[];
    for (var jsonItem in json.decode(resp.body)['birds']) {
      list.add(BirdShort.fromJson(jsonItem));
    }
    list.sort((a, b) => b.lastSeen.compareTo(a.lastSeen));
    return list;
  }
}
