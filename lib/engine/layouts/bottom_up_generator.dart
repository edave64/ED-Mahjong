import 'dart:math';

import 'package:ed_mahjong/engine/layouts/layout.dart';
import 'package:ed_mahjong/engine/layouts/layout_precalc.dart';
import 'package:ed_mahjong/engine/pieces/game_board.dart';
import 'package:ed_mahjong/engine/pieces/mahjong_tile.dart';

import 'infinite_tile_supply.dart';

/// Creates a new game board from the layout.
/// Caution! This method will fail sometimes. Actually, it fails more often
/// than it works. Run this in a loop until it works. (64 times should be more
/// than enough plenty)
GameBoard makeBoard(Layout layout, LayoutPrecalc precalc,
    [Iterator<MahjongTile>? tileSupply]) {
  // A new, empty board
  final List<MahjongTile?> tiles =
      List.generate(precalc.idxLength(), (_) => null, growable: false);

  final Set<int> placeableCoordinates =
      Set.of(Iterable.generate(precalc.idxLength(), (idx) => idx));
  final Set<int> blockedCoordinates = Set();

  final random = Random();
  if (tileSupply == null) {
    tileSupply = InfiniteTileSupply(random);
  }

  final maxTileNum = precalc.idxLength();
  final int pairs = (maxTileNum / 2).floor();

  for (var currentPairNr = 0; currentPairNr < pairs; ++currentPairNr) {
    tileSupply.moveNext();
    MahjongTile tile = tileSupply.current;

    final pos = _placeTile(tiles, placeableCoordinates, random, tile);
    final neighbors = getNeighbors(pos, precalc);
    blockedCoordinates.remove(pos);

    _markRowNotPlacable(neighbors, tiles, pos, precalc, blockedCoordinates,
        placeableCoordinates);

    tileSupply.moveNext();
    MahjongTile tile2 = tileSupply.current;
    final tilePos2 = _placeTile(tiles, placeableCoordinates, random, tile2);
    final tile2neighbors = getNeighbors(tilePos2, precalc);

    _markRowNotPlacable(tile2neighbors, tiles, tilePos2, precalc,
        blockedCoordinates, placeableCoordinates);
    blockedCoordinates.remove(tilePos2);

    _markNeighborsPlaceable(
        neighbors, tiles, pos, precalc, placeableCoordinates);
    _markNeighborsPlaceable(
        tile2neighbors, tiles, tilePos2, precalc, placeableCoordinates);

    final onTop = precalc.above[pos].union(precalc.above[tilePos2]);

    _markTopTilesPlaceable(
        onTop, tiles, precalc, blockedCoordinates, placeableCoordinates);
  }

  return GameBoard(_toXYZGrid(layout, precalc, tiles));
}

List<List<List<MahjongTile?>>> _toXYZGrid(
    Layout layout, LayoutPrecalc precalc, List<MahjongTile?> tiles) {
  return List.generate(layout.depth, (z) {
    return List.generate(layout.height, (y) {
      return List.generate(layout.width, (x) {
        var idx = precalc.coordToIdx(Coordinate(x, y, z));
        if (idx != -1) {
          return tiles[idx];
        }
        return null;
      });
    });
  });
}

int _placeTile(List<MahjongTile?> tiles, Set<int> placeableCoordinates,
    Random random, MahjongTile tile) {
  final pos = placeableCoordinates
      .elementAt(random.nextInt(placeableCoordinates.length));
  placeableCoordinates.remove(pos);

  if (tiles[pos] != null) {
    throw Exception("Tried to set one tile twice");
  }
  tiles[pos] = tile;
  return pos;
}

/// When a tile is placed, the tiles above might become placeable if:
/// - All tiles below them are placed
/// - They are either:
///   - Allow in their row
///   - A direct neighbor of already placed tiles
void _markTopTilesPlaceable(
    Set<int> onTop,
    List<MahjongTile?> tiles,
    LayoutPrecalc precalc,
    Set<int> blockedCoordinates,
    Set<int> placeableCoordinates) {
  for (var posOnTop in onTop) {
    if (tiles[posOnTop] != null) continue;

    final below = precalc.below[posOnTop];
    final allBelowArePlaced = below.every((coord) => tiles[coord] != null);

    if (!allBelowArePlaced) continue;

    final isOnBlockedRow = blockedCoordinates.contains(posOnTop);

    if (isOnBlockedRow) {
      final free = _allInDirectionNotBlocked(
              precalc, posOnTop, Direction.Left, blockedCoordinates, tiles) ||
          _allInDirectionNotBlocked(
              precalc, posOnTop, Direction.Right, blockedCoordinates, tiles);

      if (!free) continue;
    }

    placeableCoordinates.add(posOnTop);
  }
}

