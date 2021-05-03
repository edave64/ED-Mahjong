import 'dart:ui';

import 'package:ed_mahjong/engine/backgrounds/background_meta.dart';
import 'package:ed_mahjong/engine/pieces/mahjong_tile.dart';
import 'package:ed_mahjong/engine/tileset/tileset_meta.dart';
import 'package:ed_mahjong/preferences.dart';
import 'package:ed_mahjong/screens/settings_background.dart';
import 'package:ed_mahjong/screens/settings_tileset.dart';
import 'package:ed_mahjong/widgets/tile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class SettingsPage extends StatefulWidget {
  static const Route = '/settings';
  SettingsPage({Key? key}) : super(key: key);

  @override
  _SettingsPageState createState() => _SettingsPageState();

  static MaterialPageRoute generateRoute(RouteSettings routeSettings, Uri uri) {
    if (uri.pathSegments.length > 1 && uri.pathSegments[1] == 'tileset') {
      return MaterialPageRoute(builder: (context) => SettingsTilesetPage());
    }
    if (uri.pathSegments.length > 1 && uri.pathSegments[1] == 'background') {
      return MaterialPageRoute(builder: (context) => SettingsBackgroundPage());
    }
    return MaterialPageRoute(builder: (context) => SettingsPage());
  }
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Settings'),
        ),
        body: Consumer3<Preferences?, TilesetMetaCollection?,
            BackgroundMetaCollection?>(
          builder: (context,
              Preferences? preferences,
              TilesetMetaCollection? tilesets,
              BackgroundMetaCollection? backgrounds,
              child) {
            if (preferences == null) return Text("");
            return ListView(
              children: <Widget>[
                ...tilesetListTiles(preferences, tilesets),
                ...backgroundListTiles(preferences, backgrounds),
                ListTile(
                  leading: Text("Maximum retries: "),
                  title: retryButtons(preferences),
                ),
                ListTile(
                  title: Text("About"),
                  onTap: () {
                    showAboutDialog(context: context, children: [
                      Text(
                          "An ad-free, open-source Mahjong Solitaire implementation."),
                      TextButton(
                          onPressed: () =>
                              launch("https://github.com/edave64/ED-Mahjong"),
                          child: Text("View source"))
                    ]);
                  },
                ),
              ],
            );
          },
        ));
  }

  Widget retryButtons(Preferences? preferences) {
    if (preferences == null) return Text("");

    final count = preferences.maxShuffles;

    return Row(
      children: [
        TextButton(
            onPressed: count == -1
                ? null
                : () {
                    preferences.maxShuffles--;
                    setState(() {});
                  },
            child: Icon(Icons.remove)),
        Text(count == -1 ? "Infinite" : "$count"),
        TextButton(
            onPressed: () {
              preferences.maxShuffles++;
              setState(() {});
            },
            child: Icon(Icons.add)),
      ],
    );
  }

  Iterable<ListTile> tilesetListTiles(
      Preferences preferences, TilesetMetaCollection? tilesets) {
    final locale = PlatformDispatcher.instance.locale;
    if (tilesets == null) {
      return [ListTile(title: Text(preferences.tileset))];
    }
    final tileset = tilesets.get(preferences.tileset);
    return [
      ListTile(
        leading: previewTile(tileset),
        title: Text('Tileset: ${tileset.name.toLocaleString(locale)}'),
        onTap: () {
          Navigator.pushNamed(
            context,
            '/settings/tileset',
          ).then((value) => this.setState(() {}));
        },
      ),
      ListTile(
        leading: Text('Author:'),
        title: Text("${tileset.author} (${tileset.authorEmail})"),
      ),
      if (tileset.description.toString() != "")
        ListTile(
          leading: Text('Description:'),
          title: Text(tileset.description.toLocaleString(locale)),
        )
    ];
  }

  Iterable<ListTile> backgroundListTiles(
      Preferences preferences, BackgroundMetaCollection? backgrounds) {
    final locale = PlatformDispatcher.instance.locale;
    final backgroundName = preferences.background;

    final onTap = () {
      Navigator.pushNamed(
        context,
        '/settings/background',
      ).then((value) => this.setState(() {}));
    };

    if (backgroundName == null) {
      return [ListTile(title: Text("Background: None"), onTap: onTap)];
    }
    if (backgrounds == null) {
      return [
        ListTile(title: Text("Background: $backgroundName"), onTap: onTap)
      ];
    }
    final background = backgrounds.get(backgroundName);
    return [
      ListTile(
        title: Text('Background: ${background.name.toLocaleString(locale)}'),
        onTap: onTap,
      ),
      ListTile(
        leading: Text('Author:'),
        title: Text(
            "${background.author} ${background.authorEmail != null ? background.authorEmail : ""}"),
      ),
    ];
  }

  retryCounterTile() {}
}

Widget previewTile(TilesetMeta tileset) {
  return Padding(
      padding: EdgeInsets.all(2.0),
      child: SizedBox(
          width: 50,
          height: 50,
          child: FittedBox(
              child: Tile(
                  type: MahjongTile.BAMBOO_1,
                  selected: false,
                  tilesetMeta: tileset))));
}
