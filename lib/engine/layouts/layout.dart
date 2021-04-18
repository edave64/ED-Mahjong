import 'dart:collection';
import 'dart:math';

import 'package:flutter_app/engine/pieces/game_board.dart';
import 'package:flutter_app/engine/pieces/mahjong_tile.dart';
import 'package:quiver/core.dart';

class Layout {
  final List<List<List<bool>>> _pieces;
  final int depth;
  final int height;
  final int width;
  Layout(this._pieces)
      : depth = _pieces.length,
        height = _pieces[0].length,
        width = _pieces[0][0].length;

  GameBoard makeBoard() {
    final List<List<List<MahjongTile?>>> tiles = List.generate(
        depth, (_) => List.generate(height, (_) => List.filled(width, null)));
    final Set<_Coordinate> placeableCoordinates = Set();
    final Set<_Coordinate> blockedCoordinates = Set();
    final maxTileNum = _pieces.fold<int>(0, (previousValue, element) {
      return previousValue +
          element.fold<int>(0, (previousValue, element) {
            return previousValue +
                element.fold<int>(0, (previousValue, element) {
                  return previousValue + (element ? 1 : 0);
                });
          });
    });

    // Init: From the start, every tile at the bottom layer is available
    for (var y = 0; y < height; ++y) {
      for (var x = 0; x < width; ++x) {
        if (_pieces[0][y][x]) {
          placeableCoordinates.add(new _Coordinate(x, y, 0));
        }
      }
    }

    final tileSupply = _InfiniteTileSupply();
    MahjongTile? nextTile;
    final random = Random();

    //try {
    for (var currentTileNr = 0; currentTileNr < maxTileNum; ++currentTileNr) {
      MahjongTile tile;
      if (nextTile != null) {
        tile = nextTile;
        nextTile = null;
      } else {
        tile = tileSupply.next();
        // Make sure a matching tile is placed next
        nextTile = tile;
      }

      final pos = placeableCoordinates
          .elementAt(random.nextInt(placeableCoordinates.length));
      placeableCoordinates.remove(pos);

      if (tiles[pos.z][pos.y][pos.x] != null) {
        throw Exception("Tried to set one tile twice");
      }
      tiles[pos.z][pos.y][pos.x] = tile;

      final neighbors = getNeighbors(pos, this);
      final placedNeighbors =
          neighbors.where((coord) => tiles[coord.z][coord.y][coord.x] != null);

      // If there aren't any neighbors already placed, that means this is the
      // first tile on this row. Every direct or indirect neighbor must be set
      // invalid
      if (placedNeighbors.isEmpty) {
        _markRowInvalid(pos, this, placeableCoordinates, _Direction.Left);
        _markRowInvalid(pos, this, placeableCoordinates, _Direction.Right);
        _markRowBlocked(pos, this, blockedCoordinates, placeableCoordinates,
            _Direction.Left);
        _markRowBlocked(pos, this, blockedCoordinates, placeableCoordinates,
            _Direction.Right);
      }

      blockedCoordinates.remove(pos);

      for (final validNeighbor in neighbors) {
        // Mark any free neighboring tiles as available
        // Solve this situation:

        // +-++-+
        // |E||P|+-+    E - Existing, was there before
        // +-++-+|T|    P - Currently placed
        // |B||B|+-+    B - Blocked by gap prevention
        // +-++-+       T - Target

        // The lower lane is already reserved, so T can't be made available

        if (tiles[validNeighbor.z][validNeighbor.y][validNeighbor.x] != null)
          continue;
        final checkDir =
            validNeighbor.x < pos.x ? _Direction.Right : _Direction.Left;
        final allInDirectionFree = _allInDirectionFree(
            this, validNeighbor, checkDir, pos, placeableCoordinates, tiles);
        if (allInDirectionFree) {
          placeableCoordinates.add(validNeighbor);
        }
      }

      final onTop = getNeighborsInLayer(pos, this, 1);

      for (var posOnTop in onTop) {
        if (tiles[posOnTop.z][posOnTop.y][posOnTop.x] != null) continue;

        final below = getNeighborsInLayer(posOnTop, this, -1);
        final allBelowArePlaced =
            below.every((coord) => tiles[coord.z][coord.y][coord.x] != null);

        if (!allBelowArePlaced) continue;

        final isOnBlockedRow = blockedCoordinates.contains(posOnTop);

        if (isOnBlockedRow) {
          final free = _allInDirectionNotBlocked(
                  this, posOnTop, _Direction.Left, blockedCoordinates, tiles) ||
              _allInDirectionNotBlocked(
                  this, posOnTop, _Direction.Right, blockedCoordinates, tiles);

          if (!free) continue;
        }

        placeableCoordinates.add(posOnTop);
      }

      // Then check if the tiles above can be made available
    }

    if (nextTile != null)
      throw Exception("Error during board generation: Leftover tile");
    //} catch (e, stack) {
    //  print(e);
    //  print(stack);
    //  _printBoard(this, tiles, placeableCoordinates);
    //}

    return GameBoard(tiles);
  }
}

bool _allInDirectionNotBlocked(
    Layout layout,
    _Coordinate validNeighbor,
    _Direction checkDir,
    Set<_Coordinate> blockedCoordinates,
    List<List<List<MahjongTile?>>> tiles) {
  final validSubNeighbors = getNeighbors(validNeighbor, layout, checkDir);
  final allInDirectionFree = validSubNeighbors.every((coord) =>
      !blockedCoordinates.contains(coord) ||
      tiles[coord.z][coord.y][coord.x] != null);
  return allInDirectionFree;
}

