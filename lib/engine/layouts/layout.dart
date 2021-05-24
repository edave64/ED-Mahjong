import 'package:ed_mahjong/engine/layouts/layout_precalc.dart';
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

  LayoutPrecalc getPrecalc() {
    return LayoutPrecalc(this, this._pieces);
  }

  List<List<List<bool>>> get pieces {
    return unmodifiable(_pieces
        .map((layer) =>
            unmodifiable(layer.map((row) => unmodifiable(row)).toList()))
        .toList());
  }

  Layout compress() {
    int trimLeft = 0;
    int trimRight = 0;
    int trimTop = 0;
    int trimBottom = 0;
    int trimBelow = 0;
    int trimAtop = 0;

    trimLeft:
    for (; trimLeft < width; ++trimLeft) {
      for (var layer in _pieces) {
        for (var line in layer) {
          if (line[trimLeft]) break trimLeft;
        }
      }
    }

    trimRight:
    for (; trimRight < width; ++trimRight) {
      for (var layer in _pieces) {
        for (var line in layer) {
          if (line[width - 1 - trimRight]) break trimRight;
        }
      }
    }

    trimTop:
    for (; trimTop < height; ++trimTop) {
      for (var layer in _pieces) {
        final line = layer[trimTop];
        for (var cell in line) {
          if (cell) break trimTop;
        }
      }
    }

    trimBottom:
    for (; trimBottom < height; ++trimBottom) {
      for (var layer in _pieces) {
        final line = layer[height - 1 - trimBottom];
        for (var cell in line) {
          if (cell) break trimBottom;
        }
      }
    }

    trimBelow:
    for (; trimBelow < depth; ++trimBelow) {
      for (var line in _pieces[trimBelow]) {
        for (var cell in line) {
          if (cell) break trimBelow;
        }
      }
    }

    trimAtop:
    for (; trimAtop < depth; ++trimAtop) {
      for (var line in _pieces[depth - 1 - trimAtop]) {
        for (var cell in line) {
          if (cell) break trimAtop;
        }
      }
    }

    print(
        "trim (below $trimBelow) (atop $trimAtop) (top $trimTop) (bottom $trimBottom) (left $trimLeft) (right $trimRight)");
    return Layout(_pieces
        .getRange(trimBelow, depth - trimAtop)
        .map((layer) => layer
            .getRange(trimTop, height - trimBottom)
            .map((line) => line
                .getRange(trimLeft, width - trimRight)
                .toList(growable: false))
            .toList(growable: false))
        .toList(growable: false));
  }
}

List<T> unmodifiable<T>(List<T> list) {
  return List.unmodifiable(list).cast<T>();
}

class Coordinate {
  final int x;
  final int y;
  final int z;
  final int hash;

  Coordinate(this.x, this.y, this.z) : hash = hash3(x, y, z);

  bool operator ==(Object other) {
    return other is Coordinate && x == other.x && y == other.y && z == other.z;
  }

  int get hashCode => hash;
}
