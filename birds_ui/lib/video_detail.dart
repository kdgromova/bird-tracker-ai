import 'package:birds_ui/models/bird_video.dart';
import 'package:birds_ui/models/video.dart';
import 'package:birds_ui/video_player.dart';
import 'package:flutter/material.dart';
import 'models/bird.dart';
import 'package:intl/intl.dart';

class VideoDetail extends StatelessWidget {
  final Video video;

  VideoDetail(this.video);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text("Video")),
        body: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: _renderBody(context, video)));
  }

  List<Widget> _renderBody(BuildContext context, Video video) {
    var result = <Widget>[];
    result.add(_bannerVideo(video.url, 250.0));
    result.add(Container(
        padding: const EdgeInsets.fromLTRB(16, 16, 0, 0),
        child: const Text(
          "Birds in this video:",
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
        )));
    result.add(_renderBirds(context, video));
    return result;
  }

  Widget _renderBirds(BuildContext context, Video video) {
    return Expanded(
        child: ListView.separated(
      padding: const EdgeInsets.fromLTRB(0, 16.0, 16.0, 16.0),
      itemCount: video.birdVideos.length,
      itemBuilder: _listViewItemBuilder,
      separatorBuilder: (context, index) {
        return const Divider();
      },
    ));
  }

  Widget _listViewItemBuilder(BuildContext context, int index) {
    var birdVideo = video.birdVideos[index];
    return ListTile(
      title: Text(birdVideo.birdName),
      subtitle: _itemSubtitle(birdVideo),
      // onTap: () => _navigationToBirdDetail(context, _birds[index].birdName),
    );
  }

  Widget _itemSubtitle(BirdVideo birdVideo) {
    final DateFormat formatter = DateFormat.yMd().add_jm();
    final createdAt = formatter.format(birdVideo.createdAt);
    return Container(
        padding: const EdgeInsets.fromLTRB(0, 5, 0, 0),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(
              "${birdVideo.speciesCount} out of ${birdVideo.processedFrames} frames"),
          Text("Created: " + createdAt)
        ]));
  }

  // Widget _renderDescription(String description) {
  //   return Container(
  //     padding: const EdgeInsets.all(16),
  //     child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
  //       Container(
  //           padding: const EdgeInsets.fromLTRB(0, 16, 0, 16),
  //           child: const Text("About",
  //               textAlign: TextAlign.left, style: TextStyle(fontSize: 25))),
  //       Text(
  //         description,
  //         style: const TextStyle(height: 1.5, fontSize: 14),
  //         textAlign: TextAlign.justify,
  //       )
  //     ]),
  //   );
  // }

  Widget _bannerVideo(String url, double height) {
    return VideoPlayer(url: video.url);
  }
}
