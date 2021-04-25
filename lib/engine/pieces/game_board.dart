import 'package:flutter_app/engine/layouts/layout.dart';
import 'package:flutter_app/engine/layouts/layout_precalc.dart';
import 'package:flutter_app/engine/pieces/mahjong_tile.dart';

typedef void Update(List<List<List<MahjongTile?>>> tiles);

class GameBoard {
  final List<List<List<MahjongTile?>>> _tiles;
  final int depth;
  final int height;
  final int width;
  GameBoard(this._tiles)
      : depth = _tiles.length,
        height = _tiles[0].length,
        width = _tiles[0][0].length;

  List<List<List<MahjongTile?>>>? _readonlyCache;
  Layout? _layoutCache;
  LayoutPrecalc? _precalcCache;
  Set<Coordinate>? _movableCache;

  List<List<List<MahjongTile?>>> get tiles {
    var cache = _readonlyCache;
    if (cache == null) {
      cache = _readonlyCache = List.unmodifiable(_tiles.map((layer) =>
          List.unmodifiable(layer
                  .map((row) => List.unmodifiable(row).cast<MahjongTile?>()))
              .cast<List<MahjongTile?>>())).cast<List<List<MahjongTile?>>>();
    }
    return cache;
  }

  void _rebuildLayouts() {
    var tiles = _tiles
        .map((layer) => layer
            .map((row) =>
                row.map((tile) => tile != null).toList(growable: false))
            .toList(growable: false))
        .toList(growable: false);
    _layoutCache = Layout(tiles);
    _precalcCache = LayoutPrecalc(layout, tiles);
  }

  Layout get layout {
    if (_layoutCache == null) {
      _rebuildLayouts();
    }
    return _layoutCache!;
  }

  LayoutPrecalc get precalc {
    if (_precalcCache == null) {
      _rebuildLayouts();
    }
    return _precalcCache!;
  }

  Set<Coordinate> get movable {
    var cache = _movableCache;
    if (cache == null) {
      final tiles = this._tiles;
      final width = this.width;
      final height = this.height;
      final depth = this.depth;
      _movableCache = cache = {};
      for (var x = 0; x < width; ++x) {
        for (var y = 0; y < height; ++y) {
          for (var z = 0; z < depth; ++z) {
            if (tiles[z][y][x] == null) continue;

            final coord = Coordinate(x, y, z);
            final idx = precalc.coordToIdx(coord);
            final onTop = precalc.above[idx];
            if (onTop.isNotEmpty) continue;

            final left = precalc.neighborsLeft[idx];
            final right = precalc.neighborsRight[idx];

            if (left.isNotEmpty && right.isNotEmpty) continue;
            cache.add(coord);
          }
        }
      }
    }
    return cache;
  }

  Set<MapEntry<Coordinate, Coordinate>> get matchable {
    final moveable = this.movable;
    final tiles = this.tiles;
    Map<MahjongTile, List<Coordinate>> byType = {};
    for (var coord in moveable) {
      final tile = tiles[coord.z][coord.y][coord.x]!;
      byType.putIfAbsent(tile, () => []).add(coord);
    }

    final Set<MapEntry<Coordinate, Coordinate>> ret = {};
    for (var coords in byType.values) {
      if (coords.length == 1) continue;
      for (var i = 0; i < coords.length - 1; ++i) {
        for (var j = i + 1; i < coords.length; ++i) {
          ret.add(MapEntry(coords[i], coords[j]));
        }
      }
    }
    return ret;
  }

  void update(Update updater) {
    updater(_tiles);
    _readonlyCache = null;
    _precalcCache = null;
    _movableCache = null;
    _layoutCache = null;
  }
}
