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

    var x = 0;
    var y = 0;
    for (var i = 0; i < height * width; ++i) {
      if (i != 0) {
        ++x;
        --y;
        if (y < 0) {
          y = x;
          x = 0;
          if (y >= height) {
            x = y - height + 1;
            y = height - 1;
          }
        }
        if (x >= width) {
          y = x + y + 1;
          x = 0;
          if (y >= height) {
            x = y - height + 1;
            y = height - 1;
          }
        }
      }
      final xPos = width - x - 1;
      final yPos = y;
      final tile = tiles[yPos][xPos];
      if (tile == null) continue;
      childTiles.add(Positioned(
          left: halfTileW * xPos,
          top: halfTileH * yPos,
          child: Stack(children: [
            Tile(
              layoutMeta: meta,
              tilesetMeta: tileset,
              selected: selectedX == xPos && selectedY == yPos,
              type: tileToString(tile),
              x: xPos,
              y: yPos,
              text: "$i",
              onTap: (x, y) {
                final selected = onSelected;
                if (selected != null) selected(x, y, z);
              },
            ),
          ])));
    }

    return SizedBox(
        width: (halfTileW * (width + 1)) * 1.0,
        height: (halfTileH * (height + 1)) * 1.0,
        child: Stack(children: childTiles));
  }
}
