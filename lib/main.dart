import 'package:ed_mahjong/engine/backgrounds/background_flutter.dart';
import 'package:ed_mahjong/engine/backgrounds/background_meta.dart';
import 'package:ed_mahjong/engine/layouts/layout_meta.dart';
import 'package:ed_mahjong/engine/tileset/tileset_flutter.dart';
import 'package:ed_mahjong/engine/tileset/tileset_meta.dart';
import 'package:ed_mahjong/preferences.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'screens/game/game_screen.dart';
import 'screens/home.dart';
import 'screens/settings/settings_screen.dart';

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
          FutureProvider<BackgroundMetaCollection?>(
              create: (context) => loadBackgrounds(context), initialData: null),
          FutureProvider(
              create: (context) => Preferences.instance, initialData: null),
        ],
        child: MaterialApp(
          title: 'ED Mahjong',
          theme: ThemeData(
            primarySwatch: Colors.amber,
            accentColor: Colors.amber,
            brightness: Brightness.light,
          ),
          darkTheme: ThemeData(
            primarySwatch: Colors.amber,
            accentColor: Colors.amber,
            brightness: Brightness.dark,
            /* dark theme settings */
          ),
          themeMode: ThemeMode.system,
          onGenerateRoute: (routeSettings) {
            final name = routeSettings.name;
            if (name == null || name == '/')
              return MaterialPageRoute(builder: (context) => MyHomePage());

            var uri = Uri.parse(name);
            if (uri.pathSegments.first == 'game') {
              return GamePage.generateRoute(routeSettings, uri);
            }

            if (uri.pathSegments.first == 'settings') {
              return SettingsPage.generateRoute(routeSettings, uri);
            }

            return MaterialPageRoute(builder: (context) => MyHomePage());
          },
        ));
  }
}
