import 'package:ed_mahjong/engine/pieces/mahjong_tile.dart';
import 'package:ed_mahjong/engine/tileset/tileset_meta.dart';
import 'package:flutter/cupertino.dart';
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
      this.text,
      this.dark = false})
      : super(key: key);

  final MahjongTile type;
  final TilesetMeta tilesetMeta;
  final bool selected;
  final bool dark;
  final Tap? onTap;
  final String? text;

  @override
  Widget build(BuildContext context) {
    final baseUrl =
        'assets/tilesets/${basenameWithoutExtension(tilesetMeta.fileName)}';

    return tapable(
        onTap,
        Stack(
          alignment: AlignmentDirectional.topEnd,
          children: [
            darken(
              dark,
              Image.asset(
                '$baseUrl/${selected ? "TILE_1_SEL" : "TILE_1"}.png',
              ),
            ),
            Image.asset('$baseUrl/${tileToString(type)}.png'),
          ],
        ));
  }

  Widget darken(bool darken, Widget child) {
    if (!darken) return child;
    return ColorFiltered(
      child: child,
      colorFilter: darkenFilter,
    );
  }

  Widget tapable(Tap? onTap, Widget child) {
    if (onTap == null) return child;
    return GestureDetector(onTap: onTap, child: child);
  }

  static const ColorFilter darkenFilter = ColorFilter.matrix(<double>[
    0.5,
    0,
    0,
    0,
    0,
    0,
    0.5,
    0,
    0,
    0,
    0,
    0,
    0.5,
    0,
    0,
    0,
    0,
    0,
    1,
    0,
  ]);
}
