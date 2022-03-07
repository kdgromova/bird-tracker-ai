import 'package:birds_ui/models/bird_video.dart';
import 'package:birds_ui/models/video.dart';
import 'package:birds_ui/video_player.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:beamer/beamer.dart';

class VideoDetail extends StatefulWidget {
  final String filename;

  VideoDetail(this.filename);

  @override
  createState() => _VideoDetailState(this.filename);
}

class _VideoDetailState extends State<VideoDetail> {
  final String filename;
  Future<Video> _videoFuture;

  _VideoDetailState(this.filename) : _videoFuture = Video.fetchOne(filename);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text("Video")),
        body: FutureBuilder<Video>(
          future: _videoFuture,
          builder: (BuildContext context, AsyncSnapshot<Video> snapshot) {
            if (snapshot.hasData) {
              var bird = snapshot.data!;
              return _renderBody(context, bird);
            } else if (snapshot.hasError) {
              return _renderError(snapshot);
            } else {
              return _renderLoader();
            }
          },
        ));
  }

  Widget _renderLoader() {
    return Container(
        padding: const EdgeInsets.all(20),
        child: Center(
            child: Column(children: const [
          SizedBox(
            width: 60,
            height: 60,
            child: CircularProgressIndicator(),
          ),
          Padding(
            padding: EdgeInsets.only(top: 16),
            child: Text('Awaiting result...'),
          )
        ])));
  }

  Column _renderError(AsyncSnapshot<Video> snapshot) {
    return Column(children: [
      const Icon(
        Icons.error_outline,
        color: Colors.red,
        size: 60,
      ),
      Padding(
        padding: const EdgeInsets.only(top: 16),
        child: Text('Error: ${snapshot.error}'),
      )
    ]);
  }

  Widget _renderBody(BuildContext context, Video video) {
    var result = <Widget>[];
    result.add(_bannerVideo(video.url));
    result.add(Container(
        padding: const EdgeInsets.fromLTRB(16, 16, 0, 0),
        child: const Text(
          "Birds in this video:",
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
        )));
    result.add(_renderBirds(context, video));
    return SingleChildScrollView(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: result));
  }

  Widget _renderBirds(BuildContext context, Video video) {
    return ListView.separated(
        shrinkWrap: true,
        padding: const EdgeInsets.fromLTRB(0, 16.0, 16.0, 16.0),
        itemCount: video.birdVideos.length,
        itemBuilder: (BuildContext context, int index) {
          var birdVideo = video.birdVideos[index];
          return ListTile(
              title: Text(birdVideo.birdName),
              subtitle: _itemSubtitle(birdVideo),
              onTap: () => context.beamToNamed('/birds/${birdVideo.birdName}'));
        },
        separatorBuilder: (context, index) {
          return const Divider();
        });
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

  Widget _bannerVideo(String url) {
    return VideoPlayer(url: url);
  }
}
