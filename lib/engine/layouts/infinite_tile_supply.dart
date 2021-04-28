import 'dart:math';

import 'package:ed_mahjong/engine/pieces/mahjong_tile.dart';

class InfiniteTileSupply extends Iterator<MahjongTile> {
  final Random random;
  List<MahjongTile> baseSupply = [];
  List<MahjongTile> baseFlowersSupply = [];
  List<MahjongTile> baseSeasonSupply = [];
  Iterator<MahjongTile>? tileIterator;
  List<MahjongTile>? flowerSupply;
  List<MahjongTile>? seasonSupply;
  MahjongTile? nextTile;
  MahjongTile? lastTile;

  InfiniteTileSupply(this.random,
      [List<MahjongTile> baseSupply = DefaultTileSet]) {
    baseSupply = baseSupply.map((tile) {
      if (isFlower(tile)) {
        baseFlowersSupply.add(tile);
        return MahjongTile.FLOWER_1;
      }
      if (isSeason(tile)) {
        baseSeasonSupply.add(tile);
        return MahjongTile.SEASON_1;
      }
      return tile;
    }).toList(growable: false);

    Map<MahjongTile, int> counter = {};

    for (var tile in baseSupply) {
      counter[tile] = (counter[tile] ?? 0) + 1;
    }

    for (var pair in counter.entries) {
      final half = (pair.value / 2).floor();
      for (var i = 0; i < half; ++i) {
        this.baseSupply.add(pair.key);
      }
    }
    this.baseSupply.shuffle(random);
    this.baseFlowersSupply.shuffle(random);
    this.baseSeasonSupply.shuffle(random);
  }

  Iterator<MahjongTile> _makeTileIterator() {
    var tileQueue = List.of(baseSupply);
    tileQueue.shuffle();
    return tileQueue.iterator;
  }

  @override
  // TODO: implement current
  MahjongTile get current {
    return (lastTile ?? nextTile)!;
  }

  MahjongTile _randomizeTile(MahjongTile tile) {
    if (isSeason(tile)) {
      var seasonSupply = this.seasonSupply;
      if (seasonSupply == null || seasonSupply.isEmpty) {
        seasonSupply = this.seasonSupply = baseSeasonSupply.toList();
        seasonSupply.shuffle(random);
      }
      return seasonSupply.removeLast();
    }
    if (isFlower(tile)) {
      var flowerSupply = this.flowerSupply;
      if (flowerSupply == null || flowerSupply.isEmpty) {
        flowerSupply = this.flowerSupply = baseFlowersSupply.toList();
        flowerSupply.shuffle(random);
      }
      return flowerSupply.removeLast();
    }
    return tile;
  }

  @override
  bool moveNext() {
    if (nextTile == null && lastTile != null) {
      nextTile = _randomizeTile(lastTile!);
      lastTile = null;
      return true;
    }
    if (tileIterator == null) {
      tileIterator = _makeTileIterator();
    }
    final endNotReached = tileIterator!.moveNext();
    if (!endNotReached) {
      tileIterator = _makeTileIterator();
      tileIterator!.moveNext();
    }
    lastTile = _randomizeTile(tileIterator!.current);
    nextTile = null;
    return true;
  }
}
