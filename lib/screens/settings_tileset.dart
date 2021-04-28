import 'dart:ui';

import 'package:ed_mahjong/engine/tileset/tileset_meta.dart';
import 'package:ed_mahjong/preferences.dart';
import 'package:ed_mahjong/screens/settings.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SettingsTilesetPage extends StatelessWidget {
  static const Route = '/settings/tilesets';
  SettingsTilesetPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tileset'),
      ),
      body: Consumer2<Preferences?, TilesetMetaCollection?>(builder: (context,
          Preferences? preferences, TilesetMetaCollection? tilesets, child) {
        final locale = PlatformDispatcher.instance.locale;
        if (preferences == null || tilesets == null) return Text("");
        return LayoutBuilder(builder: (context, size) {
          return ListView(
              itemExtent: 50,
              children: tilesets
                  .list()
                  .map((tileset) => ListTile(
                        leading: previewTile(tileset),
                        title: Text('${tileset.name.toLocaleString(locale)}'),
                        onTap: () {
                          preferences.tileset = tileset.basename;
                          Navigator.of(context).pop();
                        },
                      ))
                  .toList());
        });
      }),
    );
  }
}
