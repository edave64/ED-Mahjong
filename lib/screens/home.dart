import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_app/engine/layouts/layout_meta.dart';
import 'package:flutter_app/screens/game.dart';
import 'package:flutter_app/widgets/layoutPreview.dart';
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
    final locale = PlatformDispatcher.instance.locale;

    return Scaffold(
      appBar: AppBar(
        title: Text('Mahjong'),
      ),
      body: Center(
        child: Consumer<LayoutMetaCollection?>(
            builder: (context, LayoutMetaCollection? layouts, child) {
          final List<LayoutMeta> list =
              layouts == null ? [] : [...layouts.list()];
          list.sort((a, b) {
            if (a.basename == 'default.desktop') return -1;
            if (b.basename == 'default.desktop') return 1;
            final aString = a.name.toString();
            final bString = b.name.toString();
            return aString.compareTo(bString);
          });
          return LayoutBuilder(builder: (context, contraints) {
            final cols = max((contraints.maxWidth / 150).floor(), 2);
            print(cols);
            return GridView.count(
              crossAxisCount: cols,
              children: list.map((item) {
                return InkWell(
                  child: LayoutPreview(
                    layoutMeta: item,
                  ),
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      '${GamePage.Route}/${item.basename}',
                    );
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