bool _allInDirectionFree(
    Layout layout,
    _Coordinate validNeighbor,
    _Direction checkDir,
    _Coordinate pos,
    Set<_Coordinate> placeableCoordinates,
    List<List<List<MahjongTile?>>> tiles) {
  final validSubNeighbors = getNeighbors(validNeighbor, layout, checkDir);
  validSubNeighbors.remove(pos);
  final allInDirectionFree = validSubNeighbors.every((coord) =>
      placeableCoordinates.contains(coord) ||
      tiles[coord.z][coord.y][coord.x] != null);
  return allInDirectionFree;
}

enum _Direction { Left, Right, Both }

void _markRowInvalid(_Coordinate coord, Layout layout,
    Set<_Coordinate> validCoordinates, _Direction dir) {
  final neighbors = getNeighbors(coord, layout, dir);
  final validNeighbors = validCoordinates.intersection(neighbors);
  validCoordinates.removeAll(validNeighbors);
  for (var recCoord in validNeighbors) {
    _markRowInvalid(recCoord, layout, validCoordinates, dir);
  }
}

void _markRowBlocked(
    _Coordinate coord,
    Layout layout,
    Set<_Coordinate> blockedCoordinates,
    Set<_Coordinate> validCoordinates,
    _Direction dir) {
  final neighbors = getNeighbors(coord, layout, dir);
  final notAlreadyBlocked =
      neighbors.where((coord) => !blockedCoordinates.contains(coord));
  blockedCoordinates.addAll(notAlreadyBlocked);
  validCoordinates.removeAll(notAlreadyBlocked);
  for (var recCoord in notAlreadyBlocked) {
    _markRowBlocked(
        recCoord, layout, blockedCoordinates, validCoordinates, dir);
  }
}

Set<_Coordinate> getNeighborsInLayer(
    _Coordinate coord, Layout layout, int dir) {
  final List<_Coordinate> ret = [];
  final maxX = layout.width - 1;
  final maxY = layout.height - 1;
  final maxZ = layout.depth - 1;
  if (coord.z >= maxZ) return {};

  final targetZ = coord.z + dir;

  ret.add(_Coordinate(coord.x, coord.y, targetZ));

  if (coord.y > 0) {
    ret.add(_Coordinate(coord.x, coord.y - 1, targetZ));
  }
  if (coord.y < maxY) {
    ret.add(_Coordinate(coord.x, coord.y + 1, targetZ));
  }

  if (coord.x > 0) {
    ret.add(_Coordinate(coord.x - 1, coord.y, targetZ));
    if (coord.y > 0) ret.add(_Coordinate(coord.x - 1, coord.y - 1, targetZ));
    if (coord.y < maxY) ret.add(_Coordinate(coord.x - 1, coord.y + 1, targetZ));
  }
  if (coord.x < maxX) {
    ret.add(_Coordinate(coord.x + 1, coord.y, targetZ));
    if (coord.y > 0) ret.add(_Coordinate(coord.x + 1, coord.y - 1, targetZ));
    if (coord.y < maxY) ret.add(_Coordinate(coord.x + 1, coord.y + 1, targetZ));
  }

  return Set.from(
      ret.where((coord) => layout._pieces[coord.z][coord.y][coord.x]));
}

Set<_Coordinate> getNeighbors(_Coordinate coord, Layout layout,
    [_Direction dir = _Direction.Both]) {
  final List<_Coordinate> ret = [];
  final maxY = layout.height - 1;
  if (coord.x - 2 >= 0 && (dir == _Direction.Both || dir == _Direction.Left)) {
    ret.add(_Coordinate(coord.x - 2, coord.y, coord.z));
    if (coord.y > 0) ret.add(_Coordinate(coord.x - 1, coord.y - 1, coord.z));
    if (coord.y < maxY) ret.add(_Coordinate(coord.x - 1, coord.y + 1, coord.z));
  }
  if (coord.x < layout.width - 2 &&
      (dir == _Direction.Both || dir == _Direction.Right)) {
    ret.add(_Coordinate(coord.x + 2, coord.y, coord.z));
    if (coord.y > 0) ret.add(_Coordinate(coord.x + 2, coord.y - 1, coord.z));
    if (coord.y < maxY) ret.add(_Coordinate(coord.x + 2, coord.y + 1, coord.z));
  }

  return Set.from(
      ret.where((coord) => layout._pieces[coord.z][coord.y][coord.x]));
}

class _InfiniteTileSupply {
  Queue<MahjongTile> tileQueue = _makeQueue();

  MahjongTile next() {
    if (tileQueue.isEmpty) tileQueue = _makeQueue();
    return tileQueue.removeFirst();
  }

  static Queue<MahjongTile> _makeQueue() {
    var tileQueue = List.from(MahjongTile.values);
    tileQueue.shuffle();
    return Queue.from(tileQueue);
  }
}

class _Coordinate {
  final int x;
  final int y;
  final int z;

  const _Coordinate(this.x, this.y, this.z);

  bool operator ==(Object other) {
    return other is _Coordinate && x == other.x && y == other.y && z == other.z;
  }

  int get hashCode => hash3(x, y, z);
}
