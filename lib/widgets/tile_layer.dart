import 'package:flutter/material.dart';
import 'package:flutter_app/engine/layouts/layout_meta.dart';
import 'package:flutter_app/engine/pieces/mahjong_tile.dart';
import 'package:flutter_app/engine/tileset/tileset_meta.dart';
import 'package:flutter_app/widgets/tile.dart';

typedef void Selected(int x, int y, int z);

class TileLayer extends StatelessWidget {
  final LayoutMeta meta;
  final List<List<MahjongTile?>> tiles;
  final int width;
  final int height;
  final TilesetMeta tileset;
  final int z;
  final int? selectedX;
  final int? selectedY;
  final Selected? onSelected;

  TileLayer(
      {Key? key,
      required this.tiles,
      required this.meta,
      required this.tileset,
      required this.z,
      this.selectedX,
      this.selectedY,
      this.onSelected})
      : height = tiles.length,
        width = tiles[0].length,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    final halfTileW = tileset.tileFaceWidth / 2;
    final halfTileH = tileset.tileFaceHeight / 2;

    final List<Positioned> childTiles = [];

    for (var y = 0; y < height; ++y) {
      for (var x = width - 1; x >= 0; --x) {
        final tile = tiles[y][x];
        if (tile == null) continue;
        childTiles.add(Positioned(
            left: halfTileW * x,
            top: halfTileH * y,
            child: Tile(
              layoutMeta: meta,
              tilesetMeta: tileset,
              selected: selectedX == x && selectedY == y,
              type: tileToString(tile),
              x: x,
              y: y,
              onTap: (x, y) {
                final selected = onSelected;
                if (selected != null) selected(x, y, z);
              },
            )));
      }
    }

    return FittedBox(
        child: SizedBox(
            width: (halfTileW * (width + 2)) * 1.0,
            height: (halfTileH * (height + 2)) * 1.0,
            child: Stack(children: childTiles)));
  }
}
