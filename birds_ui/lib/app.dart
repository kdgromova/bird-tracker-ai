import 'package:birds_ui/bird_detail.dart';
import 'package:birds_ui/video_detail.dart';
import 'package:flutter/material.dart';
import 'bird_list.dart';
import 'package:beamer/beamer.dart';

class App extends StatelessWidget {
  App({Key? key}) : super(key: key);

  final routerDelegate = BeamerDelegate(
      locationBuilder: RoutesLocationBuilder(
        routes: {
          // Return either Widgets or BeamPages if more customization is needed
          '/birds': (context, state, data) => const BirdList(),
          '/birds/:birdName': (context, state, data) {
            final birdName = state.pathParameters['birdName']!;
            return BirdDetail(birdName);
          },
          '/birds/:birdName/:filename': (context, state, data) {
            final filename = state.pathParameters['filename']!;
            return VideoDetail(filename);
          }
        },
      ),
      notFoundRedirectNamed: '/birds');

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routeInformationParser: BeamerParser(),
      routerDelegate: routerDelegate,
      backButtonDispatcher:
          BeamerBackButtonDispatcher(delegate: routerDelegate),
    );
  }
}
