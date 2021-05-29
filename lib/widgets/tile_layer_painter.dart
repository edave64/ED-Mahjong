import 'package:ed_mahjong/engine/layouts/layout.dart';
import 'package:ed_mahjong/engine/layouts/layout_meta.dart';
import 'package:ed_mahjong/engine/pieces/mahjong_tile.dart';
import 'package:ed_mahjong/engine/tileset/tileset_meta.dart';
import 'package:ed_mahjong/engine/tileset/tileset_renderer.dart';
import 'package:flutter/material.dart';

typedef void Selected(int x, int y, int z);

class TileLayerPainter extends StatelessWidget {
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

  TileLayerPainter({
    Key? key,
    required this.tiles,
    required this.meta,
    required this.tileset,
    required this.renderer,
    required this.z,
    required this.movable,
    required this.highlightMovables,
    this.selectedX,
    this.selectedY,
    this.onSelected,
  })  : height = tiles.length,
        width = tiles[0].length,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<Positioned> childTiles = [];
    final painter = TileLayerPainterPainter(this);

    final size = tileset.getLayoutSize(width, height);
    return GestureDetector(
        onTapUp: (details) {
          final pos = details.localPosition;
          final tile = painter.tileHitDetect(pos.dx, pos.dy);
          final onSelected = this.onSelected;
          if (onSelected != null && tile != null)
            onSelected(tile.x, tile.y, tile.z);
        },
        child: CustomPaint(
          size: Size(size.x, size.y),
          painter: painter,
        ));
  }
}

class TileLayerPainterPainter extends CustomPainter {
  final TileLayerPainter widget;
  final int tileCount;
  final int? selectedX;
  final int? selectedY;

  TileLayerPainterPainter(this.widget)
      : tileCount = widget.tiles.fold(
            0,
            (previousValue, row) =>
                previousValue +
                row.fold(
                    0,
                    (previousValue, element) =>
                        previousValue + (element == null ? 0 : 1))),
        selectedX = widget.selectedX,
        selectedY = widget.selectedY;

  @override
  void paint(Canvas canvas, Size size) {
    final noPaint = Paint();
    noPaint.filterQuality = FilterQuality.high;
    final renderer = widget.renderer;
    final tiles = widget.tiles;
    final tileset = widget.tileset;

    final shadowXOffset =
        (tileset.tileWidth - tileset.tileFaceWidth - tileset.levelOffsetX);

    for (var drawCoord in tileDrawOrder(widget.height, widget.width)) {
      final x = drawCoord.x;
      final y = drawCoord.y;
      final tile = tiles[y][x];
      if (tile == null) continue;

      final baseXPos = tileset.halfTileW * x * 1.0;
      final baseYPos = tileset.halfTileH * y * 1.0;
      final coord = Coordinate(x, y, widget.z);
      final movable = widget.movable.contains(coord);
      final selected = selectedX == x && selectedY == y;
      final darken = widget.highlightMovables && !movable;

      canvas.drawImage(
          selected
              ? renderer.tileSel
              : darken
                  ? renderer.tileDark
                  : renderer.tile,
          Offset(baseXPos, baseYPos),
          noPaint);
      canvas.drawImage(
          renderer.faceImg[tile]!,
          Offset(baseXPos + shadowXOffset + tileset.levelOffsetX, baseYPos),
          noPaint);
    }
  }

  @override
  bool shouldRepaint(TileLayerPainterPainter oldDelegate) =>
      oldDelegate.tileCount != this.tileCount ||
      oldDelegate.selectedX != this.selectedX ||
      oldDelegate.selectedY != this.selectedY;

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

  @override
  bool? hitTest(Offset position) {
    final tileCoord = tileHitDetect(position.dx, position.dy);
    return tileCoord != null;
  }

  Coordinate? tileHitDetect(double x, double y) {
    final tileset = widget.tileset;
    final tileFaceOffsetX = tileset.tileWidth - tileset.tileFaceWidth;
    final tileFaceOffsetY = tileset.tileHeight - tileset.tileFaceHeight;

    final gridX = _between(
        0, (x - tileFaceOffsetX) / tileset.halfTileW, widget.width - 1);
    final gridY = _between(0, y / tileset.halfTileH, widget.height - 1);

    final tileXIdx = gridX.floor();
    final tileYIdx = gridY.floor();

    final coord = has({
      Coord2D(tileXIdx, tileYIdx),
      Coord2D(tileXIdx, tileYIdx - 1),
      Coord2D(tileXIdx - 1, tileYIdx),
      Coord2D(tileXIdx - 1, tileYIdx - 1)
    });

    if (coord != null) {
      return Coordinate(coord.x, coord.y, widget.z);
    }

    final leftCoord = has({
      Coord2D(tileXIdx + 1, tileYIdx),
      Coord2D(tileXIdx + 1, tileYIdx - 1),
    });

    if (leftCoord != null &&
        (leftCoord.x * tileset.halfTileW + tileFaceOffsetX) - x <=
            tileset.levelOffsetX) {
      return Coordinate(leftCoord.x, leftCoord.y, widget.z);
    }

    final upperCoord = has({
      Coord2D(tileXIdx, tileYIdx - 2),
      Coord2D(tileXIdx - 1, tileYIdx - 2),
    });

    if (upperCoord != null &&
        y - (upperCoord.y * tileset.halfTileH) - tileset.tileFaceHeight <=
            tileset.levelOffsetY) {
      return Coordinate(upperCoord.x, upperCoord.y, widget.z);
    }

    final cornerCoord = has({
      Coord2D(tileXIdx + 1, tileYIdx - 2),
    });

    if (cornerCoord != null &&
        (cornerCoord.x * tileset.halfTileW + tileFaceOffsetX) - x <=
            tileset.levelOffsetX &&
        y - (cornerCoord.y * tileset.halfTileH) - tileset.tileFaceHeight <=
            tileset.levelOffsetY) {
      return Coordinate(cornerCoord.x, cornerCoord.y, widget.z);
    }

    return null;
  }

  Coord2D? has(Set<Coord2D> coords) {
    final tiles = widget.tiles;
    for (var coord in coords) {
      if (coord.x < 0 || coord.x >= widget.width) continue;
      if (coord.y < 0 || coord.y >= widget.width) continue;
      if (tiles[coord.y][coord.x] != null) {
        return coord;
      }
    }
    return null;
  }

  double _between(double min, double val, double max) {
    if (val < min) return min;
    if (val > max) return max;
    return val;
  }
}

class Coord2D {
  final int x;
  final int y;

  const Coord2D(this.x, this.y);
}
