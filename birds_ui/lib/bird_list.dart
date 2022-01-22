import 'package:flutter/material.dart';
// import 'location_detail.dart';
// import 'styles.dart';
import 'models/bird_short.dart';
import 'package:intl/intl.dart';
import 'package:badges/badges.dart';
import 'models/bird.dart';
import 'mocks/mock_bird.dart';
import 'bird_detail.dart';

class BirdList extends StatelessWidget {
  final List<BirdShort> _birds;

  BirdList(this._birds);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Birds'
            // style: Styles.navBarTitle,
            ),
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(16.0),
        itemCount: _birds.length,
        itemBuilder: _listViewItemBuilder,
        separatorBuilder: (context, index) {
          return const Divider();
        },
      ),
    );
  }

  Widget _listViewItemBuilder(BuildContext context, int index) {
    var bird = _birds[index];
    return ListTile(
      // leading: _itemThumbnail(location),
      title: _itemTitle(bird),
      subtitle: _itemSubtitle(bird),
      trailing: Chip(
          label: Text(bird.counter.toString(),
              style: TextStyle(color: Colors.white)),
          backgroundColor: Theme.of(context).colorScheme.secondary),
      onTap: () => _navigationToBirdDetail(context, _birds[index].birdName),
    );
  }

  void _navigationToBirdDetail(BuildContext context, String birdName) {
    final bird = BirdMock.fetchOne(birdName);
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => BirdDetail(bird)));
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
    // return Badge(
    //   badgeContent: Text('3'),
    //   child: Icon(Icons.settings),
    // );
  }

  Widget _itemSubtitle(BirdShort bird) {
    final DateFormat formatter = DateFormat.yMd().add_jm();
    final lastSeen = formatter.format(bird.lastSeen);
    return Text("Last Seen: " + lastSeen);
  }
}
