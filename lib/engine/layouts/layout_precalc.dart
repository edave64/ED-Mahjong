import 'package:ed_mahjong/engine/layouts/layout.dart';
import 'package:ed_mahjong/engine/pieces/mahjong_tile.dart';

typedef void Update(List<List<List<MahjongTile?>>> tiles);

class LayoutPrecalc {
  final Layout layout;

  List<Coordinate> _idxToCoord = [];
  Map<Coordinate, int> _coordToIdx = {};

  List<Set<int>> neighborsLeft = [];
  List<Set<int>> neighborsRight = [];
  List<Set<int>> above = [];
  List<Set<int>> below = [];

  LayoutPrecalc(this.layout, List<List<List<bool>>> layoutPieces) {
    final width = layout.width;
    final height = layout.height;
    final depth = layout.depth;
    for (var x = 0; x < width; ++x) {
      for (var y = 0; y < height; ++y) {
        for (var z = 0; z < depth; ++z) {
          if (layoutPieces[z][y][x]) {
            final coord = Coordinate(x, y, z);
            _coordToIdx[coord] = _idxToCoord.length;
            _idxToCoord.add(coord);
          }
        }
      }
    }

    List<Set<int>> makeEmpty() {
      return List.generate(_idxToCoord.length, (idx) => Set<int>(),
          growable: false);
    }

    this.neighborsLeft = makeEmpty();
    this.neighborsRight = makeEmpty();
    this.above = makeEmpty();
    this.below = makeEmpty();

    for (var idx = 0; idx < _idxToCoord.length; ++idx) {
      final coord = _idxToCoord[idx];
      final x = coord.x;
      final y = coord.y;
      final z = coord.z;

      var lefts = ([
        coordToIdx(Coordinate(x - 2, y - 1, z)),
        coordToIdx(Coordinate(x - 2, y, z)),
        coordToIdx(Coordinate(x - 2, y + 1, z))
      ]).where((idx) => idx != -1).toSet();
      this.neighborsLeft[idx] = lefts;
      var right = ([
        coordToIdx(Coordinate(x + 2, y - 1, z)),
        coordToIdx(Coordinate(x + 2, y, z)),
        coordToIdx(Coordinate(x + 2, y + 1, z))
      ]).where((idx) => idx != -1).toSet();
      this.neighborsRight[idx] = right;
      var top = ([
        coordToIdx(Coordinate(x - 1, y - 1, z + 1)),
        coordToIdx(Coordinate(x - 1, y, z + 1)),
        coordToIdx(Coordinate(x - 1, y + 1, z + 1)),
        coordToIdx(Coordinate(x, y - 1, z + 1)),
        coordToIdx(Coordinate(x, y, z + 1)),
        coordToIdx(Coordinate(x, y + 1, z + 1)),
        coordToIdx(Coordinate(x + 1, y - 1, z + 1)),
        coordToIdx(Coordinate(x + 1, y, z + 1)),
        coordToIdx(Coordinate(x + 1, y + 1, z + 1)),
      ]).where((idx) => idx != -1).toSet();
      this.above[idx] = top;
      var bottom = ([
        coordToIdx(Coordinate(x - 1, y - 1, z - 1)),
        coordToIdx(Coordinate(x - 1, y, z - 1)),
        coordToIdx(Coordinate(x - 1, y + 1, z - 1)),
        coordToIdx(Coordinate(x, y - 1, z - 1)),
        coordToIdx(Coordinate(x, y, z - 1)),
        coordToIdx(Coordinate(x, y + 1, z - 1)),
        coordToIdx(Coordinate(x + 1, y - 1, z - 1)),
        coordToIdx(Coordinate(x + 1, y, z - 1)),
        coordToIdx(Coordinate(x + 1, y + 1, z - 1)),
      ]).where((idx) => idx != -1).toSet();
      this.below[idx] = bottom;
    }
  }

  int idxLength() {
    return _idxToCoord.length;
  }

  int coordToIdx(Coordinate coord) {
    return _coordToIdx[coord] ?? -1;
  }

  Coordinate idxToCoordinate(int idx) {
    return _idxToCoord[idx];
  }
}
