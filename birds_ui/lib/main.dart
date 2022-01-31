import 'package:birds_ui/bird_list.dart';
import 'package:flutter/material.dart';
import 'mocks/mock_bird_short.dart';
import 'bird_list.dart';

void main() {
  final mockBirds = MockBirdShort.fetchAll();

  return runApp(MaterialApp(home: BirdList(mockBirds)));
}
