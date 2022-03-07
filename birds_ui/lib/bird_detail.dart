import 'package:beamer/beamer.dart';
import 'package:birds_ui/models/bird_video.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'models/bird.dart';
import 'package:intl/intl.dart';

class BirdDetail extends StatefulWidget {
  final String birdName;

  BirdDetail(this.birdName);

  @override
  createState() => _BirdDetailState(this.birdName);
}

class _BirdDetailState extends State<BirdDetail> {
  final String birdName;
  Future<Bird> _birdFuture;

  _BirdDetailState(this.birdName) : _birdFuture = Bird.fetchOne(birdName);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text(birdName)),
        body: RefreshIndicator(
          onRefresh: _refreshData,
          child: Center(
              child: Container(
                  alignment: Alignment.center,
                  constraints: const BoxConstraints(maxWidth: 700),
                  child: FutureBuilder<Bird>(
                    future: _birdFuture,
                    builder:
                        (BuildContext context, AsyncSnapshot<Bird> snapshot) {
                      if (snapshot.hasData) {
                        var bird = snapshot.data!;
                        return _renderBody(context, bird);
                      } else if (snapshot.hasError) {
                        return _renderError(snapshot);
                      } else {
                        return _renderLoader();
                      }
                    },
                  ))),
        ));
  }

  Future<void> _refreshData() async {
    _birdFuture = Bird.fetchOne(birdName);
    setState(() => {});
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

  Column _renderError(AsyncSnapshot<Bird> snapshot) {
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

  Widget _renderBody(BuildContext context, Bird bird) {
    var result = <Widget>[];
    if (bird.imageUrl != null) {
      result.add(_bannerImage(bird.imageUrl!, 250.0));
    }
    if (bird.description != null) {
      result.add(_renderDescription(bird.description!));
    }
    result.add(_renderVideos(context, bird.videos));
    return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: result);
  }

  Widget _renderVideos(BuildContext context, List<BirdVideo> videos) {
    return Expanded(
        child: ListView.separated(
      padding: const EdgeInsets.fromLTRB(0, 0, 16.0, 16.0),
      itemCount: videos.length,
      itemBuilder: (BuildContext context, int index) {
        var video = videos[index];
        final alreadySaved = false;
        return ListTile(
          leading: Container(
              child:
                  const Icon(Icons.play_arrow, size: 40.0, color: Colors.black),
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
              _navigationToVideoDetail(context, videos[index].filename),
        );
      },
      separatorBuilder: (context, index) {
        return const Divider();
      },
    ));
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
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
        child: ExpandablePanel(
          header: Container(
              child: const Text("About",
                  textAlign: TextAlign.left, style: TextStyle(fontSize: 25))),
          collapsed: Text(""),
          expanded: Container(
              padding: const EdgeInsets.fromLTRB(0, 0, 0, 16),
              child: Text(
                description,
                style: const TextStyle(height: 1.5, fontSize: 14),
                textAlign: TextAlign.justify,
              )),
        ));
  }

  Widget _bannerImage(String url, double height) {
    return Container(
      constraints: BoxConstraints.tightFor(height: height),
      child: Image.network(url, fit: BoxFit.fitWidth),
    );
  }

  void _navigationToVideoDetail(BuildContext context, String filename) {
    String urlSafeFilename = filename.replaceAll('/', '_');
    Beamer.of(context).beamToNamed("/birds/$birdName/$urlSafeFilename");
  }
}
