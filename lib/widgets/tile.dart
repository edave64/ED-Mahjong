import 'package:ed_mahjong/engine/pieces/mahjong_tile.dart';
import 'package:ed_mahjong/engine/tileset/tileset_meta.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';

typedef void Tap();

class Tile extends StatelessWidget {
  Tile(
      {key,
      required this.type,
      required this.tilesetMeta,
      required this.selected,
      this.onTap,
      this.text})
      : super(key: key);

  final MahjongTile type;
  final TilesetMeta tilesetMeta;
  final bool selected;
  final Tap? onTap;
  final String? text;

  @override
  Widget build(BuildContext context) {
    final baseUrl =
        'assets/tilesets/${basenameWithoutExtension(tilesetMeta.fileName)}';
    return /*Text(text ??
            "")*/
        GestureDetector(
            onTap: () {
              final tap = onTap;
              if (tap != null) tap();
            },
            child: Stack(
              alignment: AlignmentDirectional.topEnd,
              children: [
                Image.asset(
                  '$baseUrl/${selected ? "TILE_1_SEL" : "TILE_1"}.png',
                ),
                Image.asset('$baseUrl/${tileToString(type)}.png'),
              ],
            ));
  }
}
