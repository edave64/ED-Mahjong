import 'dart:math';

import 'package:ed_mahjong/engine/layouts/layout_meta.dart';
import 'package:ed_mahjong/screens/game.dart';
import 'package:ed_mahjong/widgets/layoutPreview.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyHomePage extends StatefulWidget {
  static const Route = '/';
  MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
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
            print(cols);
            return GridView.count(
              crossAxisCount: cols,
              children: list.map((item) {
                return InkWell(
                  child: LayoutPreview(
                    layoutMeta: item.value,
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
