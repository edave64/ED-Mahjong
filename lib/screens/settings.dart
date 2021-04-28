import 'dart:ui';

import 'package:ed_mahjong/engine/pieces/mahjong_tile.dart';
import 'package:ed_mahjong/engine/tileset/tileset_meta.dart';
import 'package:ed_mahjong/preferences.dart';
import 'package:ed_mahjong/screens/settings_tileset.dart';
import 'package:ed_mahjong/widgets/tile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SettingsPage extends StatefulWidget {
  static const Route = '/settings';
  SettingsPage({Key? key}) : super(key: key);

  @override
  _SettingsPageState createState() => _SettingsPageState();

  static MaterialPageRoute generateRoute(RouteSettings routeSettings, Uri uri) {
    if (uri.pathSegments.length > 1 && uri.pathSegments[1] == 'tileset') {
      return MaterialPageRoute(builder: (context) => SettingsTilesetPage());
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
        body: Consumer<Preferences?>(
          builder: (context, Preferences? preferences, child) {
            final locale = PlatformDispatcher.instance.locale;
            if (preferences == null) return Text("");
            return ListView(
              children: <Widget>[
                Consumer<TilesetMetaCollection?>(
                    builder: (context, TilesetMetaCollection? tilesets, child) {
                  if (tilesets == null) {
                    return ListTile(title: Text(preferences.tileset));
                  }
                  final tileset = tilesets.get(preferences.tileset);
                  return ListTile(
                    leading: previewTile(tileset),
                    title:
                        Text('Tileset: ${tileset.name.toLocaleString(locale)}'),
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        '/settings/tileset',
                      ).then((value) => this.setState(() {}));
                    },
                  );
                }),
                ListTile(
                  title: Row(
                    children: [
                      Text("Maximum retries: "),
                      TextButton(onPressed: () {}, child: Icon(Icons.remove)),
                      Text("Infinite"),
                      TextButton(onPressed: () {}, child: Icon(Icons.add)),
                    ],
                  ),
                ),
              ],
            );
          },
        ));
  }
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
