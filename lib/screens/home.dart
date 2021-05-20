import 'dart:math';

import 'package:ed_mahjong/engine/highscore_storage.dart';
import 'package:ed_mahjong/engine/layouts/layout_meta.dart';
import 'package:ed_mahjong/screens/game/game_screen.dart';
import 'package:ed_mahjong/widgets/layout_preview.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyHomePage extends StatefulWidget {
  static const Route = '/';
  MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Map<String, int>? _times;

  _MyHomePageState() {
    loadInit();
  }

  loadInit() async {
    final times = await highscoreDB.getTimes();
    highscoreDB.onChange(() {
      setState(() {});
    });
    setState(() {
      _times = times;
    });
  }

  @override
  Widget build(BuildContext context) {
    final times = _times ?? {};
    return Scaffold(
      appBar: AppBar(
        title: Text('ED Mahjong'),
      ),
      body: Center(
        child: Consumer<LayoutMetaCollection?>(
            builder: (context, LayoutMetaCollection? layouts, child) {
          final List<MapEntry<String, LayoutMeta>> list = layouts == null
              ? []
              : [
                  ...layouts.list().map((item) {
                    String key = item.name.toString();
                    if (item.basename == 'default.desktop') key = "";
                    return MapEntry(key, item);
                  })
                ];
          list.sort((a, b) {
            return a.key.compareTo(b.key);
          });
          return LayoutBuilder(builder: (context, contraints) {
            final cols = max((contraints.maxWidth / 150).floor(), 2);
            return GridView.count(
              crossAxisCount: cols,
              children: list.map((item) {
                return InkWell(
                  child: LayoutPreview(
                    layoutMeta: item.value,
                    time: times[item.value.basename],
                  ),
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      '${GamePage.Route}/${item.value.basename}',
                    );
                    setState(() {});
                  },
                );
              }).toList(),
            );
          });
        }),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(
            context,
            '/settings',
          );
        },
        tooltip: 'Settings',
        child: Icon(Icons.settings),
      ),
    );
  }
}
