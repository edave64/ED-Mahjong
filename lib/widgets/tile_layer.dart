import 'package:ed_mahjong/engine/layouts/layout.dart';
import 'package:ed_mahjong/engine/layouts/layout_meta.dart';
import 'package:ed_mahjong/engine/pieces/mahjong_tile.dart';
import 'package:ed_mahjong/engine/tileset/tileset_meta.dart';
import 'package:ed_mahjong/engine/tileset/tileset_renderer.dart';
import 'package:ed_mahjong/widgets/tile.dart';
import 'package:flutter/material.dart';

typedef void Selected(int x, int y, int z);

class TileLayer extends StatelessWidget {
  final LayoutMeta meta;
  final List<List<MahjongTile?>> tiles;
  final int width;
  final int height;
  final TilesetMeta tileset;
  final TilesetRenderer renderer;
  final int z;
  final int? selectedX;
  final int? selectedY;
  final Selected? onSelected;
  final Set<Coordinate> movable;
  final bool highlightMovables;

  TileLayer({
    Key? key,
    required this.tiles,
    required this.meta,
    required this.tileset,
    required this.z,
    required this.movable,
    required this.highlightMovables,
    required this.renderer,
    this.selectedX,
    this.selectedY,
    this.onSelected,
  })  : height = tiles.length,
        width = tiles[0].length,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<Positioned> childTiles = [];

    for (var coord2D in tileDrawOrder(height, width)) {
      final tile = tiles[coord2D.y][coord2D.x];
      if (tile == null) continue;
      final coord3D = Coordinate(coord2D.x, coord2D.y, z);
      final pos = tileset.getPixelPos(coord2D);

      childTiles.add(Positioned(
          left: pos.x,
          top: pos.y,
          child:
              makeTile(coord2D.x, coord2D.y, tile, movable.contains(coord3D))));
    }

    final size = tileset.getLayoutSize(width, height);
    return SizedBox(
        width: size.x, height: size.y, child: Stack(children: childTiles));
  }

  Widget makeTile(int x, int y, MahjongTile tile, bool movable) {
    var tileW = Tile(
      tilesetMeta: tileset,
      selected: selectedX == x && selectedY == y,
      type: tile,
      dark: highlightMovables && !movable,
      onTap: movable
          ? () {
              final selected = onSelected;
              if (selected != null) selected(x, y, z);
            }
          : null,
    );
    if (!movable) {
      return IgnorePointer(child: tileW);
    }
    return tileW;
  }

  Iterable<Coord2D> tileDrawOrder(int height, int width) sync* {
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
      yield Coord2D(width - x - 1, y);
    }
  }
}

class Coord2D {
  final int x;
  final int y;

  const Coord2D(this.x, this.y);
}
