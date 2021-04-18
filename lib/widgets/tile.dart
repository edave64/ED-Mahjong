import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_app/engine/layouts/layout_meta.dart';
import 'package:flutter_app/engine/tileset/tileset_meta.dart';
import 'package:path/path.dart';

typedef void Tap(int x, int y);

class Tile extends StatelessWidget {
  Tile(
      {key,
      required this.type,
      required this.layoutMeta,
      required this.tilesetMeta,
      required this.selected,
      required this.x,
      required this.y,
      this.onTap})
      : super(key: key);

  final String type;
  final TilesetMeta tilesetMeta;
  final LayoutMeta layoutMeta;
  final bool selected;
  final int x;
  final int y;
  final Tap? onTap;

  @override
  Widget build(BuildContext context) {
    final baseUrl =
        'assets/tilesets/${basenameWithoutExtension(tilesetMeta.fileName)}';
    return GestureDetector(
        onTap: () {
          final tap = onTap;
          if (tap != null) tap(x, y);
        },
        child: Stack(
          alignment: AlignmentDirectional.topEnd,
          children: [
            Image.asset(
              '$baseUrl/${selected ? "TILE_1_SEL" : "TILE_1"}.png',
            ),
            Image.asset('$baseUrl/$type.png'),
          ],
        ));
  }
}