/// At the beginning of board generation, we mark every element on bottom layer
/// as a valid target. However, if a tile is placed, every indirect neighbor has
/// to be set as not placeable. Otherwise, free tiles might become trapped
/// between already placed tiles, which wouldn't be a solvable board state.
void _markRowNotPlacable(
    Set<int> neighbors,
    List<MahjongTile?> tiles,
    int pos,
    LayoutPrecalc precalc,
    Set<int> blockedCoordinates,
    Set<int> placeableCoordinates) {
  final placedNeighbors = neighbors.where((coord) => tiles[coord] != null);

  // If there aren't any neighbors already placed, that means this is the
  // first tile on this row. Every direct or indirect neighbor must be set
  // invalid
  if (placedNeighbors.isEmpty) {
    _markRowInvalid(
        pos, precalc, blockedCoordinates, placeableCoordinates, Direction.Left);
    _markRowInvalid(pos, precalc, blockedCoordinates, placeableCoordinates,
        Direction.Right);
  }
}

/// Once a tile is placed, its direct neighbors become placable
void _markNeighborsPlaceable(Set<int> neighbors, List<MahjongTile?> tiles,
    int pos, LayoutPrecalc precalc, Set<int> placeableCoordinates) {
  final coord = precalc.idxToCoordinate(pos);
  for (final validNeighbor in neighbors) {
    if (tiles[validNeighbor] != null) continue;
    final neighborCoord = precalc.idxToCoordinate(validNeighbor);
    final checkDir =
        neighborCoord.x < coord.x ? Direction.Right : Direction.Left;
    final allInDirectionFree = _allInDirectionFree(
        precalc, validNeighbor, checkDir, pos, placeableCoordinates, tiles);
    if (allInDirectionFree) {
      placeableCoordinates.add(validNeighbor);
    }
  }
}

bool _allInDirectionNotBlocked(LayoutPrecalc precalc, int validNeighbor,
    Direction checkDir, Set<int> blockedCoordinates, List<MahjongTile?> tiles) {
  final validSubNeighbors = getNeighbors(validNeighbor, precalc, checkDir);
  final allInDirectionFree = validSubNeighbors.every(
      (coord) => !blockedCoordinates.contains(coord) || tiles[coord] != null);
  return allInDirectionFree;
}

bool _allInDirectionFree(
    LayoutPrecalc precalc,
    int validNeighbor,
    Direction checkDir,
    int pos,
    Set<int> placeableCoordinates,
    List<MahjongTile?> tiles) {
  final validSubNeighbors = getNeighbors(validNeighbor, precalc, checkDir);
  validSubNeighbors.remove(pos);
  final allInDirectionFree = validSubNeighbors.every(
      (coord) => placeableCoordinates.contains(coord) || tiles[coord] != null);
  return allInDirectionFree;
}

enum Direction { Left, Right, Both }

void _markRowInvalid(int coord, LayoutPrecalc precalc,
    Set<int> blockedCoordinates, Set<int> placeableCoordinates, Direction dir) {
  final neighbors = getNeighbors(coord, precalc, dir);
  final validNeighbors = neighbors.intersection(placeableCoordinates);

  final notAlreadyBlocked =
      neighbors.where((coord) => !blockedCoordinates.contains(coord));

  placeableCoordinates.removeAll(validNeighbors);
  blockedCoordinates.addAll(notAlreadyBlocked);
  placeableCoordinates.removeAll(notAlreadyBlocked);

  for (var recCoord in validNeighbors) {
    _markRowInvalid(
        recCoord, precalc, blockedCoordinates, placeableCoordinates, dir);
  }
}

Set<int> getNeighbors(int coord, LayoutPrecalc precalc,
    [Direction dir = Direction.Both]) {
  if (dir == Direction.Left) return precalc.neighborsLeft[coord];
  if (dir == Direction.Right) return precalc.neighborsRight[coord];
  return precalc.neighborsLeft[coord].union(precalc.neighborsRight[coord]);
}
