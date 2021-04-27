import 'dart:math';

import 'package:flutter_app/engine/layouts/layout.dart';
import 'package:flutter_app/engine/layouts/layout_precalc.dart';
import 'package:flutter_app/engine/pieces/mahjong_tile.dart';

import '../pieces/game_board.dart';
import 'infinite_tile_supply.dart';

/// Creates a new game board from the layout.
GameBoard makeBoard(Layout layout, LayoutPrecalc precalc,
    [List<MahjongTile>? baseTiles]) {
  final length = precalc.idxLength();
  // A new, empty board
  List<MahjongTile?> tiles =
      List.filled(length, MahjongTile.BAMBOO_1, growable: false);
  Set<int> moveables = {};

  final random = Random();
  final tileSupply = InfiniteTileSupply(random, baseTiles ?? DefaultTileSet);

  for (var idx = 0; idx < length; ++idx) {
    if (isMovable(precalc, tiles, idx)) {
      moveables.add(idx);
    }
  }

  var steps = solve(precalc, tiles, moveables, 0, random);

  if (steps == null) throw new Exception("Unsolvable layout!");

  final List<List<List<MahjongTile?>>> finalTiles = List.generate(
      layout.depth,
      (_) =>
          List.generate(layout.height, (_) => List.filled(layout.width, null)));
  for (var i = 0; i < steps.length; i += 2) {
    tileSupply.moveNext();
    final tile1 = tileSupply.current;
    tileSupply.moveNext();
    final tile2 = tileSupply.current;
    final coord1 = precalc.idxToCoordinate(steps[i]);
    final coord2 = precalc.idxToCoordinate(steps[i + 1]);
    finalTiles[coord1.z][coord1.y][coord1.x] = tile1;
    finalTiles[coord2.z][coord2.y][coord2.x] = tile2;
  }

  return GameBoard(finalTiles);
}

List<int>? solve(LayoutPrecalc precalc, List<MahjongTile?> tiles,
    Set<int> moveables, int tilesPlaced, Random random) {
  if (tilesPlaced >= precalc.idxLength()) return [];

  final moveablesRandomized = List.from(moveables, growable: false);
  moveablesRandomized.shuffle(random);

  for (var i = 0; i < moveablesRandomized.length; ++i) {
    for (var j = i + 1; j < moveablesRandomized.length; ++j) {
      final subTiles = List.of(tiles, growable: false);
      final coord1 = moveablesRandomized[i];
      final coord2 = moveablesRandomized[j];
      subTiles[coord1] = null;
      subTiles[coord2] = null;

      final subMovables = Set.of(moveables);
      subMovables.remove(coord1);
      subMovables.remove(coord2);

      final neighbors = precalc.neighborsRight[coord1]
          .union(precalc.neighborsLeft[coord1])
          .union(precalc.below[coord1])
          .union(precalc.neighborsRight[coord2])
          .union(precalc.neighborsLeft[coord2])
          .union(precalc.below[coord2]);

      for (var nIdx in neighbors) {
        if (subTiles[nIdx] != null && isMovable(precalc, subTiles, nIdx)) {
          subMovables.add(nIdx);
        }
      }

      final ret =
          solve(precalc, subTiles, subMovables, tilesPlaced + 2, random);

      if (ret != null) {
        ret.add(coord1);
        ret.add(coord2);
        return ret;
      }
    }
  }

  // No solution found, layout is impossible.
  return null;
}

bool isMovable(LayoutPrecalc precalc, List<MahjongTile?> tiles, int idx) {
  final top = precalc.above[idx];

  final hasTop = top.any((idx) => tiles[idx] != null);
  if (hasTop) return false;

  final left = precalc.neighborsLeft[idx];
  final right = precalc.neighborsRight[idx];

  final hasLeft = left.any((idx) => tiles[idx] != null);
  final hasRight = right.any((idx) => tiles[idx] != null);

  return !hasLeft || !hasRight;
}
