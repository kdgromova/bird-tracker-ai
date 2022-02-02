import 'package:flutter/material.dart';
import 'bird_list.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home: BirdList());
  }
}
