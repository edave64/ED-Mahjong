import 'package:flutter/material.dart';
import 'package:flutter_app/engine/layouts/layout.dart';
import 'package:flutter_app/engine/layouts/layout_meta.dart';
import 'package:flutter_app/engine/pieces/game_board.dart';
import 'package:flutter_app/engine/tileset/tileset_flutter.dart';
import 'package:flutter_app/engine/tileset/tileset_meta.dart';
import 'package:flutter_app/engine/tileset/tileset_renderer.dart';
import 'package:flutter_app/preferences.dart';
import 'package:provider/provider.dart';

class GamePageArguments {
  GamePageArguments(this.layout);
  final String layout;
}

class GamePage extends StatefulWidget {
  static const Route = '/game';
  final String layout;
  GamePage({Key? key, required this.layout}) : super(key: key);

  @override
  _GamePageState createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  GameBoard? board;
  bool ready = false;

  @override
  initState() {
    super.initState();
  }

  load() async {
    try {
      final args =
          ModalRoute.of(context)!.settings.arguments as GamePageArguments;
      final awaits1 = await Future.wait([
        LayoutMetaCollection.Load(context),
        LoadTilesets(context),
        Preferences.Instance
      ]);
      final layoutMetas = awaits1[0] as LayoutMetaCollection;
      final tilesetMetas = awaits1[1] as TilesetMetaCollection;
      final preferences = awaits1[2] as Preferences;

      final layoutMeta = layoutMetas.get(args.layout);
      final tilesetMeta = tilesetMetas.get(preferences.tileset);

      final awaits2 = await Future.wait([
        layoutMeta.getLayout(),
        tilesetMeta.getRenderer(),
      ]);

      final layout = awaits2[0] as Layout;
      final tilesetRenderer = awaits2[1] as TilesetRenderer;
      ready = true;
    } catch (e) {}
  }

  @override
  Widget build(BuildContext context) {
    if (board == null) throw Exception("");
    final args =
        ModalRoute.of(context)!.settings.arguments as GamePageArguments;
    return Scaffold(
        appBar: AppBar(
          title: Text('Ingame'),
        ),
        body: Consumer2<LayoutMetaCollection?, Preferences?>(builder: (context,
            LayoutMetaCollection? layouts, Preferences? prefs, child) {
          if (layouts == null || prefs == null)
            return Center(child: Text("Loading..."));
          return Text("Loaded");
        }));
  }
}
