import 'package:flutter/material.dart';
import 'package:flutter_app/engine/layouts/layout_meta.dart';
import 'package:flutter_app/engine/tileset/tileset_flutter.dart';
import 'package:flutter_app/engine/tileset/tileset_meta.dart';
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
              create: (context) => LayoutMetaCollection.load(context),
              initialData: null),
          FutureProvider<TilesetMetaCollection?>(
              create: (context) => loadTilesets(context), initialData: null),
          FutureProvider(
              create: (context) => Preferences.instance, initialData: null)
        ],
        child: MaterialApp(
          title: 'Flutter Demo',
          theme:
              ThemeData(primarySwatch: Colors.amber, accentColor: Colors.brown),
          onGenerateRoute: (routeSettings) {
            final name = routeSettings.name;
            if (name == null || name == '/')
              return MaterialPageRoute(builder: (context) => MyHomePage());

            print(name);
            var uri = Uri.parse(name);
            if (uri.pathSegments.length == 2 &&
                uri.pathSegments.first == 'game') {
              var id = uri.pathSegments[1];
              return MaterialPageRoute(
                  builder: (context) => GamePage(layout: id));
            }

            if (name.startsWith(GamePage.Route)) {
              return GamePage.generateRoute(routeSettings);
            }
            return MaterialPageRoute(builder: (context) => MyHomePage());
          },
        ));
  }
}
