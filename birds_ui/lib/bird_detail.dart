import 'package:flutter/material.dart';
import 'models/bird.dart';

class BirdDetail extends StatelessWidget {
  final Bird bird;

  BirdDetail(this.bird);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text(bird.birdName)),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: _renderBody(context, bird),
        ));
  }

  List<Widget> _renderBody(BuildContext context, Bird bird) {
    var result = <Widget>[];
    result.add(_bannerImage(bird.imageUrl, 250.0));
    result.add(_renderDescription(bird.description));

    // result.addAll(_renderFacts(context, location));
    return result;
  }

  // List<Widget> _renderFacts(BuildContext context, Location location) {
  //   var result = <Widget>[];
  //   for (int i = 0; i < location.facts.length; i++) {
  //     result.add(_sectionTitle(location.facts[i].title));
  //     result.add(_sectionText(location.facts[i].text));
  //   }
  //   return result;
  // }

  // Widget _sectionTitle(String text) {
  //   return Container(
  //       padding: EdgeInsets.fromLTRB(25.0, 25.0, 25.0, 10.0),
  //       child:
  //           Text(text, textAlign: TextAlign.left, style: Styles.headerLarge));
  // }

  // Widget _sectionText(String text) {
  //   return Container(
  //       padding: EdgeInsets.fromLTRB(25.0, 15.0, 25.0, 15.0),
  //       child: Text(text, style: Styles.textDefault));
  // }

  Widget _renderDescription(String description) {
    return Container(
      // constraints: BoxConstraints.tightFor(height: height),
      child: Text(description),
    );
  }

  Widget _bannerImage(String url, double height) {
    return Container(
      constraints: BoxConstraints.tightFor(height: height),
      child: Image.network(url, fit: BoxFit.fitWidth),
    );
  }
}
