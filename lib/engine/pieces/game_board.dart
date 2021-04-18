import './mahjong_tile.dart';

class GameBoard {
  final List<List<List<MahjongTile?>>> tiles;
  final int depth;
  final int height;
  final int width;
  GameBoard(this.tiles)
      : depth = tiles.length,
        height = tiles[0].length,
        width = tiles[0][0].length;
}
