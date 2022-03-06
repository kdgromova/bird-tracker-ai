import 'package:flutter/material.dart';
import 'dart:async';
// import 'location_detail.dart';
// import 'styles.dart';
import 'models/bird_short.dart';
import 'package:intl/intl.dart';
import 'bird_detail.dart';

class BirdList extends StatefulWidget {
  const BirdList({Key? key}) : super(key: key);

  @override
  createState() => _BirdListState();
}

class _BirdListState extends State<BirdList> {
  Future<List<BirdShort>> _birdsFuture = BirdShort.fetchAll();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('My Birds'),
        ),
        body: RefreshIndicator(
          onRefresh: _refreshData,
          child: Center(
              child: Container(
                  alignment: Alignment.center,
                  constraints: const BoxConstraints(maxWidth: 700),
                  child: FutureBuilder<List<BirdShort>>(
                    future: _birdsFuture,
                    builder: (BuildContext context,
                        AsyncSnapshot<List<BirdShort>> snapshot) {
                      if (snapshot.hasData) {
                        var birds = snapshot.data!;
                        return _renderListView(birds);
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
    _birdsFuture = BirdShort.fetchAll();
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

  Column _renderError(AsyncSnapshot<List<BirdShort>> snapshot) {
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

  ListView _renderListView(List<BirdShort> birds) {
    return ListView.separated(
      padding: const EdgeInsets.all(16.0),
      itemCount: birds.length,
      itemBuilder: (BuildContext context, int index) {
        var bird = birds[index];
        return ListTile(
          // leading: _itemThumbnail(location),
          title: _itemTitle(bird),
          subtitle: _itemSubtitle(bird),
          trailing: Chip(
              label: Text(bird.counter.toString(),
                  style: const TextStyle(color: Colors.white)),
              backgroundColor: Theme.of(context).colorScheme.secondary),
          onTap: () => _navigationToBirdDetail(context, bird.birdName),
        );
      },
      separatorBuilder: (context, index) {
        return const Divider();
      },
    );
  }

  void _navigationToBirdDetail(BuildContext context, String birdName) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => BirdDetail(birdName)));
  }

  // Widget _itemThumbnail(Location location) {
  //   return Container(
  //     constraints: BoxConstraints.tightFor(width: 100.0),
  //     child: Image.network(
  //       location.url,
  //       fit: BoxFit.fitHeight,
  //     ),
  //   );
  // }

  Widget _itemTitle(BirdShort bird) {
    return Text(bird.birdName);
  }

  Widget _itemSubtitle(BirdShort bird) {
    final DateFormat formatter = DateFormat.yMd().add_jm();
    final lastSeen = formatter.format(bird.lastSeen);
    return Text("Last Seen: " + lastSeen);
  }
}
