import 'package:birds_ui/mocks/mock_video.dart';
import 'package:birds_ui/models/bird_video.dart';
import 'package:birds_ui/video_detail.dart';
import 'package:flutter/material.dart';
import 'models/bird.dart';
import 'package:intl/intl.dart';

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
            children: _renderBody(context, bird)));
  }

  List<Widget> _renderBody(BuildContext context, Bird bird) {
    var result = <Widget>[];
    result.add(_bannerImage(bird.imageUrl, 250.0));
    result.add(_renderDescription(bird.description));
    result.add(_renderVideos(context, bird.videos));
    return result;
  }

  Widget _renderVideos(BuildContext context, List<BirdVideo> videos) {
    return Expanded(
        child: ListView.separated(
      padding: const EdgeInsets.fromLTRB(0, 16.0, 16.0, 16.0),
      itemCount: videos.length,
      itemBuilder: _listViewItemBuilder,
      separatorBuilder: (context, index) {
        return const Divider();
      },
    ));
  }

  Widget _listViewItemBuilder(BuildContext context, int index) {
    var video = bird.videos[index];
    final alreadySaved = false;
    return ListTile(
      leading: Container(
          child: const Icon(Icons.play_arrow, size: 40.0, color: Colors.black),
          height: double.infinity),
      title: const Text("Video"),
      subtitle: _itemSubtitle(video),
      trailing: Container(
          child: Icon(
            alreadySaved ? Icons.favorite : Icons.favorite_border,
            color: alreadySaved ? Colors.red : null,
            semanticLabel: alreadySaved ? 'Remove from saved' : 'Save',
            size: 30.0,
          ),
          height: double.infinity),
      onTap: () =>
          _navigationToVideoDetail(context, bird.videos[index].filename),
    );
  }

  Widget _itemSubtitle(BirdVideo video) {
    final DateFormat formatter = DateFormat.yMd().add_jm();
    final createdAt = formatter.format(video.createdAt);
    return Container(
        padding: const EdgeInsets.fromLTRB(0, 5, 0, 0),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text("${video.speciesCount} out of ${video.processedFrames} frames"),
          Text("Created: " + createdAt)
        ]));
  }

  Widget _renderDescription(String description) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Container(
            padding: const EdgeInsets.fromLTRB(0, 16, 0, 16),
            child: const Text("About",
                textAlign: TextAlign.left, style: TextStyle(fontSize: 25))),
        Text(
          description,
          style: const TextStyle(height: 1.5, fontSize: 14),
          textAlign: TextAlign.justify,
        )
      ]),
    );
  }

  Widget _bannerImage(String url, double height) {
    return Container(
      constraints: BoxConstraints.tightFor(height: height),
      child: Image.network(url, fit: BoxFit.fitWidth),
    );
  }

  void _navigationToVideoDetail(BuildContext context, String filename) {
    final video = VideoMock.fetchOne(filename);
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => VideoDetail(video)));
  }
}
