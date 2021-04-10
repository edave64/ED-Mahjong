import 'package:flutter/material.dart';
import 'package:flutter_app/engine/layouts/layout_meta.dart';
import 'package:flutter_app/preferences.dart';
import 'package:provider/provider.dart';

import 'screens/game.dart';
import 'screens/home.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          FutureProvider<LayoutMetaCollection?>(
              create: (context) => LayoutMetaCollection.Load(context),
              initialData: null),
          FutureProvider(
              create: (context) => Preferences.Instance, initialData: null)
        ],
        child: MaterialApp(
          title: 'Flutter Demo',
          theme:
              ThemeData(primarySwatch: Colors.amber, accentColor: Colors.brown),
          routes: {
            '/': (context) => MyHomePage(),
            '/game': (context) => GamePage(layout: ""),
          },
        ));
  }
}
